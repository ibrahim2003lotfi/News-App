
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article_model.dart';

class ArticleNews {
  List<ArticleModel> articles = [];

  Future<void> getArticlesNews() async {
    try {
      final apiKey = dotenv.env['NEWS_API_KEY'] ?? '';
      final url = Uri.parse(
        'https://newsapi.org/v2/everything?q=apple&from=2025-08-03&to=2025-08-03&sortBy=popularity&apiKey=$apiKey',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        
        if (jsonData['status'] == 'ok') {
          articles = (jsonData['articles'] as List)
              .where((element) => 
                  element['urlToImage'] != null && 
                  element['description'] != null)
              .map((article) => ArticleModel(
                title: article['title'],
                description: article['description'],
                url: article['url'],
                urlToImage: article['urlToImage'],
                content: article['content'],
                author: article['author'],
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

