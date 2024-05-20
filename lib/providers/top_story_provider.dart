import 'package:flutter/material.dart';
import 'package:hacker_news_app/services/api_services.dart';

import '../models/story.dart';

class TopStoryProvider extends ChangeNotifier {
  Map<int, Story> get topStories => _topStories;
  bool get isTopStoryLoading => _isTopStoryLoading;
  bool get loadMoreTopStory => _loadMoreTopStory;

  Map<int, Story> _topStories = {};
  bool _isTopStoryLoading = false;
  bool _loadMoreTopStory = false;
  int _count = 0;
  int _currentIndex = 0;
  int _nextIndex = 10;

  List<int> topStoryIds = [];

  void setLoadMore(bool value) {
    _loadMoreTopStory = value;
    notifyListeners();
  }

  void addTopStory(Story story) {
    _topStories[story.id ?? 0] = story;
    notifyListeners();
  }

  final ApiServices _apiServices = ApiServices();

  Future<void> fetchTopStories() async {
    _isTopStoryLoading = true;
    notifyListeners();
    if (_count == 0) {
      topStoryIds = await _apiServices.getTopStories();
      _count++;
    }

    if (loadMoreTopStory) {
      _currentIndex = _nextIndex;
      _nextIndex += 15;
    }

    for (int i = _currentIndex; i < _nextIndex && i < topStoryIds.length; i++) {
      final int id = topStoryIds[i];
      if (_topStories.containsKey(id)) {
        continue;
      }
      final Map<String, dynamic> storyData = await _apiServices.getItem(id);

      final Story story = Story(
        id: storyData['id'] ?? 0,
        title: storyData['title'] ?? "",
        by: storyData['by'] ?? "",
        url: storyData['url'] ?? "",
        score: storyData['score'] ?? "",
        time: storyData['time'] ?? "",
        descendants: storyData['descendants'] ?? 0,
        kids: storyData['kids'] ?? [],
        type: storyData['type'] ?? "",
        text: storyData['text'] ?? "",
      );
      addTopStory(story);
    }
    _loadMoreTopStory = false;
    notifyListeners();
    _isTopStoryLoading = false;
    notifyListeners();
  }
}
