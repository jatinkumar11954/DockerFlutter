//! RouteGenerator : All routes used throughout the app

import 'package:athome_partner_app/auth/Forgot.dart';
import 'package:athome_partner_app/auth/ResetPassword.dart';
import 'package:athome_partner_app/screens/Notifications.dart';
import 'package:athome_partner_app/screens/Orders.dart';
import 'package:athome_partner_app/screens/booking.dart';
import 'package:athome_partner_app/screens/home_screen.dart';
import 'package:athome_partner_app/screens/orderScreen.dart';
import 'package:athome_partner_app/screens/profile.dart';
import 'package:athome_partner_app/screens/settings.dart';
import 'package:athome_partner_app/screens/splash_screen.dart';
import 'package:athome_partner_app/screens/wallet.dart';
import 'package:flutter/material.dart';

import 'auth/ForgotOtp.dart';
import 'auth/login.dart';
import 'auth/register.dart';
import 'elements/addAddress.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/WalkThroughPage':
      //   return MaterialPageRoute(
      //     builder: (context) => WalkThroughPage(),
      //   );
      // case '/WelcomePage':
      //   return MaterialPageRoute(
      //     builder: (context) => WelcomePage(),
      //   );
      // case '/CreateAccountPage':
      //   return MaterialPageRoute(
      //     builder: (context) => CreateAccountPage(),
      //   );
      case '/Login':
        return MaterialPageRoute(
          builder: (context) => Login(),
        );
      case '/Login':
        return MaterialPageRoute(
          builder: (context) => Login(),
        );
      case '/Wallet':
        return MaterialPageRoute(
          builder: (context) => Wallet(),
        );
      case '/Profile':
        return MaterialPageRoute(
          builder: (context) => Profile(),
        );
      // case '/Orders':
      //   return MaterialPageRoute(
      //     builder: (context) => Orders(),
      //   );
      case '/Notifications':
        return MaterialPageRoute(
          builder: (context) => NotificationScreen(),
        );
      case '/HomeScreen':
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case '/AddAddress':
        return MaterialPageRoute(
          builder: (context) => AddAddress(),
        );
      case '/Orders':
        return MaterialPageRoute(
          builder: (context) => BookingScreen(),
        );
      // case '/OrderScreen':
      //   return MaterialPageRoute(
      //     builder: (context) => OrderScreen(),
      //   );
      case '/SettingScreen':
        return MaterialPageRoute(
          builder: (context) => SettingScreen(),
        );
      case '/ResetPassword':
        return MaterialPageRoute(
          builder: (context) => ResetPassword(),
        );
      case '/Forgot':
        return MaterialPageRoute(
          builder: (context) => Forgot(),
        );
      case '/ForgotOtp':
        return MaterialPageRoute(
          builder: (context) => ForgotOtp(),
        );
      case '/Register':
        return MaterialPageRoute(
          builder: (context) => Register(),
        );
      // case '/LoginotpPage':
      //   return MaterialPageRoute(
      //     builder: (context) => LoginotpPage(),
      //   );
      // case '/PasswordRecoveryPage':
      //   return MaterialPageRoute(
      //     builder: (context) => PasswordRecoveryPage(),
      //   );
      // case '/PasswordRecoveryCodePage':
      //   return MaterialPageRoute(
      //     builder: (context) => PasswordRecoveryCodePage(),
      //   );
      // case '/SetNewPasswordPage':
      //   return MaterialPageRoute(
      //     builder: (context) => SetNewPasswordPage(),
      //   );
      // case '/HomePage':
      //   return MaterialPageRoute(
      //     builder: (context) => HomePage(),
      //   );
      // case '/MainPage':
      //   return MaterialPageRoute(
      //     builder: (context) => MainPage(),
      //   );
      // case '/SettingsPage':
      //   return MaterialPageRoute(
      //     builder: (context) => SettingsPage(),
      //   );
      // case '/ProfileEditPage':
      //   return MaterialPageRoute(
      //     builder: (context) => ProfileEditPage(),
      //   );
      // case '/PaymentMethodsPage':
      //   return MaterialPageRoute(
      //     builder: (context) => PaymentMethodsPage(),
      //   );
      // case '/ShippingAddressPage':
      //   return MaterialPageRoute(
      //     builder: (context) => ShippingAddressPage(),
      //   );
      // case '/ChooseCountryShippingAddressPage':
      //   return MaterialPageRoute(
      //     builder: (context) => ChooseCountryShippingAddress(),
      //   );
      // case '/AboutAppPage':
      //   return MaterialPageRoute(
      //     builder: (context) => AboutAppPage(),
      //   );
      // case '/RecentlyViewedPage':
      //   return MaterialPageRoute(
      //     builder: (context) => RecentlyViewedPage(),
      //   );
      // case '/SearchPage':
      //   return MaterialPageRoute(
      //     builder: (context) => SearchPage(),
      //   );
      // case '/CheckOutPage':
      //   return MaterialPageRoute(
      //     builder: (context) => CheckOutPage(),
      //   );
      // case '/TrackOrderPage':
      //   return MaterialPageRoute(
      //     builder: (context) => TrackOrderPage(),
      //   );
      // case '/ItemDetailPage':
      //   return MaterialPageRoute(
      //     builder: (context) => ItemDetailPage(),
      //   );
      // case '/AllReviewPage':
      //   return MaterialPageRoute(
      //     builder: (context) => AllReviewPage(),
      //   );
      // case '/HistoryPage':
      //   return MaterialPageRoute(
      //     builder: (context) => HistoryPage(),
      //   );
      // case '/VoucherPage':
      //   return MaterialPageRoute(
      //     builder: (context) => VoucherPage(),
      //   );
      // case '/LanguageSelectionPage':
      //   return MaterialPageRoute(
      //     builder: (context) => LanguageSelectPage(),
      //   );
      // case '/AllCategoriesPage':
      //   return MaterialPageRoute(
      //     builder: (context) => AllCategoriesPage(),
      //   );
      // case '/CategoriesFilterPage':
      //   return MaterialPageRoute(
      //     builder: (context) => CategoriesFilterPage(),
      //   );
      // case '/OrderStatusPage':
      //   return MaterialPageRoute(
      //     builder: (context) => OrderStatusPage(),
      //   );
      // case '/FilterPage':
      //   return MaterialPageRoute(
      //     builder: (context) => FilterPage(),
      //   );
      // case '/CountrySelectPage':
      //   return MaterialPageRoute(
      //     builder: (context) => CountrySelectPage(),
      //   );
      // case '/CurrencySelectPage':
      //   return MaterialPageRoute(
      //     builder: (context) => CurrencySelectPage(),
      //   );
      // case '/SizesSelectPage':
      //   return MaterialPageRoute(
      //     builder: (context) => SizesSelectPage(),
      //   );
      // case '/TermsAndConditionsPage':
      //   return MaterialPageRoute(
      //     builder: (context) => TermsAndConditions(),
      //   );
      default:
        {
          return MaterialPageRoute(
            builder: (context) => WelcomePage(),
          );
        }
    }
  }
}
