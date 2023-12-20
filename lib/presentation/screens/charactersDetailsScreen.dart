import 'package:api/constants/MyColors.dart';
import 'package:api/data/models/ModelCharacter.dart';
import 'package:flutter/material.dart';

class CharactersDetailsScreen extends StatelessWidget {

  final ModelCharacters selectedItem;
 const CharactersDetailsScreen({Key? key,required this.selectedItem}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(delegate: SliverChildListDelegate(
              [
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   characterInfo("species :",selectedItem.species),
                   buildDivider(280),
                  characterInfo("gender :",selectedItem.gender),
                   buildDivider(280),
                  characterInfo("status :",selectedItem.status),
                   buildDivider(280),

                  SizedBox(
                    height: 20,
                  )

                ],
              ),
            ),
                SizedBox(
                  height: 600,
                )
          ]
          ),
          ),
        ],
      ),

    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(selectedItem.name,style: TextStyle(color: MyColors.myWhite),textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: selectedItem.id,
          child: Image.network(selectedItem.image,fit: BoxFit.cover,),
        ),
      ),

    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(color: MyColors.myYellow,
    height: 30,
      endIndent:endIndent ,
      thickness: 2,
    );
  }
}

Widget characterInfo(String title,String value) {
  return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [

        TextSpan(
          text: title,
          style: TextStyle(color: MyColors.myWhite,fontWeight: FontWeight.bold,fontSize: 18)
        ),
        TextSpan(
            text: value,
            style: TextStyle(color: MyColors.myWhite,fontSize: 16)
        ),
      ]
      ),
  );

}
