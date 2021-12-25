// import 'package:athome_partner_app/helpers/hex_color.dart';
// import 'package:athome_partner_app/model/serviceData.dart';
// import 'package:athome_partner_app/static/SizeConfig.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AddOnBottom extends StatefulWidget {
//   List<AddonsData> addOnData;
//   AddOnBottom({Key key, this.addOnData}) : super(key: key);

//   @override
//   _AddOnBottomState createState() => _AddOnBottomState();
// }

// class _AddOnBottomState extends State<AddOnBottom> {
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Consumer<Service>(builder: (context, item, i) {
//       // print(
//       return Container(
//         height: SizeConfig.h * 0.7,
//         child: Column(
//           children: [
//             Container(
//               height: SizeConfig.h * 0.6,
//               child: ListView.separated(
//                   separatorBuilder: (context, sIndex) {
//                     return Padding(
//                       padding: const EdgeInsets.only(left: 8.0, right: 8),
//                       child: Divider(
//                         height: 2,
//                         thickness: 2,
//                       ),
//                     );
//                   },
//                   shrinkWrap: true,
//                   itemCount: widget?.addOnData?.length ?? 0,
//                   itemBuilder: (context, addIndex) {
//                     AddonsData additem = widget?.addOnData[addIndex];
//                     return ListTile(
//                       title: Text(
//                         additem.addOnName,
//                       ),
//                       subtitle: Text(getPrice(double.parse(
//                         additem.price,
//                       )).toString()),
//                       trailing: Container(
//                         width: 100,
//                         alignment: Alignment.centerRight,
//                         child: Row(
//                           children: [
//                             Container(
//                                 margin: EdgeInsets.only(right: 2),
//                                 color: Colors.white,
//                                 alignment: Alignment.centerRight,
//                                 child: GestureDetector(
//                                   child: Icon(
//                                     Icons.remove_circle,
//                                     size: 25,
//                                     color: Theme.of(context).primaryColor,
//                                   ),
//                                   onTap: () {
//                                     Provider.of<Service>(context, listen: false)
//                                         .subAddOn(item.addonsData[addIndex]);
//                                   },
//                                 )),
//                             Container(
//                               margin: EdgeInsets.all(5),
//                               child: Text(item.addonsData[addIndex].quantity
//                                   .toString()),
//                             ),
//                             Container(
//                                 margin: EdgeInsets.only(right: 2),
//                                 color: Colors.white,
//                                 alignment: Alignment.centerRight,
//                                 child: GestureDetector(
//                                   child: Icon(
//                                     Icons.add_circle,
//                                     size: 25,
//                                     color: Theme.of(context).primaryColor,
//                                   ),
//                                   onTap: () {
//                                     Provider.of<Service>(context, listen: false)
//                                         .addAddOn(item.addonsData[addIndex]);
//                                   },
//                                 ))
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//             ),
//             Spacer(),
//             Container(
//               // margin: EdgeInsets.only(left: 15),
//               height: 50,
//               width: SizeConfig.w * 0.91,
//               padding: EdgeInsets.only(left: 5),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(5),
//                 ),
//                 color: Colors.black,
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.all(7),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(5),
//                       ),
//                       color: Colors.white,
//                     ),
//                     width: 60,
//                     // height: 45,
//                     padding: EdgeInsets.all(1),
//                     child: Stack(
//                       alignment: AlignmentDirectional.topEnd,
//                       children: [
//                         Align(
//                             alignment: Alignment.bottomCenter,
//                             child: Icon(
//                               Icons.shopping_cart_outlined,
//                               size: 38,
//                             )),
//                         Align(
//                           alignment: Alignment.topRight,
//                           child: Container(
//                             // width: 25,
//                             // alignment: Alignment.topRight,
//                             child: Text(
//                               // "1",

//                               (item?.cartData?.length ?? 0).toString(),
//                               textAlign: TextAlign.center,
//                               style:
//                                   TextStyle(fontSize: 12, color: Colors.white),
//                             ),
//                             padding: EdgeInsets.all(6),
//                             decoration: BoxDecoration(
//                               color: Colors.black, shape: BoxShape.circle,
//                               // borderRadius: BorderRadius.all(Radius.circular(10))
//                             ),
//                             // constraints: BoxConstraints(
//                             //     minWidth: 16, maxWidth: 19, minHeight: 16, maxHeight: 18),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Text(
//                     getPrice(item.totalPrice),
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                   Spacer(),
//                   Container(
//                       margin: EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(5),
//                         ),
//                         color: Colors.white,
//                       ),
//                       child: TextButton(
//                           onPressed: () async {
//                             // print(item?.addonsData.length);
//                             // if (item?.addonsData?.isNotEmpty ?? false)
//                             //   await showModalBottomSheet(
//                             //       backgroundColor: Colors.white,
//                             //       // enableDrag: true,
//                             //       // isScrollControlled: true,
//                             //       shape: RoundedRectangleBorder(
//                             //         borderRadius: BorderRadius.only(
//                             //             topLeft: const Radius.circular(25.0),
//                             //             topRight: const Radius.circular(25.0)),
//                             //       ),
//                             //       context: context,
//                             //       builder: (context) {
//                             //         return AddOnBottom(
//                             //           addOnData: item?.addonsData ?? [],
//                             //         );
//                             //       });
//                             // else {
//                             Navigator.pushNamed(context, "/OrderScreen");
//                             // }
//                           },
//                           child: Text(
//                             "Continue",
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           )))
//                 ],
//               ),
//             ),
//             Container(height: 10),
//           ],
//         ),
//       );
//     });
//   }
// }
