import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


//https://github.com/flutterchina/dio
import 'package:dio/dio.dart';


Future<Post> fetchPost() async {
  final responce = await http.get('https://jsonplaceholder.typicode.com/posts/1');
  final responseJson = json.decode(responce.body);

  return Post.fromJson(responseJson);
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    this.id,
    this.userId,
    this.title,
    this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class NetJsonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getHttp();

    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Fetch data demo'),),
        body: Center(
          child: FutureBuilder<Post>(
            future: fetchPost(),
            builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.title);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          }),
        ),
      ),
      title: 'fetch data examole',
    );
  }

  void getHttp() async {
    try {
      Response response = await Dio().get('https://raw.githubusercontent.com/poos/poos.github.io/master/test/example.json');
      print(response);
    } catch (e) {
      print(e);
    }
  }

}








