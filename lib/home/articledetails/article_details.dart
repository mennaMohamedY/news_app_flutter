
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/model/NewsResponse.dart';
import 'package:newsapp/mytheme.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetails extends StatelessWidget {
  static String routName="ArticleDetails";
  late Articles article;

  //Articles article;
  //ArticleDetails({required this.article});
  @override
  Widget build(BuildContext context) {
    article=ModalRoute.of(context)?.settings.arguments as Articles;
    var Timee=article.publishedAt!.split('T');
    var publishedAt=Timee[0];

    return Scaffold(
      appBar: AppBar(title: Text(article.title??''),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2,vertical: 12),
            child:
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              //lw fe error h3mlha ezay
              child: Image.network(article.urlToImage??''),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2,horizontal: 12),
              child: Column(crossAxisAlignment:CrossAxisAlignment.stretch,children: [
                Text(article.author??'',style: TextStyle(color: Colors.black45),),
                SizedBox(height: 7,),
                Text(article.title??'',style: TextStyle(color: Colors.black,fontSize: 18),),
                SizedBox(height: 7,),
                Text(publishedAt??'',textAlign: TextAlign.end,),
                SizedBox(height: 21,),
                SingleChildScrollView(child:
                Text(article.content??''),),
                SizedBox(height: 12,),
                InkWell(onTap:OnLinkClicked
                  ,
                  child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                    Text("View Full Article ",style: TextStyle(fontSize:15,color: CupertinoColors.activeBlue),),
                    Icon(Icons.arrow_right,color: CupertinoColors.activeBlue,)
                  ],),
                )
              ],)),
          )


        ],
      ),
    );
  }
  void OnLinkClicked()async{
    Uri url = Uri.parse(article.url??'');
    try{
      launchUrl(url);
    }catch(e){
      print(('Could not launch $url'));
      throw e;
    }



  }
}
