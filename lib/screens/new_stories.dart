import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hacker_news_app/providers/new_story_provider.dart';
import 'package:provider/provider.dart';

import '../models/story.dart';
import '../services/theme.dart';
import '../utils/convert_time.dart';
import 'details_screen.dart';

class NewStories extends StatefulWidget {
  const NewStories({super.key});

  @override
  State<NewStories> createState() => _NewStoriesState();
}

class _NewStoriesState extends State<NewStories> {
  late ScrollController _scrollController;

  void initState() {
    super.initState();
    _scrollController = ScrollController();

    Provider.of<NewStoryProvider>(context, listen: false).fetchNewStories();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          print("Top");
        } else {
          print("Bottom");
          Provider.of<NewStoryProvider>(context, listen: false)
              .setLoadMore(true);
        }
      }
    });
    final Map<int, Story> newStories =
        Provider.of<NewStoryProvider>(context, listen: false).newStories;
    return Scaffold(body: Consumer<NewStoryProvider>(
      builder: (context, storyProvider, child) {
        return storyProvider.isTopStoryLoading &&
                Provider.of<NewStoryProvider>(context).loadMoreNewStory == false
            ? const Center(
                child: SpinKitFadingFour(
                    color: Color.fromRGBO(239, 108, 0, 1), size: 50.0),
              )
            : ListView.builder(
                controller: _scrollController,
                itemCount: newStories.length + 1,
                itemBuilder: (context, index) {
                  if (index == newStories.length) {
                    return const Center(
                      child: SpinKitFadingFour(
                          color: Color.fromRGBO(239, 108, 0, 1), size: 50.0),
                    );
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
                                      'https://github.com/sur950/any_link_preview/blob/master/lib/assets/giphy.gif?raw=true',
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .20,
                                    ),
                                  ),
                                ),
                                errorImage:
                                    'https://github.com/sur950/any_link_preview/blob/master/lib/assets/giphy.gif?raw=true',
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
