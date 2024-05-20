import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/story.dart';
import 'package:hacker_news_app/screens/widget/comment_section.dart';
import 'package:provider/provider.dart';

import '../providers/comments_provider.dart';
import '../services/theme.dart';
import 'widget/link_preview.dart';
import 'widget/story_details.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({super.key, required this.story});
  final Story story;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CommentsProvider>(context, listen: false)
        .fetchComments(widget.story.kids ?? [], widget.story.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4),
            onPressed: () {
              Provider.of<ThemeService>(context, listen: false).switchTheme();
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                StoryDetails(story: widget.story),
                PreviewLink(story: widget.story),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommentSection(story: widget.story),
          ),
        ],
      ),
    );
  }
}
