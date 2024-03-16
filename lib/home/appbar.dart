
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  Function OnQueryListener;
  MyAppBar({required this.OnQueryListener});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: EasySearchBar(
      onSearch: (value){
        OnQueryListener(value);

      },
      title: Text("News App",style: TextStyle(color: Colors.white),),
      iconTheme: IconThemeData( color: Colors.white),
    ),);
  }
}
