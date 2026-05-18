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
