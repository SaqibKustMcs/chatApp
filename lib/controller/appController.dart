import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:get/get.dart';




class AppController extends GetxController{
 var aboutUs= "facebook".obs;
 var nativeLanguage="yes".obs;
 var bibleMemorization="1 minute a day".obs;
 var isDark=false.obs;
 List<String> chatIdsList= [''].obs;
  var token=''.obs;
 Rx<String> combinedId="".obs ;





 ///////

 var bottomTabIndex = 0.obs;

 var animation1 = true.obs;
 var loginLoader = false.obs;
 var signUpLoader = false.obs;
 var verifyOtpLoader = false.obs;
 var setBankAccountDetailsLoader = false.obs;
 var sendOtpLoader = false.obs;
 var resetPassLoader = false.obs;
 var changePasswordLoader = false.obs;
 var allProjectsLoader = false.obs;
 var allDealsLoader = false.obs;
 var recommendedProjectsLoader = false.obs;
 var userInvestmentsLoader = false.obs;
 var getLoggedInUserLoader = false.obs;
 var animation1Height = (-Get.height *.1).obs;
 var animation2Height = (-Get.height).obs;
 var profilePicUrl = ''.obs;
 var fullName = ''.obs;


 // changeTheme() {
 //  if (isDark.value) {
 //   primaryColor.value = Color(0xFF4549A4);
 //   primaryIconColor.value = Color(0xFF4549A4);
 //   primaryColorDull.value = Color(0xFF4549A4);
 //   primaryBackgroundColor.value = Color(0xff000000);
 //   cardColor.value = Color(0xff1d2328);
 //   inputFieldTextColor.value = Color(0xffcccccc);
 //   labelColor.value = Color(0xffcccccc);
 //   dullBtnColorV2 = Color(0xFF292B3B).obs;
 //   appShadow.value = [
 //    BoxShadow(
 //     color: Color.fromRGBO(0, 0, 0, 0).withOpacity(0.35),
 //     spreadRadius: 5,
 //     blurRadius: 7,
 //     offset: Offset(0, 3), // changes position of shadow
 //    ),
 //   ];
 //   Get.changeThemeMode(ThemeMode.dark);
 //   Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
 //  } else {
 //   primaryColor.value = Color(0xFF4549A4);
 //   primaryIconColor.value = Color(0xFF4549A4);
 //   primaryColorDull.value = Color(0xFF003F9A);
 //   primaryBackgroundColor.value = Color(0xFFFCFCFC);
 //   inputFieldTextColor.value = Color(0xFF1B2023);
 //   cardColor.value = Color(0xFFFCFCFC);
 //   labelColor.value = Color(0xFF6A6A6A);
 //   dullBtnColorV2 = Color(0xFF474CA8).withOpacity(0.17).obs;
 //   appShadow.value = [
 //    BoxShadow(
 //     color: Color.fromRGBO(155, 155, 155, 15).withOpacity(0.15),
 //     spreadRadius: 5,
 //     blurRadius: 7,
 //     offset: Offset(0, 3), // changes position of shadow
 //    ),
 //   ];
 //  }
 //  Get.changeThemeMode(ThemeMode.light);
 //  Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
 //  print(primaryColor.value);
 // }

}