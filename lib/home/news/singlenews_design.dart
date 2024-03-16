
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/home/articledetails/article_details.dart';
import 'package:newsapp/model/NewsResponse.dart';
import 'package:newsapp/mytheme.dart';

class SingleNewsDesign extends StatelessWidget {

  Articles article;

  SingleNewsDesign({required this.article});
  @override
  Widget build(BuildContext context) {
    var Time=article.publishedAt!.split('T');
    var publishingTime=Time[0];


    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 9),
        child: 
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, ArticleDetails.routName,
              arguments: article);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              //lw fe error h3mlha ezay
              child: CachedNetworkImage(
                imageUrl: article.urlToImage??'',
                placeholder: (context, url) => Center(child: CircularProgressIndicator(color: MyTheme.primaryColor,),),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
             // Image.network(article.urlToImage??''),
            ),
          ),
      ),
      Text(article.author??'',style: TextStyle(color: Colors.black45),),
      Text(article.title??'',maxLines: 3,),
      Text(publishingTime??'',textAlign: TextAlign.end,)
      
    ],
    );
  }
}
