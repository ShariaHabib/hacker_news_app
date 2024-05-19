import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

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
          // color: Colors.grey,
        ),
        Consumer<CommentsProvider>(builder: (context, provider, child) {
          if (provider.isCommentLoading && provider.comments.isEmpty) {
            return const Center(
              child: SpinKitFadingFour(
                  color: Color.fromRGBO(239, 108, 0, 1), size: 50.0),
            );
          }

          final parent = story.id;
          final commentList = provider.comments[parent];

          return commentList == null || commentList.isEmpty
              ? const Center(child: Text("No comments available."))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: commentList.length,
                  itemBuilder: (context, index) {
                    print(
                        '${commentList[index].deleted} ekhaner data ${commentList[index].time}');
                    return Card(
                      child: commentList[index].deleted ?? false
                          ? const Center(
                              child: Text(
                                "** This item has been removed **",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic, fontSize: 18),
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
