import 'dart:ffi';

import 'package:chatapp/Screens/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  bool? visibility;
  bool? icon;
  String? rImage;
  bool? image;
  CustomAppBar(
      {Key? key, required this.title, this.visibility, this.icon, this.image,this.rImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                )),
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(6),
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffabcc44),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(30)),
                ),
                child: Center(
                    child: Row(
                  mainAxisAlignment: image==true?MainAxisAlignment.start:MainAxisAlignment.spaceBetween,
                  children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: visibility == true
                            ? Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Icon(
                            CupertinoIcons.arrow_left,
                            color: Colors.white,
                            size: 25,
                          ),
                        )
                            : SizedBox(),
                      ),
                      image == true
                          ? Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage("${rImage}"))),
                      )
                          : SizedBox(),
                    ],
                  ),
                    Text(
                      "${this.title}",
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: icon == true
                          ? InkWell(
                              onTap: () {
                                logOut();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (route) => false);
                              },
                              child: Icon(
                                Icons.login,
                                color: Colors.white,
                              ))
                          : null,
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 8,
                decoration: BoxDecoration(
                  color: Color(0xffabcc44),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 30),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 5,
                decoration: BoxDecoration(
                    // Color(0xff007bff)

                    color: Colors.black,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(30))),
              ),
            )
          ],
        ),
      ],
    );
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
