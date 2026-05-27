import 'package:dio/dio.dart';
import 'package:nook/api/models/category_model.dart';
import 'package:nook/api/models/comment_model.dart';
import 'package:nook/api/models/login_request_model.dart';
import 'package:nook/api/models/nook_member_model.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/models/nook_team_model.dart';
import 'package:nook/api/models/post_model.dart';
import 'package:nook/api/models/refresh_request_model.dart';
import 'package:nook/api/models/register_request_model.dart';
import 'package:nook/api/models/token_response_model.dart';
import 'package:nook/api/models/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'nook_api.g.dart';

@RestApi(baseUrl: '')
abstract class NookApiClient {
  factory NookApiClient(Dio dio, {String? baseUrl}) = _NookApiClient;

  //AUTH
  @POST('/auth/login')
  Future<TokenResponseModel> login(@Body() LoginRequestModel request);

  @POST('/auth/refresh')
  Future<TokenResponseModel> refresh(@Body() RefreshRequestModel request);

  @POST('/auth/register')
  Future<TokenResponseModel> register(@Body() RegisterRequestModel request);

  @POST('/auth/logout')
  Future<void> logout(@Body() RefreshRequestModel request);

  //USER SELF
  @GET('/users/me')
  Future<UserModel> getMe();

  @GET('/users/me/follows')
  Future<List<NookModel>> getMyFollows({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('/users/me/nooks')
  Future<List<NookModel>> getMyNooks({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('/users/me/posts')
  Future<List<PostModel>> getMyPosts({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('/users/me/comments')
  Future<List<CommentModel>> getMyComments({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('/users/me/reposts')
  Future<List<PostModel>> getMyReposts({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('/users/me/likes')
  Future<List<PostModel>> getMyLikes({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('/users/me/saved-posts')
  Future<List<PostModel>> getMySavedPosts({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @DELETE('/users/me/avatar')
  Future<void> deleteAvatar();

  @PATCH('/users/me')
  @MultiPart()
  Future<UserModel> updateProfile({
    @Part(name: 'username') required String username,
    @Part(name: 'bio') required String bio,
    @Part(name: 'avatar_img') MultipartFile? avatarImg,
  });

  //USERS
  @GET('/users/{user_id}')
  Future<UserModel> getUser({@Path('user_id') required String userId});

  @GET('/users/{user_id}/follows')
  Future<List<NookModel>> getUserFollows({
    @Path('user_id') required String userId,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('/users/{user_id}/posts')
  Future<List<PostModel>> getUserPosts({
    @Path('user_id') required String userId,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('/users/{user_id}/comments')
  Future<List<CommentModel>> getUserComments({
    @Path('user_id') required String userId,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('/users/{user_id}/reposts')
  Future<List<PostModel>> getUserReposts({
    @Path('user_id') required String userId,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('/users/{user_id}/likes')
  Future<List<PostModel>> getUserLikes({
    @Path('user_id') required String userId,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  //POSTS
  @GET('/posts/{post_id}')
  Future<PostModel> getPost({@Path('post_id') required String postId});

  @POST('/posts')
  @MultiPart()
  Future<void> createPost({
    @Part(name: 'nook_id') required String nookId,
    @Part(name: 'title') required String title,
    @Part(name: 'content') String? content,
    @Part(name: 'images') List<MultipartFile>? images,
  });

  @DELETE('/posts/{post_id}')
  Future<void> deletePost({@Path('post_id') required String postId});

  @POST('/posts/{post_id}/like')
  Future<void> likePost({@Path('post_id') required String postId});

  @DELETE('/posts/{post_id}/like')
  Future<void> unlikePost({@Path('post_id') required String postId});

  @POST('/posts/{post_id}/repost')
  Future<void> repostPost({@Path('post_id') required String postId});

  @DELETE('/posts/{post_id}/repost')
  Future<void> unrepostPost({@Path('post_id') required String postId});

  @POST('/posts/{post_id}/save')
  Future<void> savePost({@Path('post_id') required String postId});

  @DELETE('/posts/{post_id}/save')
  Future<void> unsavePost({@Path('post_id') required String postId});

  @POST('/posts/{post_id}/pin')
  Future<void> pinPost({@Path('post_id') required String postId});

  @DELETE('/posts/{post_id}/pin')
  Future<void> unpinPost({@Path('post_id') required String postId});

  //NOOKS
  @GET('/nooks')
  Future<List<NookModel>> searchNooks({
    @Query('prompt') required String prompt,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('/nooks/categories')
  Future<List<CategoryModel>> getNookCategories();

  @PATCH('/nooks/{nook_id}')
  @MultiPart()
  Future<NookModel> updateNook({
    @Path('nook_id') required String nookId,
    @Part(name: 'name') required String name,
    @Part(name: 'description') required String description,
    @Part(name: 'rules') required String rules,
    @Part(name: 'category_id') required String categoryId,
    @Part(name: 'avatar_img') MultipartFile? avatarImg,
  });

  @POST('/nooks')
  @MultiPart()
  Future<NookModel> createNook({
    @Part(name: 'name') required String name,
    @Part(name: 'description') required String description,
    @Part(name: 'rules') required String rules,
    @Part(name: 'category_id') required String categoryId,
    @Part(name: 'avatar_img') MultipartFile? avatarImg,
  });

  @DELETE('/nooks/{nook_id}')
  Future<void> deleteNook({@Path('nook_id') required String nookId});

  @DELETE('/nooks/{nook_id}/avatar')
  Future<void> deleteNookAvatar({@Path('nook_id') required String nookId});

  @GET('/nooks/{nook_id}')
  Future<NookModel> getNook({@Path('nook_id') required String nookId});

  @GET('/nooks/{nook_id}/posts')
  Future<List<PostModel>> getNookPosts({
    @Path('nook_id') required String nookId,
    @Query('filter') String? filter,
    @Query('prompt') String? prompt,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('/nooks/{nook_id}/pinned')
  Future<List<PostModel>> getNookPinnedPosts({
    @Path('nook_id') required String nookId,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @POST('/nooks/{nook_id}/follow')
  Future<void> followNook({@Path('nook_id') required String nookId});

  @DELETE('/nooks/{nook_id}/follow')
  Future<void> unfollowNook({@Path('nook_id') required String nookId});

  @GET('/nooks/{nook_id}/followers')
  Future<List<NookMemberModel>> getNookFollowers({
    @Path('nook_id') required String nookId,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('/nooks/{nook_id}/banned')
  Future<List<NookMemberModel>> getNookBannedFollowers({
    @Path('nook_id') required String nookId,
    @Query('limit') int? limit,
    @Query('offset') int? offset,
  });

  @GET('/nooks/{nook_id}/team')
  Future<NookTeamModel> getNookTeam({@Path('nook_id') required String nookId});

  @POST('/nooks/{nook_id}/followers/{follower_id}/ban')
  Future<void> banFollower({
    @Path('nook_id') required String nookId,
    @Path('follower_id') required String followerId,
    @Query('reason') String? reason,
  });

  @DELETE('/nooks/{nook_id}/followers/{follower_id}/ban')
  Future<void> unbanFollower({
    @Path('nook_id') required String nookId,
    @Path('follower_id') required String followerId,
  });

  @POST('/nooks/{nook_id}/followers/{follower_id}/moderator')
  Future<void> createModerator({
    @Path('nook_id') required String nookId,
    @Path('follower_id') required String followerId,
  });

  @DELETE('/nooks/{nook_id}/followers/{follower_id}/moderator')
  Future<void> deleteModerator({
    @Path('nook_id') required String nookId,
    @Path('follower_id') required String followerId,
  });
}
