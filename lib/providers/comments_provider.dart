import 'package:flutter/material.dart';
import 'package:hacker_news_app/services/api_services.dart';
import '../models/comment.dart';

class CommentsProvider extends ChangeNotifier {
  Map<int, List<Comment>> get comments => _comments;
  bool get isCommentLoading => _isCommentLoading;
  bool get loadMore => _loadMore;

  Map<int, List<Comment>> _comments = {};
  bool _isCommentLoading = false;
  bool _loadMore = false;
  int _currentIndex = 0;
  int _nextIndex = 10;

  final ApiServices _apiServices = ApiServices();

  void setLoadMore(bool value) {
    _loadMore = value;
    notifyListeners();
  }

  void addComment(Comment comment, int storyId) {
    if (_comments.containsKey(storyId)) {
      List<Comment> commentList = _comments[storyId]!;

      if (!commentList.any((c) => c.id == comment.id)) {
        //debug
        commentList.add(comment);
        _comments[storyId] = commentList;
        print("Added comment with id ${comment.id} to story $storyId");
      } else {
        print(
            "Comment with id ${comment.id} already exists for story $storyId");
      }
    } else {
      // debug
      _comments[storyId] = [comment];
      print(
          "Created new comment list for story $storyId and added comment with id ${comment.id}");
    }

    // debug
    _comments.forEach((storyId, commentList) {
      print(
          "Story ID: $storyId has comments: ${commentList.map((c) => c.id).toList()}");
    });

    notifyListeners();
  }

  Future<void> fetchComments(List<dynamic> newCommentIds, int storyId) async {
    print("EKHENEEEE########## $storyId");

    print(_comments.length.toString());

    for (int i = 0; i < newCommentIds.length; i++) {
      // print("EKHENEEEE##########");
      print(newCommentIds[i]);
    }

    if (_isCommentLoading) return;

    _isCommentLoading = true;
    notifyListeners();

    if (_loadMore) {
      _currentIndex = _nextIndex;
      _nextIndex += 10;
    }

    for (int i = _currentIndex;
        i < _nextIndex && i < newCommentIds.length;
        i++) {
      final int id = newCommentIds[i];
      print("comment id------>: $id");
      // print("")
      if (comments.values.any((element) => element.any((c) => c.id == id))) {
        print("DHUKEEEEEEEEEEEEEEEEEEE*************************");
        continue;
      }

      final Map<String, dynamic> commentData = await _apiServices.getItem(id);
      print("CALLED API ");
      final Comment comment = Comment(
        by: commentData['by'] ?? "",
        id: commentData['id'] ?? 0,
        kids: List<int>.from(commentData['kids'] ?? []),
        parent: commentData['parent'] ?? 0,
        text: commentData['text'] ?? "",
        time: commentData['time'] ?? 0,
        type: commentData['type'] ?? "",
      );

      addComment(comment, storyId);
    }

    _loadMore = false;
    _isCommentLoading = false;
    notifyListeners();
  }
}
