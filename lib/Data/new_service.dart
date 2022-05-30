import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/Models/article.dart';
import 'package:newsapp/Models/news.dart';

class NewsService{
  static final NewsService _singleton = NewsService._internal();

  NewsService._internal();

  factory NewsService(){
    return _singleton;
  }

  static Future<List<Articles>?> getNews() async{
    String url=
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=558edcf06d8c464ca9d494cb59f7a268';
    final response = await http.get(Uri.parse(url));
    if (response.body.isNotEmpty){
      final responseJson= json.decode(response.body);
      News news = News.fromJson(responseJson);
      return news.articles;
    }
      return null;
  }
}
