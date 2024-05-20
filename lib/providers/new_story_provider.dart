import 'package:flutter/material.dart';
import 'package:hacker_news_app/services/api_services.dart';
import '../models/story.dart';

class NewStoryProvider extends ChangeNotifier {
  Map<int, Story> get newStories => _newStory;
  bool get isTopStoryLoading => _isNewStoryLoading;
  bool get loadMoreNewStory => _loadMoreNewStory;

  Map<int, Story> _newStory = {};
  bool _isNewStoryLoading = false;
  bool _loadMoreNewStory = false;
  int _count = 0;
  int _currentIndex = 0;
  int _nextIndex = 10;

  List<int> newStoryIds = [];

  void setLoadMore(bool value) {
    _loadMoreNewStory = value;
    notifyListeners();
  }

  void addNewStory(Story newStory) {
    _newStory[newStory.id ?? 0] = newStory;
    print(_newStory.length);
    notifyListeners();
  }

  final ApiServices _apiServices = ApiServices();

  Future<void> fetchNewStories() async {
    _isNewStoryLoading = true;
    notifyListeners();
    if (_count == 0) {
      newStoryIds = await _apiServices.getNewStories();
      _count++;
    }

    if (loadMoreNewStory) {
      _currentIndex = _nextIndex;
      _nextIndex += 15;
    }

    for (int i = _currentIndex; i < _nextIndex && i < newStoryIds.length; i++) {
      final int id = newStoryIds[i];
      if (_newStory.containsKey(id)) {
        continue;
      }
      final Map<String, dynamic> storyData = await _apiServices.getItem(id);

      final Story newStory = Story(
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

      addNewStory(newStory);
    }
    _loadMoreNewStory = false;
    notifyListeners();
    _isNewStoryLoading = false;
    notifyListeners();
  }
}
