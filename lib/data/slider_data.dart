
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/slider_model.dart';

class SliderData {
  List<SliderModel> sliders = [];

  Future<void> getSliders() async {
    try {
      final apiKey = dotenv.env['NEWS_API_KEY'] ?? '';
      final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        
        if (jsonData['status'] == 'ok') {
          sliders = (jsonData['articles'] as List)
              .where((element) => 
                  element['urlToImage'] != null && 
                  element['description'] != null)
              .map((slider) => SliderModel(
                title: slider['title'],
                description: slider['description'],
                url: slider['url'],
                urlToImage: slider['urlToImage'],
                content: slider['content'],
                author: slider['author'],
              ))
              .toList();
        }
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

}
