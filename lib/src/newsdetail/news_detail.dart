import 'dart:async';

import 'package:beritakita/src/configs/config.dart';
import 'package:beritakita/src/home/models/news_response.dart';
import 'package:beritakita/src/newsdetail/models/news_detail_response.dart';
import 'package:beritakita/src/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

//we need statefull, because we need use setState
class NewsDetailPage extends StatefulWidget {
  final News? news;

  const NewsDetailPage({super.key, required this.news});

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  Future<NewsDetailResponse>? _futureResponse;
  String _title = "News Detail";

  @override
  void initState() {
    super.initState();
    _futureResponse = _getNewsDetail(widget.news!.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: const [],
        automaticallyImplyLeading: true,
      ),
      body: FutureBuilder(
          future: _futureResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              NewsDetail data = (snapshot.data as NewsDetailResponse).data!;

              //update title appbar
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  _title = data.title ?? "";
                });
              });

              return ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  if (data.photo != null)
                    Image.network(data.photo ?? "",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data.createdBy ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.apply(fontSizeDelta: 4)),
                        Text(data.createdAt ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.apply(fontSizeDelta: 2))
                      ]),
                  Stack(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(data.createdBy ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.apply(fontSizeDelta: 4)),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(data.createdAt ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.apply(fontSizeDelta: 2))),
                  ]),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(data.title ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.apply(fontSizeDelta: 4)),
                  const SizedBox(
                    height: 10,
                  ),
                  Linkify(
                      onOpen: (link) async {
                        final uri = Uri.parse(link.url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        } else {
                          throw 'Could not launch $link';
                        }
                      },
                      text: data.body ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.apply(fontSizeDelta: 2)),
                  // Text(data.body,
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .subtitle2
                  //         ?.apply(fontSizeDelta: 2))
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("ada error: ${snapshot.error}"),
              );
            }

            return const Center(child: CustomLoader());
          }),
    );
  }

  Future<NewsDetailResponse> _getNewsDetail(String newsId) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final response = await http.post(
        Uri.https(Config.baseAuthority,
            Config.getNewsDetailPath().replaceAll("{id}", newsId)),
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'QVBJS0VZPXF3ZXJ0eTEyMzQ1Ng==',
          'x-packagename': packageInfo.packageName,
          'x-platform': "android"
        });

    if (response.statusCode == 200) {
      //print(response.body);
      return newsDetailResponseFromJson(response.body);
    } else {
      throw Exception('Failed to get list.');
    }
  }
}
