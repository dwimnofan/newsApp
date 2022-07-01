import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uas/widgets/editform.dart';
import '../main.dart';
import 'newsfeed.dart';
import '../models/news.dart';
import 'package:http/http.dart' as http;
import '../env.dart';

class NewsPage extends StatelessWidget {
  //const NewsPage({Key? key}) : super(key: key);
  News news;
  NewsPage(this.news, {Key? key}) : super(key: key);

  Future _deleteNews() async {
    return await http
        .post(Uri.parse(Env.server + '/api/delete.php'), body: {"id": news.id});
  }

  _delete() async {
    return await _deleteNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditNews(news)));
            },
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.asset(
              news.imagePath,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(news.subTitle),
                Row(
                  children: [
                    Expanded(
                      child: Text(news.publishedAt),
                    )
                  ],
                ),
                Text(news.news),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _delete();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Icon(Icons.delete),
      ),
    );
  }
}
