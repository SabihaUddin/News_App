import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/utiles/news_response_model.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  bool loading = false;

  @override
  void initState() {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    getNews(newsProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Latest News'),
        ),
        body: loading ?
        Center(
            child: CircularProgressIndicator()) : newsProvider.newsList
            .isNotEmpty ?
        ListView.builder(
            shrinkWrap: false,
            physics: ClampingScrollPhysics(),
            itemCount: newsProvider.newsList.length,
            itemBuilder: (context, index) {
              Article news = newsProvider.newsList[index];
              return Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),

                ),
              );
            })
            :Center(
          child: Text('no data found'),
        )
    );
  }

  void getNews(NewsProvider newsProvider) async {
    setState(() {
      loading = true;
    });
    await newsProvider.getNews();
    setState(() {
      loading = false;
    });
  }
}
