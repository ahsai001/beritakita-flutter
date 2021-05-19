import 'package:flutter/material.dart';
import 'package:beritakita/configs/config.dart';
import 'package:http/http.dart' as http;
import 'package:beritakita/newsdetail/models/news_detail_response.dart';
import 'dart:async';
import 'package:beritakita/home/models/news_response.dart';

class NewsDetailPage extends StatefulWidget {
  News? news;

  NewsDetailPage({required this.news});

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  Future<NewsDetailResponse>? _futureResponse;

  @override
  void initState() {
    super.initState();
    _futureResponse = _getNewsDetail(widget.news!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail"),
        actions: [],
      ),
      body: FutureBuilder(
          future: _futureResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              NewsDetail data = (snapshot.data as NewsDetailResponse).data;

              return ListView(
                children: [
                  Image.network(data.photo,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover),
                  Text(data.title),
                  Text(data.body)
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("ada error: ${snapshot.error}"),
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Future<NewsDetailResponse>? _getNewsDetail(String newsId) async {
    final response = await http.post(
        Uri.https(Config.BASE_AUTHORITY,
            Config.getNewsDetailPath().replaceAll("{id}", newsId)),
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'QVBJS0VZPXF3ZXJ0eTEyMzQ1Ng==',
          'x-packagename': "com.ahsailabs.beritakita",
          'x-platform': "android"
        });

    if (response.statusCode == 200) {
      //print(response.body);
      return NewsDetailResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to get list.');
    }
  }
}
