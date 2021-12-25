// import 'package:athome_partner_app/model/dashBoard.dart';
// import 'package:athome_partner_app/screens/servicescreen.dart';
// import 'package:athome_partner_app/static/SizeConfig.dart';
// import 'package:athome_partner_app/static/apiServices.dart';
// import 'package:athome_partner_app/static/constants.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// class BottomsubCat extends StatefulWidget {
//   String id;
//   BottomsubCat({Key key, this.id}) : super(key: key);

//   @override
//   _BottomsubCatState createState() => _BottomsubCatState();
// }

// class _BottomsubCatState extends State<BottomsubCat> {
//   showLoading() => setState(() {
//         _isLoading = true;
//       });
//   stopLoading() => setState(() {
//         _isLoading = false;
//       });
//   bool _isLoading = false, searchTap = false;
//   @override
//   void initState() {
//     super.initState();
//     getsub();
//   }

//   List<SubCategory> subCategory = [];
//   getsub() async {
//     showLoading();

//     subCategory = [];
//     Map subCategoryRes =
//         await ApiServices.getRequest(subCategoryEndPoint + "/" + widget.id);
//     // print("llllllllog${subCategoryRes}");
//     if (subCategoryRes != null) {
//       // print("res is not null ${subCategoryRes["isSuccess"]}");
//       if (subCategoryRes["isSuccess"]) {
//         // print("status is true");
//         subCategory = List<SubCategory>.from(
//             subCategoryRes["data"].map((x) => SubCategory.fromMap(x)));
//         stopLoading();
//       } else {
//         stopLoading();
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Container(
//       padding: EdgeInsets.all(5),
//       // height:
//       //     SizeConfig.h * 0.7,
//       child: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : subCategory.isEmpty ?? false
//               ? Center(
//                   child: Text("No Categories Yet"),
//                 )
//               : ListView.builder(
//                   itemCount: subCategory.length,
//                   itemBuilder: (context, si) {
//                     return ListTile(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ServiceScreen(
//                                   subCatId: subCategory[si].id,
//                                 ),
//                               ));
//                         },
//                         title: Text(
//                           subCategory[si].subCategoryName,
//                         ),
//                         trailing: Icon(
//                           Icons.arrow_forward_ios_sharp,
//                         ),
//                         leading: CachedNetworkImage(
//                           imageUrl: subCategory[si].imageUrl,
//                           height: 40,
//                           width: 40,
//                           placeholder: (context, url) => Center(
//                             child: Image.asset(
//                               'images/loading.gif',
//                               height: 40,

//                               fit: BoxFit.cover,
//                               // width: double.infinity,
//                               // height: 140,
//                             ),
//                           ),
//                           errorWidget: (context, url, error) => Center(
//                               child: Image.asset(
//                             'images/banner_home.png',

//                             width: 40,
//                             fit: BoxFit.cover,
//                             // width: double.infinity,
//                             // height: 140,
//                           )),
//                         ));
//                   }),
//     );
//   }
// }
