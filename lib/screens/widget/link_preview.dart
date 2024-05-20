import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import '../../models/story.dart';

class PreviewLink extends StatelessWidget {
  PreviewLink({super.key, required this.story});
  final Story story;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: AnyLinkPreview(
        // backgroundColor: Colors.blueGrey[100],
        bodyMaxLines: 7,
        cache: Duration(days: 2),
        link: story.url ?? "",
        previewHeight: MediaQuery.of(context).size.height * .50,
        removeElevation: true,
        errorWidget: InkWell(
          onTap: () {
            launchUrl(Uri.parse(story.url ?? ""));
          },
          child: Card(
            elevation: 0,
            child: Center(
              child: Column(
                children: [
                  Image.network(
                    Constants.previewErrorImage,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * .20,
                  ),
                  Text(
                    'Error in loading preview. Tap to open link ${story.url}.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        errorImage: Constants.previewErrorImage,
        errorBody: "Error in loading preview. Tap to open link ${story.url}.",
        errorTitle: story.title ?? "",
      ),
    );
  }
}
