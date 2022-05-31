import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';
import 'package:shimmer/shimmer.dart';

class ProfileEmmptyWidget extends StatelessWidget {
  const ProfileEmmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: false,
              pinned: true,
              automaticallyImplyLeading: false,
              expandedHeight: context.height / 2,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                background: sliverBackroundWidget(context,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sliverBackroundWidget(BuildContext context, ) {
    return Shimmer.fromColors(
      highlightColor: Colors.white.withOpacity(0.2),
      baseColor: Colors.grey.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: context.height / 20,
            ),

            /// profil fotoğrafı
            Stack(
              children: [
                Container(
                  width: context.height/6,
                  height: context.height/6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey
                  ),
                ),
              ],
            ),
            SizedBox(
              height: context.height / 50,
            ),

            Container(
              width: 100,
              height: 10,
              color: Colors.grey,
            ),
            SizedBox(height: context.height / 50),
            buildUserInfoWidget(context),
            SizedBox(height: 10),
            Divider(
              thickness: 2,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                radiusTextOntapWidget(context),
                radiusTextOntapWidget(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  radiusTextOntapWidget(BuildContext context,) {

    return Container(
      width: 150,
      child: Column(
        children: [
          Material(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Ink(
              height: 40,
              decoration: BoxDecoration(
                  color:  Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                splashColor: context.theme.primaryColor,
                child: Center(
                    child:Container(
                      width: 130,
                      height: 10,
                      color: Colors.grey,
                    ), ),
              ),
            ),
          ),
          Divider(
            thickness: 2,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  Row buildUserInfoWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            iconAndTextWidget(
              context,
              iconSize: 18,
              iconData: Icons.person,
            ),
            SizedBox(height: 5),
              iconAndTextWidget(
                context,
                iconSize: 16,
                iconData: Icons.school,
              ),
            SizedBox(height: 5),
              iconAndTextWidget(context,
                  iconSize: 14,
                  iconData: Icons.mosque,
                 ),
          ],
        ),
      ],
    );
  }

  Row iconAndTextWidget(BuildContext context,
      {double iconSize = 16,
        IconData iconData = Icons.person}) {
    return Row(
      children: [
        Material(
          color: context.theme.primaryColorDark,
          shape: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(
              iconData,
              color: context.theme.primaryColorLight,
              size: iconSize,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          width: 150,
          height: 10,
          color: Colors.grey,
        )
      ],
    );
  }
}
