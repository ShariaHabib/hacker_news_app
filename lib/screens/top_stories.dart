import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hacker_news_app/screens/details_screen.dart';
import 'package:hacker_news_app/utils/convert_time.dart';
import 'package:provider/provider.dart';

import '../models/story.dart';
import '../providers/top_story_provider.dart';

class TopStories extends StatefulWidget {
  const TopStories({super.key});

  @override
  State<TopStories> createState() => _TopStoriesState();
}

class _TopStoriesState extends State<TopStories> {
  ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();

    Provider.of<TopStoryProvider>(context, listen: false).fetchTopStories();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          print("Top");
        } else {
          print("Bottom");
          Provider.of<TopStoryProvider>(context, listen: false)
              .setLoadMore(true);
          Provider.of<TopStoryProvider>(context, listen: false)
              .fetchTopStories();
        }
      }
    });
    final Map<int, Story> topStories =
        Provider.of<TopStoryProvider>(context, listen: false).topStories;
    return Scaffold(body: Consumer<TopStoryProvider>(
      builder: (context, storyProvider, child) {
        return storyProvider.isTopStoryLoading &&
                Provider.of<TopStoryProvider>(context).loadMoreTopStory == false
            ? const Center(
                child: SpinKitFadingFour(
                    color: Color.fromRGBO(239, 108, 0, 1), size: 50.0))
            : ListView.builder(
                controller: _scrollController,
                itemCount: topStories.length + 1,
                itemBuilder: (context, index) {
                  if (index == topStories.length) {
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
                            topStories.values.elementAt(index).title ?? "",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '@${topStories.values.elementAt(index).by}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(Convertion.convertTime(
                                    topStories.values.elementAt(index).time ??
                                        0)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnyLinkPreview(
                                borderRadius: 1,
                                removeElevation: true,
                                link: topStories.values.elementAt(index).url ??
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
                                    topStories.values.elementAt(index).title ??
                                        "",
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      story: topStories.values.elementAt(index),
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
                              story: topStories.values.elementAt(index),
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
