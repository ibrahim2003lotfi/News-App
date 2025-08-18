import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/article.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/pages/article_page.dart';

class TrendingWidget extends StatefulWidget {
  const TrendingWidget({super.key});

  @override
  State<TrendingWidget> createState() => _TrendingWidgetState();
}

class _TrendingWidgetState extends State<TrendingWidget> {
  List<ArticleModel> articles = [];
  bool _loading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    getArticlesNews();
  }

  getArticlesNews() async {
    try {
      ArticleNews news = ArticleNews();
      await news.getArticlesNews();
      setState(() {
        articles = news.articles;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load news: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ... (your existing header code)
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Breaking News!',
                style: TextStyle(
                  fontFamily: 'Libertinus Serif',
                  
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        _loading
            ? Center(child: CircularProgressIndicator())
            : _error.isNotEmpty
            ? Text(_error)
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return BlogTile(
                      imageUrl: article.urlToImage ?? '',
                      title: article.title ?? '',
                      description: article.description ?? '',
                      blogUrl: article.url ?? '',
                    );
                  },
                ),
              ),
      ],
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, description, blogUrl;

  const BlogTile({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.blogUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ArticlePage(blogUrl: blogUrl);
            },
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
