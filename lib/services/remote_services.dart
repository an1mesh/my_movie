import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_works/models/news_model.dart';

class RemoteServices {
  Future<NewsModel> getNews() async {
    try {
      String url =
          'https://newsapi.org/v2/top-headlines?country=in&apiKey=ed0230ac26874f549b360d3528ad5878';
      final response = await http.get(Uri.parse(url));
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        return NewsModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get data');
      }
    } catch (e) {
      throw Exception('Failed to get data');
    }
  }
}
