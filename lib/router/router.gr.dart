// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AccountScreen]
class AccountRoute extends PageRouteInfo<AccountRouteArgs> {
  AccountRoute({
    Key? key,
    required String userId,
    List<PageRouteInfo>? children,
  }) : super(
         AccountRoute.name,
         args: AccountRouteArgs(key: key, userId: userId),
         initialChildren: children,
       );

  static const String name = 'AccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AccountRouteArgs>();
      return AccountScreen(key: args.key, userId: args.userId);
    },
  );
}

class AccountRouteArgs {
  const AccountRouteArgs({this.key, required this.userId});

  final Key? key;

  final String userId;

  @override
  String toString() {
    return 'AccountRouteArgs{key: $key, userId: $userId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AccountRouteArgs) return false;
    return key == other.key && userId == other.userId;
  }

  @override
  int get hashCode => key.hashCode ^ userId.hashCode;
}

/// generated route for
/// [AuthWrapperScreen]
class AuthWrapperRoute extends PageRouteInfo<void> {
  const AuthWrapperRoute({List<PageRouteInfo>? children})
    : super(AuthWrapperRoute.name, initialChildren: children);

  static const String name = 'AuthWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthWrapperScreen();
    },
  );
}

/// generated route for
/// [FollowedNooksScreen]
class FollowedNooksRoute extends PageRouteInfo<FollowedNooksRouteArgs> {
  FollowedNooksRoute({Key? key, String? userId, List<PageRouteInfo>? children})
    : super(
        FollowedNooksRoute.name,
        args: FollowedNooksRouteArgs(key: key, userId: userId),
        initialChildren: children,
      );

  static const String name = 'FollowedNooksRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FollowedNooksRouteArgs>(
        orElse: () => const FollowedNooksRouteArgs(),
      );
      return FollowedNooksScreen(key: args.key, userId: args.userId);
    },
  );
}

class FollowedNooksRouteArgs {
  const FollowedNooksRouteArgs({this.key, this.userId});

  final Key? key;

  final String? userId;

  @override
  String toString() {
    return 'FollowedNooksRouteArgs{key: $key, userId: $userId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FollowedNooksRouteArgs) return false;
    return key == other.key && userId == other.userId;
  }

  @override
  int get hashCode => key.hashCode ^ userId.hashCode;
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [NookFollowersScreen]
class NookFollowersRoute extends PageRouteInfo<NookFollowersRouteArgs> {
  NookFollowersRoute({
    Key? key,
    required String nookId,
    bool showBanned = false,
    List<PageRouteInfo>? children,
  }) : super(
         NookFollowersRoute.name,
         args: NookFollowersRouteArgs(
           key: key,
           nookId: nookId,
           showBanned: showBanned,
         ),
         initialChildren: children,
       );

  static const String name = 'NookFollowersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NookFollowersRouteArgs>();
      return NookFollowersScreen(
        key: args.key,
        nookId: args.nookId,
        showBanned: args.showBanned,
      );
    },
  );
}

class NookFollowersRouteArgs {
  const NookFollowersRouteArgs({
    this.key,
    required this.nookId,
    this.showBanned = false,
  });

  final Key? key;

  final String nookId;

  final bool showBanned;

  @override
  String toString() {
    return 'NookFollowersRouteArgs{key: $key, nookId: $nookId, showBanned: $showBanned}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NookFollowersRouteArgs) return false;
    return key == other.key &&
        nookId == other.nookId &&
        showBanned == other.showBanned;
  }

  @override
  int get hashCode => key.hashCode ^ nookId.hashCode ^ showBanned.hashCode;
}

/// generated route for
/// [NookRulesScreen]
class NookRulesRoute extends PageRouteInfo<NookRulesRouteArgs> {
  NookRulesRoute({
    Key? key,
    String? rules,
    required String nookName,
    List<PageRouteInfo>? children,
  }) : super(
         NookRulesRoute.name,
         args: NookRulesRouteArgs(key: key, rules: rules, nookName: nookName),
         initialChildren: children,
       );

  static const String name = 'NookRulesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NookRulesRouteArgs>();
      return NookRulesScreen(
        key: args.key,
        rules: args.rules,
        nookName: args.nookName,
      );
    },
  );
}

class NookRulesRouteArgs {
  const NookRulesRouteArgs({this.key, this.rules, required this.nookName});

  final Key? key;

  final String? rules;

  final String nookName;

  @override
  String toString() {
    return 'NookRulesRouteArgs{key: $key, rules: $rules, nookName: $nookName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NookRulesRouteArgs) return false;
    return key == other.key &&
        rules == other.rules &&
        nookName == other.nookName;
  }

  @override
  int get hashCode => key.hashCode ^ rules.hashCode ^ nookName.hashCode;
}

/// generated route for
/// [NookScreen]
class NookRoute extends PageRouteInfo<NookRouteArgs> {
  NookRoute({Key? key, required String nookId, List<PageRouteInfo>? children})
    : super(
        NookRoute.name,
        args: NookRouteArgs(key: key, nookId: nookId),
        initialChildren: children,
      );

  static const String name = 'NookRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NookRouteArgs>();
      return NookScreen(key: args.key, nookId: args.nookId);
    },
  );
}

class NookRouteArgs {
  const NookRouteArgs({this.key, required this.nookId});

  final Key? key;

  final String nookId;

  @override
  String toString() {
    return 'NookRouteArgs{key: $key, nookId: $nookId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NookRouteArgs) return false;
    return key == other.key && nookId == other.nookId;
  }

  @override
  int get hashCode => key.hashCode ^ nookId.hashCode;
}

/// generated route for
/// [NookTeamScreen]
class NookTeamRoute extends PageRouteInfo<NookTeamRouteArgs> {
  NookTeamRoute({
    Key? key,
    required String nookId,
    List<PageRouteInfo>? children,
  }) : super(
         NookTeamRoute.name,
         args: NookTeamRouteArgs(key: key, nookId: nookId),
         initialChildren: children,
       );

  static const String name = 'NookTeamRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NookTeamRouteArgs>();
      return NookTeamScreen(key: args.key, nookId: args.nookId);
    },
  );
}

class NookTeamRouteArgs {
  const NookTeamRouteArgs({this.key, required this.nookId});

  final Key? key;

  final String nookId;

  @override
  String toString() {
    return 'NookTeamRouteArgs{key: $key, nookId: $nookId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NookTeamRouteArgs) return false;
    return key == other.key && nookId == other.nookId;
  }

  @override
  int get hashCode => key.hashCode ^ nookId.hashCode;
}

/// generated route for
/// [SavedPostsScreen]
class SavedPostsRoute extends PageRouteInfo<void> {
  const SavedPostsRoute({List<PageRouteInfo>? children})
    : super(SavedPostsRoute.name, initialChildren: children);

  static const String name = 'SavedPostsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SavedPostsScreen();
    },
  );
}

/// generated route for
/// [UserNooksScreen]
class UserNooksRoute extends PageRouteInfo<void> {
  const UserNooksRoute({List<PageRouteInfo>? children})
    : super(UserNooksRoute.name, initialChildren: children);

  static const String name = 'UserNooksRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserNooksScreen();
    },
  );
}
