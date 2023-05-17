import 'package:chatapp/Screens/widgets/allUserWidget.dart';
import 'package:chatapp/Services/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/customAppBar.dart';
import 'chatRoom.dart';
class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,

      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: 'All Users',),
            SizedBox(),
            Expanded(
              child: StreamBuilder<dynamic>(
                  stream: FirebaseFirestore.instance.collection("users").where('uId',isNotEqualTo: getUserID()).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {


                    if (snapshot.hasData) {
                      var data=snapshot.data.docs;
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            InkWell(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatRoom(rId:'${data[index]['uId']}' ,rName: '${data[index]['UserName']}',rImage:'${data[index]['userImage']}',chatId: "",rEmail: "",)));
                              },

                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 4),
                                child: Container(
                                  height: 75,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    children: [
                                    Expanded(
                                      child: Row(children: [
                                        Container(height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.orange,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage("${data[index]['userImage']}"
                                              )
                                            )
                                          ),

                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${data[index]['UserName']}",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),)
                                            ,Text("${data[index]['UserEmail']}",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black),)

                                          ],
                                        )
                                      ],),
                                    ),
                                      // Column(
                                      //   children: [
                                      //     Text("03:03 PM",style: GoogleFonts.dmSans(color: Colors.orange),)
                                      //   ],
                                      // )
                                    ],
                                  ),

                                ),
                              ),
                            );
                        },

                      );
                    } else if (snapshot.hasError) {
                      return Icon(Icons.error_outline);
                    } else {
                      return Center(child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                    }
                  }),
            )
           
              
          ],
        ),
      ),
    );
  }
}
