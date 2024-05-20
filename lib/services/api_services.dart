import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

class ApiServices {
  Future<List<int>> getTopStories() async {
    final response = await http
        .get(Uri.parse('${Constants.baseUrl}${Constants.topStories}'));
    if (response.statusCode == 200) {
      return List<int>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load top stories');
    }
  }

  Future<Map<String, dynamic>> getItem(int id) async {
    final response = await http
        .get(Uri.parse('${Constants.baseUrl}${Constants.item}$id.json'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load story');
    }
  }

  Future<List<int>> getNewStories() async {
    final response = await http
        .get(Uri.parse('${Constants.baseUrl}${Constants.newStories}'));
    if (response.statusCode == 200) {
      return List<int>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load new stories');
    }
  }
}
