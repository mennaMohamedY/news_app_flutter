
import 'package:flutter/material.dart';

import 'cateory_dm.dart';

class SingleCategoryDesign extends StatelessWidget {

  CategoryDataModel categoryDataModel;
  SingleCategoryDesign({required this.categoryDataModel});
  @override
  Widget build(BuildContext context) {

    return Container(margin:EdgeInsets.symmetric(horizontal: 9,vertical: 6),decoration:BoxDecoration(
        color: categoryDataModel.categoryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular((categoryDataModel.index % 2 ==0)?  25: 0.0),
          bottomRight: Radius.circular((categoryDataModel.index % 2 ==0)? 0: 25),
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ) ),
      child: Column(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [
        Center(child: Image.asset(categoryDataModel.imgPath)),
        Text(categoryDataModel.categoryName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),)
      ],),
    );
  }
}
