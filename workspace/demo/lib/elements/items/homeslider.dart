import 'dart:ui';

import 'package:athome_partner_app/model/bannerData.dart';
import 'package:athome_partner_app/static/SizeConfig.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeSliderWidget extends StatefulWidget {
  List<BannerData> slides = [];

  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();

  HomeSliderWidget({Key key, this.slides}) : super(key: key);
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _current = 0;
  AlignmentDirectional _alignmentDirectional;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // Future.delayed(Duration(milliseconds: 500));
    // return HomeSliderLoaderWidget();
    return Container(
      // alignment: ,
      width: SizeConfig.w,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          height: 130,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
              // _alignmentDirectional = Helper.getAlignmentDirectional(
              //     widget.slides.elementAt(index).textPosition);
            });
          },
        ),
        items: widget?.slides == null || (widget?.slides?.isEmpty ?? false)
            ? [
                Image.asset(
                  'images/banner_home.png',
                  fit: BoxFit.fill,
                  width: double.infinity,
                )
              ]
            : widget.slides.map((BannerData slide) {
                return Builder(
                  builder: (BuildContext context) {
                    return CachedNetworkImage(
                      imageUrl: slide?.bannerUrl ??
                          "https://oit-athome.s3.amazonaws.com/images/offerbanners/MRFHLMLW-1617728978779.JPG",
                      //  Image.asset(
                      //   'assets/img/',
                      // height: 140,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                      // Helper.getBoxFit(slide.imageFit),
                      // imageUrl: "https://image.freepik.com/free-vector/online-market-web-banner-hand-holding-smart-phone-ordering-products-grocery-shopping-food-delivery-concept_48369-18136.jpg",
                      placeholder: (context, url) => Center(
                        child: Image.asset(
                          'images/loading.gif',
                          height: 130,
                          fit: BoxFit.fitWidth,
                          // width: double.infinity,
                          // height: 140,
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Image.asset(
                          'images/banner_home.png',

                          height: 130,
                          fit: BoxFit.fitWidth,
                          // width: double.infinity,
                          // height: 140,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
      ),
    );
  }
}
