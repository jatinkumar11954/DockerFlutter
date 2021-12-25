import 'dart:ui';

import 'package:athome_partner_app/model/offerBanner.dart';
import 'package:athome_partner_app/static/SizeConfig.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OfferSliderWidget extends StatefulWidget {
  List<Offer> slides = [];

  @override
  _OfferSliderWidgetState createState() => _OfferSliderWidgetState();

  OfferSliderWidget({Key key, this.slides}) : super(key: key);
}

class _OfferSliderWidgetState extends State<OfferSliderWidget> {
  int _current = 0;
  AlignmentDirectional _alignmentDirectional;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // Future.delayed(Duration(milliseconds: 500));
    // return HomeSliderLoaderWidget();
    return Container(
      height: 150,
      child: ListView.separated(
          physics: PageScrollPhysics(),
          separatorBuilder: (context, index) => Divider(
                indent: 10,
              ),
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            Widget item = CachedNetworkImage(
              imageUrl: widget.slides[index].bannerUrl ??
                  "https://oit-athome.s3.amazonaws.com/images/offerbanners/MRFHLMLW-1617728978779.JPG",
              width: SizeConfig.w * 0.4,
              fit: BoxFit.fitHeight,
              placeholder: (context, url) => Center(
                child: Image.asset(
                  'images/loading.gif',
                  height: 130,
                  fit: BoxFit.fitHeight,

                  // width: double.infinity,
                  // height: 140,
                ),
              ),
              errorWidget: (context, url, error) => Center(
                child: Image.asset(
                  'images/banner_home.png',
                  width: SizeConfig.w * 0.4,
                  height: 130,
                  fit: BoxFit.fitWidth,
                ),
              ),
            );
            if (index == 0) {
              return Padding(
                child: item,
                padding: EdgeInsets.only(left: 10),
              );
            } else if (index == [].length - 1) {
              return Padding(
                child: item,
                padding: EdgeInsets.only(right: 10),
              );
            }
            return item;
          }),
    );
  }
}
