import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uas/main.dart';
import 'package:uas/widgets/newspage.dart';
import '../models/news.dart';
import '../env.dart';

class EditNews extends StatefulWidget {
  News news;
  EditNews(this.news, {Key? key}) : super(key: key);

  @override
  State<EditNews> createState() => _EditNewsState(news);
}

class _EditNewsState extends State<EditNews> {
  final News news;
  _EditNewsState(this.news);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void validateInput() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('News berhasil diupdate, silahkan klik tombol refresh')));
      _updateNews();
    }
  }

  //controller
  final ctrlTitle = TextEditingController();
  final ctrlSubTitle = TextEditingController();
  final ctrlNews = TextEditingController();
  final ctrlImage = TextEditingController();

  @override
  void dispose() {
    ctrlTitle.dispose();
    ctrlSubTitle.dispose();
    ctrlNews.dispose();
    ctrlImage.dispose();
    super.dispose();
  }

  Future _updateNews() async {
    return await http.post(
      Uri.parse(Env.server + '/api/update.php'),
      body: {
        "id": news.id,
        "title": ctrlTitle.text,
        "subTitle": ctrlSubTitle.text,
        "news": ctrlNews.text,
        "imagePath": ctrlImage.text,
      },
    );
  }

  void _saveNews(context) async {
    final response = await _updateNews();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit News"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: ctrlTitle,
                        decoration: InputDecoration(
                            labelText: "Title",
                            hintText: news.title,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0))),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      Container(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: ctrlSubTitle,
                        decoration: InputDecoration(
                            labelText: "Sub Title",
                            hintText: news.subTitle,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0))),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Sub Title tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      Container(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: ctrlNews,
                        maxLines: 10,
                        decoration: InputDecoration(
                            labelText: "News",
                            hintText: news.news,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0))),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'News tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      Container(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: ctrlImage,
                        decoration: InputDecoration(
                            labelText: "Image",
                            hintText: news.imagePath,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0))),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Image tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      Container(
                        height: 20.0,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            minimumSize: const Size.fromHeight(50),
                          ),
                          onPressed: () {
                            validateInput();
                          },
                          child: Text('POST'))
                    ],
                  ))),
        ],
      ),
    );
  }
}
