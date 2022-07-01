import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'newspage.dart';
import '../models/news.dart';
import 'package:http/http.dart' as http;
import '../env.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  //TODO: baca dari API : list.php
  Future<List<News>> getNewsList() async {
    final response = await http.get(Uri.parse(Env.server + '/api/list.php'));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<News> news = items.map<News>((json) {
      return News.fromJson(json);
    }).toList();

    return news;
  }

  //Masukkan ke object newsList
  late Future<List<News>> newsList;

  @override
  void initState() {
    super.initState();
    newsList = getNewsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<News>>(
        future: newsList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.length * 2,
            itemBuilder: (context, index) {
              if (index.isOdd) return Divider();
              return newsItem(snapshot.data[index ~/ 2]);
            },
          );
        },
      ),
    );
  }

  Widget newsItem(News news) {
    return InkWell(
      onTap: () {
        //Pindah Halaman Baru
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewsPage(news)));
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      news.subTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    news.publishedAt,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Image.asset(
              news.imagePath,
              width: 120,
              height: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
