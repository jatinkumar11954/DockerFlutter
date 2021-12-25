// import 'package:athome_partner_app/elements/addOnBottom.dart';
// import 'package:athome_partner_app/elements/bottomNavBar.dart';
// import 'package:athome_partner_app/helpers/hex_color.dart';
// import 'package:athome_partner_app/main.dart';
// import 'package:athome_partner_app/model/serviceData.dart';
// import 'package:athome_partner_app/static/SizeConfig.dart';
// import 'package:athome_partner_app/static/apiServices.dart';
// import 'package:athome_partner_app/static/constants.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';

// class ServiceScreen extends StatefulWidget {
//   String subCatId;
//   ServiceScreen({Key key, this.subCatId}) : super(key: key);

//   @override
//   _ServiceScreenState createState() => _ServiceScreenState();
// }

// class _ServiceScreenState extends State<ServiceScreen> {
//   List<ServicesData> serviceData = [];
//   showLoading() => setState(() {
//         _isLoading = true;
//       });
//   stopLoading() => setState(() {
//         _isLoading = false;
//       });
//   bool _isLoading = false, searchTap = false;
//   Map serviceRes;
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   // List<BannerData> bannerData = [];
//   getData() async {
//     showLoading();
//     print("-------sub cat id ");
//     print(widget.subCatId);
//     serviceRes =
//         await ApiServices.getRequest(serviceEndPoint + widget.subCatId);
//     // //print("llllllllog${bannerRes}");
//     if (serviceRes != null) {
//       //print("res is not null ${bannerRes["isSuccess"]}");
//       if (serviceRes["isSuccess"]) {
//         //print("status is true");
//         serviceData = List<ServicesData>.from(
//             serviceRes["servicesData"].map((x) => ServicesData.fromMap(x)));
//         List<AddonsData> addondata = List<AddonsData>.from(
//             serviceRes["addonsData"].map((x) => AddonsData.fromMap(x)));
//         print("res $serviceRes");
//         Provider.of<Service>(context, listen: false).init();
//         Provider.of<Service>(context, listen: false)
//             .currentData
//             .addAll(serviceData ?? []);
//         Provider.of<Service>(context, listen: false)
//             .addonsData
//             .addAll(addondata ?? []);
//         //     ?
//         stopLoading();
//       }
//       stopLoading();
//     } else {
//       stopLoading();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Consumer<Service>(builder: (context, item, i) {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: primaryColor,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Provider.of<Service>(context, listen: false).init();

//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: _isLoading
//             ? Center(
//                 child: Image.asset("images/loading_card.gif",
//                     height: 400, width: SizeConfig.w * 0.9),
//               )
//             : SingleChildScrollView(
//                 child: Column(mainAxisSize: MainAxisSize.max, children: [
//                   Text(
//                     serviceRes["subCatData"]["subCategoryName"] ?? "",
//                     style: TextStyle(fontSize: 16, color: Colors.black),
//                   ),
//                   ListView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: item?.currentData?.length ?? 0,
//                       padding: EdgeInsets.all(15),
//                       itemBuilder: (context, si) {
//                         return Container(
//                           // height: 12,
//                           // color: Colors.red,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Card(
//                                 elevation: 5,
//                                 margin: EdgeInsets.fromLTRB(8, 0, 8, 2),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         width: 50,
//                                         height: 50,
//                                         padding: EdgeInsets.all(2),
//                                         decoration: BoxDecoration(
//                                             // image: new DecorationImage(
//                                             //     fit: BoxFit.cover,
//                                             //     image: new CachedNetworkImageProvider(
//                                             //         item?.currentData[si]
//                                             //                 ?.imageUrl ??
//                                             //             "https://www.woolha.com/media/2019/06/buneary.jpg",
//                                             //         errorListener: () {})),
//                                             // color: Colors.amber,
//                                             shape: BoxShape.circle),
//                                         child: CachedNetworkImage(
//                                           imageUrl:
//                                               item.currentData[si].imageUrl,
//                                           width: 50,
//                                           height: 50,
//                                           fit: BoxFit.fill,
//                                           placeholder: (context, url) => Center(
//                                             child: Image.asset(
//                                               'images/loading.gif',
//                                               width: 50,
//                                               height: 50,

//                                               fit: BoxFit.cover,
//                                               // width: double.infinity,
//                                               // height: 140,
//                                             ),
//                                           ),
//                                           errorWidget: (context, url, error) =>
//                                               Center(
//                                             child: Image.asset(
//                                               'images/banner_home.png',

