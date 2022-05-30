import 'package:flutter/material.dart';
import 'package:newsapp/Data/new_service.dart';
import 'package:newsapp/Models/article.dart';
import 'package:url_launcher/url_launcher.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haberler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Haberler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
List<Articles> articles = [];
@override
  void initState() {
    NewsService.getNews().then((value) {
      setState(() {
        articles = value!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
          child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index){
          return Card(
            child: Column(
              children: [
                Image.network(articles[index].urlToImage.toString()),
                ListTile(leading:
                  const Icon(Icons.arrow_drop_down_circle),
                  title: Text(articles[index].title.toString()),
                  subtitle: Text(articles[index].author.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(articles[index].description.toString()),

                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(onPressed: () async
                    {
                     await launch(articles[index].url.toString());
                    }, child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text('Habere Git'),
                    ),
                      color:Colors.blue,
                    )
                  ],
                ),
              ],
            ),
          );
        })),
    );
  }
}
