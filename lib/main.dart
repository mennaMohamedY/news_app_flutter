import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/home/articledetails/article_details.dart';
import 'package:newsapp/home/categories/categories_screen.dart';
import 'package:newsapp/home/home_screen.dart';
import 'package:newsapp/home/news/bloc/sources/category_details.dart';
import 'package:newsapp/home/settings/settings_screen.dart';
import 'package:newsapp/mytheme.dart';
import 'package:newsapp/providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home/news/bloc/mybloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (BuildContext)=>NewsProvider())
  ],child: MyApp(),));
}



class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<NewsProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      debugShowCheckedModeBanner: false,
      theme: MyTheme.myTheme,
      initialRoute: HomeScreen.routeName,
      //initialRoute: CategoriesList.routeName,
      routes: {
        HomeScreen.routeName: (context)=>HomeScreen(),
        SettingsScreen.routeName:(context)=>SettingsScreen(),
        ArticleDetails.routName:(context)=>ArticleDetails()
      },

    );
  }
}

