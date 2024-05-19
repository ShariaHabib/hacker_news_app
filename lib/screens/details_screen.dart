import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hacker_news_app/models/story.dart';
import 'package:hacker_news_app/utils/convert_time.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/comments_provider.dart';

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
    // Fetch initial comments
    print(" LIST---------------->  ${widget.story.kids ?? []}");
    Provider.of<CommentsProvider>(context, listen: false)
        .fetchComments(widget.story.kids ?? [], widget.story.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen'),
      ),
      body: ListView(
        children: [
          _buildStoryDetails(context),
          _buildLinkPreview(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildComments(),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryDetails(BuildContext context) {
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
                        '@${widget.story.by}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        '| ${widget.story.type}',
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    Convertion.convertTime(widget.story.time ?? 0),
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
                  widget.story.score.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            widget.story.title ?? "",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        widget.story.text != ""
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(
                  widget.story.text ?? "",
                ),
              )
            : SizedBox(),
      ],
    );
  }

  Widget _buildLinkPreview(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: AnyLinkPreview(
        bodyMaxLines: 7,
        cache: Duration(days: 2),
        link: widget.story.url ?? "",
        previewHeight: MediaQuery.of(context).size.height * .50,
        errorWidget: InkWell(
          onTap: () {
            launchUrl(Uri.parse(widget.story.url ?? ""));
          },
          child: Card(
            elevation: 0,
            child: Center(
              child: Column(
                children: [
                  Image.network(
                    'https://github.com/sur950/any_link_preview/blob/master/lib/assets/giphy.gif?raw=true',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * .20,
                  ),
                  Text(
                    'Error in loading preview. Tap to open link ${widget.story.url}.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        errorImage:
            'https://github.com/sur950/any_link_preview/blob/master/lib/assets/giphy.gif?raw=true',
        errorBody:
            "Error in loading preview. Tap to open link ${widget.story.url}.",
        errorTitle: widget.story.title ?? "",
      ),
    );
  }

  Widget _buildComments() {
    return Consumer<CommentsProvider>(builder: (context, provider, child) {
      if (provider.isCommentLoading && provider.comments.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      final parent = widget.story.id;
      final commentList = provider.comments[parent];

      return commentList == null || commentList.isEmpty
          ? const Center(child: Text("No comments available."))
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: commentList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: HtmlWidget(commentList[index].text ?? ""),
                  subtitle: Text('by ${commentList[index].by}'),
                );
              },
            );
    });
  }
}
