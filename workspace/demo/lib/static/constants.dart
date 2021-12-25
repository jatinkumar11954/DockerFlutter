import 'package:flutter/material.dart';

const String baseUrl = "https://api-athome.ownimagetech.com/";
// const String baseUrl = "https://2de2-183-83-169-67.ngrok.io/";

const String loginEndPoint = "partner/login";
const String registerEndPoint = "partner/addPartner";
const String partnerUpdateEndPoint = "partner/updatePartner/";
const String getUserEndPoint = "partner/getPartner";
const String updateUserEndPoint = "partner/updatePartner/";
const String addOrderEndPoint = "order/addOrder ";
const String NotificationCountEndPoint =
    "notification/getNotificationCountByPartnerId/";
const String NotificationEndPoint = "order/getOrder/";
const String getOrderEndPoint = "order/getOrderByPartnerId/";
const String paymentEndPoint = "api/paymentDetails?partner_id=";
const String transactionEndPoint = "api/transectionDetails?partner_id=";
const String notificationEndPoint = "notification/getNotificationByPartnerId/";
const String locationCheckEndPoint = "order/locationCheck/";
const String rechargeEndPoint = "api/recharge/paypai";
const String getAllLocationEndPoint = "locations/getAllLocation";

// Method : Post
// action : 'order/locationCheck'
// body:{
// zipCode:"234330"
// }
const String updatePasswordEndPoint = "partner/updatePassword";
const String confirmOrderEndPoint = "order/confirmOrderByPartnerId";
const String RequestOtpEndPoint = "partner/sendOtp";
const String verifyOtpEndPoint = "partner/verifyOtp";
const String dashbardEndPoint = "dashboard";
const String categoryEndPoint = "categories";
const String ribbonEndPoint = "ribbon/getRibbon";
const String bannerEndPoint = "banner/getbanners";
const String offerBannerEndPoint = "offerbanner/getofferbanners";
const String subCategoryEndPoint = "subCategoryByCategoryId";
const String locationEndPoint = "locations/getAllLocation";
const String serviceEndPoint = "service/getAllServices/";
const String fcmEndPoint = "userlog/updateNotificationToken";
const String webviewBase = "https://ticket-management.happimobiles.com/";
String webviewEnd = "signin?id=";
