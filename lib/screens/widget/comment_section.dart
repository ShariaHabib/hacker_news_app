import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/story.dart';
import '../../providers/comments_provider.dart';
import '../../utils/convert_time.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({super.key, required this.story});
  final Story story;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Comments',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.comment),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(story.descendants.toString()),
            ),
          ],
        ),
        const Divider(
          thickness: 1,
        ),
        Consumer<CommentsProvider>(builder: (context, provider, child) {
          Future.delayed(const Duration(seconds: 2), () {
            Constants.spinLoading;
          });

          if (provider.isCommentLoading && provider.comments.isEmpty) {
            return Center(
              child: Constants.spinLoading,
            );
          }

          final parent = story.id;
          final commentList = provider.comments[parent];
          return commentList == null || commentList.isEmpty
              ? story.kids?.length == 0
                  ? const Center(
                      child: Text("No comments available."),
                    )
                  : FutureBuilder<void>(
                      future: Future.delayed(const Duration(seconds: 2)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Constants.spinLoading,
                          );
                        } else {
                          return const Center(
                            child: Text("No comments available."),
                          );
                        }
                      },
                    )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: commentList.length +
                      (commentList.length != story.kids?.length ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == commentList.length) {
                      return Constants.spinLoading;
                    }
                    return Card(
                      child: commentList[index].deleted ?? false
                          ? Center(
                              child: Text(
                                Constants.itemRemoved,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.person,
                                  size: 20,
                                ),
                                contentPadding: const EdgeInsets.all(5),
                                title:
                                    HtmlWidget(commentList[index].text ?? ""),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('by ${commentList[index].by}'),
                                    Text(Convertion.convertTime(
                                        commentList[index].time ?? 0))
                                  ],
                                ),
                              ),
                            ),
                    );
                  },
                );
        }),
      ],
    );
  }
}
