import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uas/main.dart';
import '../env.dart';

class NewsForm extends StatefulWidget {
  @override
  _NewsFormState createState() => _NewsFormState();
}

class _NewsFormState extends State<NewsForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  validateInput() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('News berhasil dipost, silahkan klik tombol refresh')));
      _saveNews(context);
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

  Future _createNews() async {
    return await http.post(
      Uri.parse(Env.server + '/api/create.php'),
      body: {
        "title": ctrlTitle.text,
        "subTitle": ctrlSubTitle.text,
        "news": ctrlNews.text,
        "imagePath": ctrlImage.text,
      },
    );
  }

  void _saveNews(context) async {
    final response = await _createNews();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      appBar: AppBar(
        title: Text("Create News"),
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
                            hintText: "Title",
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
                            hintText: "Sub Title",
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
                            hintText: "News",
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
                            hintText: "Image",
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
