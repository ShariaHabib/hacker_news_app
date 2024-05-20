import 'package:flutter/material.dart';
import 'package:hacker_news_app/services/api_services.dart';
import '../models/comment.dart';

class CommentsProvider extends ChangeNotifier {
  Map<int, List<Comment>> get comments => _comments;
  bool get isCommentLoading => _isCommentLoading;

  Map<int, List<Comment>> _comments = {};
  bool _isCommentLoading = false;

  final ApiServices _apiServices = ApiServices();
  void addComment(Comment comment, int storyId) {
    if (_comments.containsKey(storyId)) {
      List<Comment> commentList = _comments[storyId]!;

      // check if comment already exists in the list
      if (!commentList.any((c) => c.id == comment.id)) {
        commentList.add(comment);
        _comments[storyId] = commentList;
      }
    } else {
      // new comment list associated with new key
      _comments[storyId] = [comment];
    }
    notifyListeners();
  }

  Future<void> fetchComments(List<dynamic> newCommentIds, int storyId) async {
    print(_comments.length.toString());

    for (int i = 0; i < newCommentIds.length; i++) {
      print(newCommentIds[i]);
    }

    if (_isCommentLoading) return;

    _isCommentLoading = true;
    notifyListeners();

    for (int i = 0; i < newCommentIds.length; i++) {
      final int id = newCommentIds[i];
      if (comments.values.any((element) => element.any((c) => c.id == id))) {
        continue;
      }

      final Map<String, dynamic> commentData = await _apiServices.getItem(id);
      final Comment comment = Comment(
        by: commentData['by'] ?? "",
        id: commentData['id'] ?? 0,
        kids: List<int>.from(commentData['kids'] ?? []),
        parent: commentData['parent'] ?? 0,
        text: commentData['text'] ?? "",
        time: commentData['time'] ?? 0,
        type: commentData['type'] ?? "",
        deleted: commentData['deleted'] ?? false,
      );

      addComment(comment, storyId);
    }
    _isCommentLoading = false;
    notifyListeners();
  }
}
