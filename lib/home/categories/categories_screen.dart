
import 'package:flutter/material.dart';
import 'package:newsapp/home/categories/cateory_dm.dart';
import 'package:newsapp/home/categories/singlecategory_design.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CategoriesList extends StatefulWidget {
  static String routeName="CategoriesScreen";
  Function OnCategoryClickListener;
  CategoriesList({required this.OnCategoryClickListener});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  var bordersRadius=25.0;

  var zeroRadius=0.0;

  // List<String> imgsPathList=['assets/images/ball.png','assets/images/politics.png',
  List<String> imgsPathList=['assets/images/ball.png','assets/images/health.png',
    'assets/images/bussines.png', 'assets/images/environment.png',
    'assets/images/science.png','assets/images/bussines.png','assets/images/politics.png','assets/images/science.png'];

  List<Color> categoriesColorList=[Color(0xffC91C22),Color(0xff003E90),
    Color(0xffED1E79),Color(0xffCF7E48),
    Color(0xff4882CF),Color(0xffF2D352),
    Color(0xffCF7E48)

  ];

  //List<String> categoriesNameList=['Sports','Politics','Health','Bussines','Environment','Science'];
  List<String> categoriesNameList=['Sports','Health','Bussines','Environment','Science','General','Technology'];

  List<String> categoriesID=['sports','health','business','environment','science','general','technology'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12),
      child: GridView.builder(gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 12,mainAxisSpacing: 12),
        itemBuilder:itemBuilder
        ,itemCount: categoriesNameList.length),
    );
  }

  InkWell itemBuilder(BuildContext context,int index ){
    CategoryDataModel categoryDataModel=CategoryDataModel(id: categoriesID[index],
        categoryColor: categoriesColorList[index], index: index,
        imgPath: imgsPathList[index], categoryName: categoriesNameList[index]);
    return InkWell(onTap: (){
      widget.OnCategoryClickListener(categoryDataModel);
    },child: SingleCategoryDesign(categoryDataModel: categoryDataModel));
  }
}

/*
* SingleCategoryDesign(
        categoryColor: categoriesColorList[index],
        bottomLeftRadius: (index % 2 ==0)?  bordersRadius: zeroRadius,
        bottomrightRadius: (index % 2 ==0)? zeroRadius: bordersRadius,
        topLeftRadius: bordersRadius,
        topRightRadius: bordersRadius,
        imgPath: imgsPathList[index],
        categoryName: categoriesNameList[index]);*/
