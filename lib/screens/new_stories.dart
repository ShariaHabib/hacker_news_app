import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewStories extends StatelessWidget {
  const NewStories({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/image/logo.svg'),
        Text(
          'New Stories',
        ),
      ],
    ));
  }
}
