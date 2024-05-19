import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../models/story.dart';
import '../../utils/convert_time.dart';

class StoryDetails extends StatelessWidget {
  StoryDetails({super.key, required this.story});
  Story story;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '@${story.by}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        '| ${story.type}',
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    Convertion.convertTime(story.time ?? 0),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.arrow_drop_up_sharp,
                    size: 50,
                    color: Colors.green,
                  ),
                ),
                Text(
                  story.score.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            story.title ?? "",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        story.text != ""
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(
                  story.text ?? "",
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
