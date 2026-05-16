import 'package:dio/dio.dart';
import 'package:nook/api/models/comment_model.dart';
import 'package:nook/api/models/login_request_model.dart';
import 'package:nook/api/models/nook_model.dart';
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
}
