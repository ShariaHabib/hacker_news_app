import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news_app/providers/new_story_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/story.dart';
import '../utils/convert_time.dart';
import 'details_screen.dart';

class NewStories extends StatefulWidget {
  const NewStories({super.key});

  @override
  State<NewStories> createState() => _NewStoriesState();
}

class _NewStoriesState extends State<NewStories> {
  ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();
    // Provider.of<NewStoryProvider>(context, listen: false).fetchNewStories();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
        } else {
          Provider.of<NewStoryProvider>(context, listen: false)
              .setLoadMore(true);
          Provider.of<NewStoryProvider>(context, listen: false)
              .fetchNewStories();
        }
      }
    });
    final Map<int, Story> newStories =
        Provider.of<NewStoryProvider>(context, listen: false).newStories;
    return Scaffold(body: Consumer<NewStoryProvider>(
      builder: (context, storyProvider, child) {
        return storyProvider.isTopStoryLoading &&
                Provider.of<NewStoryProvider>(context).loadMoreNewStory == false
            ? Center(child: Constants.spinLoading)
            : ListView.builder(
                controller: _scrollController,
                itemCount: newStories.length + 1,
                itemBuilder: (context, index) {
                  if (index == newStories.length) {
                    return Center(child: Constants.spinLoading);
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Card(
                      child: ListTile(
                        title: Text(
                            newStories.values.elementAt(index).title ?? "",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '@${newStories.values.elementAt(index).by}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(Convertion.convertTime(
                                    newStories.values.elementAt(index).time ??
                                        0)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnyLinkPreview(
                                borderRadius: 1,
                                removeElevation: true,
                                link: newStories.values.elementAt(index).url ??
                                    "",
                                cache: Duration(days: 2),
                                errorWidget: Card(
                                  elevation: 0,
                                  child: Center(
                                    child: Image.network(
                                      Constants.previewErrorImage,
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .20,
                                    ),
                                  ),
                                ),
                                errorImage: Constants.previewErrorImage,
                                errorBody: "",
                                errorTitle:
                                    newStories.values.elementAt(index).title ??
                                        "",
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      story: newStories.values.elementAt(index),
                                    ),
                                  ));
                                },
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              story: newStories.values.elementAt(index),
                            ),
                          ));
                        },
                      ),
                    ),
                  );
                },
              );
      },
    ));
  }
}
