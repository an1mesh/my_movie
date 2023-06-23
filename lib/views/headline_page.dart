import 'package:flutter/material.dart';

import 'package:my_works/models/news_model.dart';
import 'package:my_works/services/remote_services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HeadlinePage extends StatefulWidget {
  const HeadlinePage({super.key});

  @override
  State<HeadlinePage> createState() => _HeadlinePageState();
}

class _HeadlinePageState extends State<HeadlinePage> {
  FlutterTts tts = FlutterTts();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final RemoteServices _service = RemoteServices();
  late NewsModel news;

  Future<NewsModel> getNewsData() async {
    news = await _service.getNews();
    return news;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('News'),
        ),
      ),
      body: FutureBuilder(
        future: getNewsData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: news.articles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  title: Image.network(
                      news.articles[index].urlToImage ?? 'No Image'),
                  subtitle: Text(news.articles[index].title),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          } else {
            return const Center(
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Loading...'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
