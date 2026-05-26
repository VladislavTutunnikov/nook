// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Лайков`
  String get likeCounter {
    return Intl.message('Лайков', name: 'likeCounter', desc: '', args: []);
  }

  /// `Постов`
  String get postCounter {
    return Intl.message('Постов', name: 'postCounter', desc: '', args: []);
  }

  /// `Комментариев`
  String get commentCounter {
    return Intl.message(
      'Комментариев',
      name: 'commentCounter',
      desc: '',
      args: [],
    );
  }

  /// `C Nook`
  String get withNook {
    return Intl.message('C Nook', name: 'withNook', desc: '', args: []);
  }

  /// `Посты`
  String get posts {
    return Intl.message('Посты', name: 'posts', desc: '', args: []);
  }

  /// `Комментарии`
  String get comments {
    return Intl.message('Комментарии', name: 'comments', desc: '', args: []);
  }

  /// `Репосты`
  String get reposts {
    return Intl.message('Репосты', name: 'reposts', desc: '', args: []);
  }

  /// `Лайки`
  String get likes {
    return Intl.message('Лайки', name: 'likes', desc: '', args: []);
  }

  /// `Описание`
  String get description {
    return Intl.message('Описание', name: 'description', desc: '', args: []);
  }

  /// `Тут ничего нет :(`
  String get theresNothingHere {
    return Intl.message(
      'Тут ничего нет :(',
      name: 'theresNothingHere',
      desc: '',
      args: [],
    );
  }

  /// `изменено`
  String get edited {
    return Intl.message('изменено', name: 'edited', desc: '', args: []);
  }

  /// `г.`
  String get years {
    return Intl.message('г.', name: 'years', desc: '', args: []);
  }

  /// `мес.`
  String get months {
    return Intl.message('мес.', name: 'months', desc: '', args: []);
  }

  /// `д.`
  String get days {
    return Intl.message('д.', name: 'days', desc: '', args: []);
  }

  /// `ч.`
  String get hours {
    return Intl.message('ч.', name: 'hours', desc: '', args: []);
  }

  /// `м.`
  String get minutes {
    return Intl.message('м.', name: 'minutes', desc: '', args: []);
  }

  /// `только что`
  String get justNow {
    return Intl.message('только что', name: 'justNow', desc: '', args: []);
  }

  /// `Что-то пошло не так :(`
  String get somethingWentWrong {
    return Intl.message(
      'Что-то пошло не так :(',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Сохранить`
  String get save {
    return Intl.message('Сохранить', name: 'save', desc: '', args: []);
  }

  /// `Копировать текст`
  String get copyText {
    return Intl.message(
      'Копировать текст',
      name: 'copyText',
      desc: '',
      args: [],
    );
  }

  /// `Редактировать`
  String get edit {
    return Intl.message('Редактировать', name: 'edit', desc: '', args: []);
  }

  /// `Пожаловаться`
  String get report {
    return Intl.message('Пожаловаться', name: 'report', desc: '', args: []);
  }

  /// `Удалить`
  String get delete {
    return Intl.message('Удалить', name: 'delete', desc: '', args: []);
  }

  /// `Удалить из сохраненного`
  String get removeFromSaved {
    return Intl.message(
      'Удалить из сохраненного',
      name: 'removeFromSaved',
      desc: '',
      args: [],
    );
  }

  /// `Пост сохранен`
  String get postSaved {
    return Intl.message('Пост сохранен', name: 'postSaved', desc: '', args: []);
  }

  /// `Пост удален из сохраненного`
  String get postDeletedFromSaved {
    return Intl.message(
      'Пост удален из сохраненного',
      name: 'postDeletedFromSaved',
      desc: '',
      args: [],
    );
  }

  /// `Текст скопирован`
  String get textCopied {
    return Intl.message(
      'Текст скопирован',
      name: 'textCopied',
      desc: '',
      args: [],
    );
  }

  /// `Закрепить`
  String get pin {
    return Intl.message('Закрепить', name: 'pin', desc: '', args: []);
  }

  /// `Открепить`
  String get unpin {
    return Intl.message('Открепить', name: 'unpin', desc: '', args: []);
  }

  /// `Пост закреплен`
  String get postPinned {
    return Intl.message(
      'Пост закреплен',
      name: 'postPinned',
      desc: '',
      args: [],
    );
  }

  /// `Пост откреплен`
  String get postUnpinned {
    return Intl.message(
      'Пост откреплен',
      name: 'postUnpinned',
      desc: '',
      args: [],
    );
  }

  /// `Отмена`
  String get cancel {
    return Intl.message('Отмена', name: 'cancel', desc: '', args: []);
  }

  /// `Вы действительно хотите удалить этот пост?`
  String get confirmationOfPostDeletion {
    return Intl.message(
      'Вы действительно хотите удалить этот пост?',
      name: 'confirmationOfPostDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Создать пост`
  String get createPost {
    return Intl.message('Создать пост', name: 'createPost', desc: '', args: []);
  }

  /// `Создать уголок`
  String get createNook {
    return Intl.message(
      'Создать уголок',
      name: 'createNook',
      desc: '',
      args: [],
    );
  }

  /// `Мои уголки`
  String get myNooks {
    return Intl.message('Мои уголки', name: 'myNooks', desc: '', args: []);
  }

  /// `Сохранено`
  String get saved {
    return Intl.message('Сохранено', name: 'saved', desc: '', args: []);
  }

  /// `Статистика`
  String get statistics {
    return Intl.message('Статистика', name: 'statistics', desc: '', args: []);
  }

  /// `Пригласить друзей`
  String get inviteFriends {
    return Intl.message(
      'Пригласить друзей',
      name: 'inviteFriends',
      desc: '',
      args: [],
    );
  }

  /// `Настройки`
  String get settings {
    return Intl.message('Настройки', name: 'settings', desc: '', args: []);
  }

  /// `О нас`
  String get aboutUs {
    return Intl.message('О нас', name: 'aboutUs', desc: '', args: []);
  }

  /// `Сообщить о проблеме`
  String get reportProblem {
    return Intl.message(
      'Сообщить о проблеме',
      name: 'reportProblem',
      desc: '',
      args: [],
    );
  }

  /// `Обратиться в поддержку`
  String get contactSupport {
    return Intl.message(
      'Обратиться в поддержку',
      name: 'contactSupport',
      desc: '',
      args: [],
    );
  }

  /// `Выйти из аккаунта`
  String get logout {
    return Intl.message(
      'Выйти из аккаунта',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Подписаться`
  String get follow {
    return Intl.message('Подписаться', name: 'follow', desc: '', args: []);
  }

  /// `Отписаться`
  String get unfollow {
    return Intl.message('Отписаться', name: 'unfollow', desc: '', args: []);
  }

  /// `Правила`
  String get rules {
    return Intl.message('Правила', name: 'rules', desc: '', args: []);
  }

  /// `Команда`
  String get team {
    return Intl.message('Команда', name: 'team', desc: '', args: []);
  }

  /// `Закреплено`
  String get pinned {
    return Intl.message('Закреплено', name: 'pinned', desc: '', args: []);
  }

  /// `Популярное`
  String get popular {
    return Intl.message('Популярное', name: 'popular', desc: '', args: []);
  }

  /// `Новое`
  String get fresh {
    return Intl.message('Новое', name: 'fresh', desc: '', args: []);
  }

  /// `Владелец уголка`
  String get nookOwner {
    return Intl.message(
      'Владелец уголка',
      name: 'nookOwner',
      desc: '',
      args: [],
    );
  }

  /// `Модераторы уголка`
  String get nookModerators {
    return Intl.message(
      'Модераторы уголка',
      name: 'nookModerators',
      desc: '',
      args: [],
    );
  }

  /// `Лишить прав модератора`
  String get deleteModerator {
    return Intl.message(
      'Лишить прав модератора',
      name: 'deleteModerator',
      desc: '',
      args: [],
    );
  }

  /// `Выдать права модератора`
  String get addModerator {
    return Intl.message(
      'Выдать права модератора',
      name: 'addModerator',
      desc: '',
      args: [],
    );
  }

  /// `Разблокировать`
  String get unban {
    return Intl.message('Разблокировать', name: 'unban', desc: '', args: []);
  }

  /// `Заблокировать`
  String get ban {
    return Intl.message('Заблокировать', name: 'ban', desc: '', args: []);
  }

  /// `В бане`
  String get inBan {
    return Intl.message('В бане', name: 'inBan', desc: '', args: []);
  }

  /// `Поиск...`
  String get search {
    return Intl.message('Поиск...', name: 'search', desc: '', args: []);
  }

  /// `Попробуйте найти что-нибудь`
  String get tryToFindSomething {
    return Intl.message(
      'Попробуйте найти что-нибудь',
      name: 'tryToFindSomething',
      desc: '',
      args: [],
    );
  }

  /// `Ничего не найдено...`
  String get nothingWasFound {
    return Intl.message(
      'Ничего не найдено...',
      name: 'nothingWasFound',
      desc: '',
      args: [],
    );
  }

  /// `Заголовок`
  String get header {
    return Intl.message('Заголовок', name: 'header', desc: '', args: []);
  }

  /// `Текст (необязательно)`
  String get textOptional {
    return Intl.message(
      'Текст (необязательно)',
      name: 'textOptional',
      desc: '',
      args: [],
    );
  }

  /// `Нельзя добавлять видеофайлы`
  String get youCanNotAddVideoFiles {
    return Intl.message(
      'Нельзя добавлять видеофайлы',
      name: 'youCanNotAddVideoFiles',
      desc: '',
      args: [],
    );
  }

  /// `Можно выбрать не более 10 изображений`
  String get youCanSelectUpTo10Images {
    return Intl.message(
      'Можно выбрать не более 10 изображений',
      name: 'youCanSelectUpTo10Images',
      desc: '',
      args: [],
    );
  }

  /// `Выберите уголок`
  String get chooseNook {
    return Intl.message(
      'Выберите уголок',
      name: 'chooseNook',
      desc: '',
      args: [],
    );
  }

  /// `Заголовок поста не может быть пустым`
  String get createPostTitleErrorMessage {
    return Intl.message(
      'Заголовок поста не может быть пустым',
      name: 'createPostTitleErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Необходимо выбрать уголок`
  String get createPostNookErrorMessage {
    return Intl.message(
      'Необходимо выбрать уголок',
      name: 'createPostNookErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Что-то пошло не так :( Возможно, вы заблокированы в этом уголке или вы не являетесь его участником.`
  String get createPostFailureMessage {
    return Intl.message(
      'Что-то пошло не так :( Возможно, вы заблокированы в этом уголке или вы не являетесь его участником.',
      name: 'createPostFailureMessage',
      desc: '',
      args: [],
    );
  }

  /// `Готово`
  String get done {
    return Intl.message('Готово', name: 'done', desc: '', args: []);
  }

  /// `Имя пользователя`
  String get username {
    return Intl.message(
      'Имя пользователя',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `О себе`
  String get bio {
    return Intl.message('О себе', name: 'bio', desc: '', args: []);
  }

  /// `Это имя пользователя занято`
  String get usernameAlreadyTakenError {
    return Intl.message(
      'Это имя пользователя занято',
      name: 'usernameAlreadyTakenError',
      desc: '',
      args: [],
    );
  }

  /// `Имя пользователя не может быть пустым`
  String get emptyUsernameError {
    return Intl.message(
      'Имя пользователя не может быть пустым',
      name: 'emptyUsernameError',
      desc: '',
      args: [],
    );
  }

  /// `Что то пошло не так :( Проверьте подключение к интернету.`
  String get connectionError {
    return Intl.message(
      'Что то пошло не так :( Проверьте подключение к интернету.',
      name: 'connectionError',
      desc: '',
      args: [],
    );
  }

  /// `Для аватара можно использовать только изображения`
  String get onlyImagesCanBeUsedForAvatar {
    return Intl.message(
      'Для аватара можно использовать только изображения',
      name: 'onlyImagesCanBeUsedForAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Название уголка`
  String get nookName {
    return Intl.message(
      'Название уголка',
      name: 'nookName',
      desc: '',
      args: [],
    );
  }

  /// `Правила уголка`
  String get nookRules {
    return Intl.message(
      'Правила уголка',
      name: 'nookRules',
      desc: '',
      args: [],
    );
  }

  /// `Выберите категорию`
  String get chooseCategory {
    return Intl.message(
      'Выберите категорию',
      name: 'chooseCategory',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
