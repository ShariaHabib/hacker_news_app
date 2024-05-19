import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class ApiServices {
  final String baseUrl = 'https://hacker-news.firebaseio.com/v0';
  final String topStories = '/topstories.json';
  final String item = '/item/';

  Future<List<int>> getTopStories() async {
    print("DHUKEEEEE");
    final response = await http.get(
        Uri.parse('https://hacker-news.firebaseio.com/v0/topstories.json'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("HEREEEE");
      return List<int>.from(jsonDecode(response.body));
    } else {
      print("EXCEVEVE");
      throw Exception('Failed to load top stories');
    }
  }

  Future<Map<String, dynamic>> getItem(int id) async {
    final response = await http.get(Uri.parse('$baseUrl$item$id.json'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load story');
    }
  }

  Future<List<int>> getNewStories() async {
    final response = await http.get(Uri.parse('$baseUrl/newstories.json'));
    if (response.statusCode == 200) {
      return List<int>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load new stories');
    }
  }

  // Future<String?> fetchImageUrl(String url) async {
  // try {
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     var document = parser.parse(response.body);
  //     print('domunemttsss -----> $document');
  //     var elements = document.getElementsByTagName('img');
  //     print('elemeeents   , $elements');
  //     if (elements.isNotEmpty) {
  //       print(elements[0].attributes['src']);
  //       var imageUrl = elements[0].attributes['src'];
  //       return imageUrl;
  //     }
  //   }
  // } catch (e) {
  //   print('Error fetching image URL: $e');
  // }
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var document = parser.parse(response.body);
  //       var elements = document.getElementsByTagName('img');
  //       String? imageUrl;

  //       for (var element in elements) {
  //         var src = element.attributes['src'];
  //         if (src != null) {
  //           // Prioritize images with specific classes or sizes
  //           if (element.attributes['class']?.contains('thumbnail') ?? false) {
  //             imageUrl = src;
  //             break;
  //           }
  //           // Fallback to first image
  //           imageUrl ??= src;
  //         }
  //       }
  //       print(imageUrl);
  //       return imageUrl;
  //     }
  //   } catch (e) {
  //     print('Error fetching image URL: $e');
  //   }
  //   return null;
  // }
}
