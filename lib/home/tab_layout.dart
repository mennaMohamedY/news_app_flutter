
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/home/news/articles.dart';
import 'package:newsapp/home/news/category_details.dart';
import 'package:newsapp/home/news/singlenews_design.dart';
import 'package:newsapp/home/news/tryofsearch.dart';
import 'package:newsapp/home/singletab_design.dart';
import 'package:newsapp/model/SourceResponse.dart';
import 'package:newsapp/providers/provider.dart';
import 'package:provider/provider.dart';

import '../api_utiles/api_manager.dart';
import '../mytheme.dart';


class TabLayout extends StatefulWidget {
  List<Sources> sourcesList;
  //int selectedIndex=0;
  TabLayout({required this.sourcesList});
  //var selectedIndex=0;

  @override
  State<TabLayout> createState() => _TabLayoutState();
}

class _TabLayoutState extends State<TabLayout> {

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<NewsProvider>(context);
    return DefaultTabController(
        length: widget.sourcesList.length /*sourcesList.length*/,
        child: Column(children: [

          TabBar(
              isScrollable: true,
              indicatorColor: Colors.transparent,
              onTap: (index) {
                provider.UpdateTabIndex(index);
                //widget.selectedIndex = index;

                setState(() {});
              },
              tabs: widget.sourcesList.map((source) =>
                  CustomTab(source: source,
                      isSelected: provider.tabIndex ==
                          widget.sourcesList.indexOf(source))).toList()),
          //MYArticles(sourceID: widget.sourcesList[widget.selectedIndex].id??'',controllerFlag: 0,)
          Expanded(flex:1,child: MYSearch(sourceID: widget.sourcesList[provider.tabIndex].id??'', controllerFlag: 0))

        ])
    );
  }
}