//                                               width: 50,
//                                               height: 50,
//                                               fit: BoxFit.cover,
//                                               // width: double.infinity,
//                                               // height: 140,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Container(
//                                                 width: SizeConfig.w * 0.4,
//                                                 child: Text(item.currentData[si]
//                                                     .serviceName)),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(item?.currentData[si]
//                                                             ?.offeredPrice !=
//                                                         null
//                                                     ? getPrice(double.parse(item
//                                                         ?.currentData[si]
//                                                         ?.offeredPrice))
//                                                     : ""),
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 8.0),
//                                                   child: Text(
//                                                     getPrice(double.parse(
//                                                       item.currentData[si]
//                                                           .price,
//                                                     )),
//                                                     style: new TextStyle(
//                                                       color: Colors.black45,
//                                                       decoration: TextDecoration
//                                                           .lineThrough,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Spacer(),
//                                       Container(
//                                           margin: EdgeInsets.only(right: 2),
//                                           color: Colors.white,
//                                           alignment: Alignment.centerRight,
//                                           child: GestureDetector(
//                                             child: Icon(
//                                               Icons.remove_circle,
//                                               size: 25,
//                                               color: Theme.of(context)
//                                                   .primaryColor,
//                                             ),
//                                             onTap: () {
//                                               Provider.of<Service>(context,
//                                                       listen: false)
//                                                   .subQuan(
//                                                       item.currentData[si]);
//                                             },
//                                           )),
//                                       Container(
//                                         margin: EdgeInsets.all(5),
//                                         child: Text(item
//                                             .currentData[si].quantity
//                                             .toString()),
//                                       ),
//                                       Container(
//                                           margin: EdgeInsets.only(right: 2),
//                                           color: Colors.white,
//                                           alignment: Alignment.centerRight,
//                                           child: GestureDetector(
//                                             child: Icon(
//                                               Icons.add_circle,
//                                               size: 25,
//                                               color: Theme.of(context)
//                                                   .primaryColor,
//                                             ),
//                                             onTap: () {
//                                               Provider.of<Service>(context,
//                                                       listen: false)
//                                                   .addQuan(
//                                                       item.currentData[si]);
//                                             },
//                                           ))
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Card(
//                                 elevation: 5,
//                                 margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
//                                 child: Html(
//                                     data: item.currentData[si].description),
//                               ),
//                               Container(
//                                 height: 20,
//                               )
//                             ],
//                           ),
//                         );
//                       }),
//                   Container(
//                     // margin: EdgeInsets.only(left: 15),
//                     height: 50,
//                   )
//                 ]),
//               ),
//         floatingActionButton: Container(
//           // margin: EdgeInsets.only(left: 15),
//           height: 50,
//           width: SizeConfig.w * 0.91,
//           padding: EdgeInsets.only(left: 5),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(
//               Radius.circular(5),
//             ),
//             color: Colors.black,
//           ),
//           child: Row(
//             children: [
//               Container(
//                 margin: EdgeInsets.all(7),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(5),
//                   ),
//                   color: Colors.white,
//                 ),
//                 width: 60,
//                 // height: 45,
//                 padding: EdgeInsets.all(1),
//                 child: Stack(
//                   alignment: AlignmentDirectional.topEnd,
//                   children: [
//                     Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Icon(
//                           Icons.shopping_cart_outlined,
//                           size: 38,
//                         )),
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: Container(
//                         // width: 25,
//                         // alignment: Alignment.topRight,
//                         child: Text(
//                           // "1",

//                           (item?.cartData?.length ?? 0).toString(),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 12, color: Colors.white),
//                         ),
//                         padding: EdgeInsets.all(6),
//                         decoration: BoxDecoration(
//                           color: Colors.black, shape: BoxShape.circle,
//                           // borderRadius: BorderRadius.all(Radius.circular(10))
//                         ),
//                         // constraints: BoxConstraints(
//                         //     minWidth: 16, maxWidth: 19, minHeight: 16, maxHeight: 18),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Text(
//                 getPrice(item.totalPrice),
//                 style: TextStyle(fontSize: 16, color: Colors.white),
//               ),
//               Spacer(),
//               Container(
//                   margin: EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(5),
//                     ),
//                     color: Colors.white,
//                   ),
//                   child: TextButton(
//                       onPressed: () async {
//                         print(item?.addonsData.length);
//                         if ((item?.cartData?.isNotEmpty ??
//                             false)) if (item?.addonsData?.isNotEmpty ?? false)
//                           await showModalBottomSheet(
//                               backgroundColor: Colors.white,
//                               // enableDrag: true,
//                               isScrollControlled: true,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: const Radius.circular(25.0),
//                                     topRight: const Radius.circular(25.0)),
//                               ),
//                               context: context,
//                               builder: (context) {
//                                 return AddOnBottom(
//                                   addOnData: item?.addonsData ?? [],
//                                 );
//                               });
//                         else {
//                           Navigator.pushNamed(context, "/OrderScreen");
//                         }
//                         else {
//                           Fluttertoast.showToast(
//                             msg: "Please add item to cart!!",
//                             backgroundColor: Colors.grey[400],
//                             toastLength: Toast.LENGTH_LONG,
//                             gravity: ToastGravity.CENTER,
//                             timeInSecForIosWeb: 3,
//                           );
//                         }
//                       },
//                       child: Text(
//                         "Continue",
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       )))
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
