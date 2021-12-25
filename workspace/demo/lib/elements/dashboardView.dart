import 'dart:math';

import 'package:athome_partner_app/model/dashBoard.dart';
import 'package:athome_partner_app/static/SizeConfig.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DashBoardView extends StatefulWidget {
  DashBoardCategory dashBoardCategory;
  DashBoardView({Key key, this.dashBoardCategory}) : super(key: key);

  @override
  _DashBoardViewState createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      // padding: EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20, bottom: 0),
//
            child: Text(
              widget.dashBoardCategory.categoryName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Html(
            data: widget.dashBoardCategory.description,
          ),
          Container(
            height: ((min((widget.dashBoardCategory.subCategories?.length ?? 1),
                            4) /
                        2)
                    .ceil()) *
                140.0,
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:
                    min((widget.dashBoardCategory.subCategories?.length), 4),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.4,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                ),
                // padding: EdgeInsets.all(4.0),
                itemBuilder: (context, i) {
                  return widget.dashBoardCategory.subCategories?.isEmpty ??
                          false
                      ? Container()
                      : Column(
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child: Card(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      // color: Colors.red,
                                      // height: 100,
                                      child: CachedNetworkImage(
                                        imageUrl: widget.dashBoardCategory
                                            .subCategories[i]?.imageUrl,
                                        width: 120,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: Image.asset(
                                            'images/loading.gif',
                                            width: 120,
                                            height: 100,

                                            fit: BoxFit.cover,
                                            // width: double.infinity,
                                            // height: 140,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: Image.asset(
                                            'images/banner_home.png',

                                            width: 120,
                                            height: 100,
                                            fit: BoxFit.cover,
                                            // width: double.infinity,
                                            // height: 140,
                                          ),
                                        ),
                                      )),
                                )),
                            Center(
                              child: Text(
                                widget.dashBoardCategory.subCategories[i]
                                    .subCategoryName,
                                softWrap: true,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        );
                }),
          )
        ],
      ),
    );
  }
}
