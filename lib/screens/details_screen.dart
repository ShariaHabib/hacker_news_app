import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/story.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({super.key, required this.story});
  Story story;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details Screen'),
        ),
        body: Column(
          children: [
            Text(widget.story.title ?? ""),
            Text(widget.story.url ?? ""),
            Text(widget.story.by ?? ""),
            Text(widget.story.time.toString()),
          ],
        ));
  }
}
