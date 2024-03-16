import 'package:flutter/material.dart';
import 'package:newsapp/api_utiles/api_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  List<int> _data = List.generate(20, (index) => index); // Initial data

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMoreData() async{
    String sourceID='bbc-news';
    var pageNum=1;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      pageNum +=1;
      // User has reached the end of the list
      // Load more data or trigger pagination in flutter
      var n=await APIManager.loadMoreArticles(sourceID, pageNum);
      var m=n.articles;
      setState(() {

        _data.addAll(List.generate(10, (index) => _data.length + index));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Scroll'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item ${_data[index]}'),
          );
        },
      ),
    );
  }
}
