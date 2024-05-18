import 'package:flutter/material.dart';
import 'package:hacker_news_app/services/api_services.dart';

import '../models/story.dart';

class StoryProvider extends ChangeNotifier {
  Map<int, Story> _stories = {};

  Map<int, Story> get stories => _stories;

  bool _isTopStoryLoading = false;

  bool get isTopStoryLoading => _isTopStoryLoading;

  bool get loadMore => _loadMore;

  bool _loadMore = false;

  int _count = 0;

  int _currentIndex = 0;
  int _nextIndex = 10;

  List<int> storyIds = [];

  void setLoadMore(bool value) {
    _loadMore = value;
    notifyListeners();
  }

  void addStory(Story story) {
    _stories[story.id ?? 0] = story;
    print(_stories.length);
    notifyListeners();
  }

  ApiServices _apiServices = ApiServices();

  Future<void> fetchTopStories() async {
    print('count value, $_count');
    _isTopStoryLoading = true;
    notifyListeners();
    if (_count == 0) {
      storyIds = await _apiServices.getTopStories();
      _count++;
    }

    if (loadMore) {
      _currentIndex = _nextIndex;
      _nextIndex += 15;
    }

    for (int i = _currentIndex; i < _nextIndex && i < storyIds.length; i++) {
      final int id = storyIds[i];
      if (_stories.containsKey(id)) {
        continue;
      }
      final Map<String, dynamic> storyData = await _apiServices.getStory(id);

      // final String? imgUrl = await _apiServices.fetchImageUrl(storyData['url']);

      final Story story = Story(
        id: storyData['id'] ?? 0,
        title: storyData['title'] ?? "",
        by: storyData['by'] ?? "",
        url: storyData['url'] ?? "",
        score: storyData['score'] ?? "",
        time: storyData['time'] ?? "",
        descendants: storyData['descendants'] ?? 0,
        // kids: storyData['kids'] as List<int>? ?? [],
        type: storyData['type'] ?? "",
        imageUrl: "",
      );
      addStory(story);
      print("HEREEEEEEEE AISSSSSSSE");
      print(story.title);
    }
    print("LOOOPP end");
    _loadMore = false;
    notifyListeners();
    _isTopStoryLoading = false;
    notifyListeners();
  }
}
