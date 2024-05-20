import 'dart:ui';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class Constants {
  static String baseUrl = 'https://hacker-news.firebaseio.com/v0';
  static String topStories = '/topstories.json';
  static String newStories = '/newstories.json';
  static String item = '/item/';
  static String previewErrorImage =
      'https://github.com/sur950/any_link_preview/blob/master/lib/assets/giphy.gif?raw=true';
  static String logo = 'assets/image/logo.svg';
  static String itemRemoved = "** This item has been removed **";
  static SpinKitFadingFour spinLoading = const SpinKitFadingFour(
    color: Color.fromRGBO(239, 108, 0, 1),
    size: 50.0,
  );
}
