import 'package:chatapp/Screens/chatModule/allUsers.dart';
import 'package:chatapp/Services/helper.dart';
import 'package:chatapp/controller/appController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';


import '../../Services/notificationservice/local_notification_service.dart';
import '../widgets/customAppBar.dart';
import '../widgets/userHomeWidget.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {







  @override
  void initState() {
    // updateAuthToken()

    updateField("", "fieldName", "");
    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          if (message.data['requestId'] != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  // id: message.data['requestId'],
                ),
              ),
            );
          }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen=====1s===================");
        if (message.notification != null) {
          if (message.data['requestId'] != null) {
            print("${message.data};;;;;;;;;;;;;;;;;;" );

          }
          print(message.notification!.title);
          print("================${message.notification!.title}");
          print("================${message.notification!.body}");
          print("============..............");

          print("message.data11 ${message.data['userId']}");
          print("============..............");
          LocalNotificationService.createanddisplaynotification(message);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
    // TODO: implement initState
    super.initState();
  }
  Future<void> updateField(String? documentId, String? fieldName, dynamic? newValue) async {
    AppController appController=Get.find<AppController>();

    try {
      // Get the document reference
      DocumentReference documentRef = FirebaseFirestore.instance.collection('users').doc(getUserID());

      // Update the specific field
      await documentRef.update({"token":"${appController.token.value}" });
      print('Field updated successfully');
    } catch (error) {
      print('Error updating field: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title:"Home Screen",icon: true,),
            SizedBox(),
            Expanded(
              child: StreamBuilder(
                  stream:FirebaseFirestore.instance.collection('recentChatIds').doc(getUserID()).collection("myChatIds").orderBy("timestamp",descending: true).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var data=snapshot.data.docs;
                      print(data);


                      return  ListView.builder(
                        itemCount: data.length,

                        itemBuilder: (BuildContext context, int index) {
                          Timestamp timestamp = data[index]['timestamp'];
                          DateTime dateTime =
                          DateTime.fromMillisecondsSinceEpoch(
                              timestamp.seconds * 1000);
                          String formatter =
                          DateFormat.jm().format(dateTime);

                          print(timestamp);
                          print(data[index]['messageContent']);
                          return
                            getUserID()==data[index]['senderId']?
                          UserHomeWidget(rName: data[index]['reciverName'],rId: data[index]['receiverId'],msgText: data[index]['messageContent'],timestamp:"${formatter}",rImage: data[index]['reciverImage'] ,sId:data[index]['senderId'] ,chatid:data[index]['chatId'] ,rToken: "",sToken:"",sImage: data[index]['senderImage'] ,sName:data[index]['senderName'] ,)
                            :UserHomeWidget(rName: data[index]['senderName'],rId: data[index]['senderId'],msgText: data[index]['messageContent'],timestamp:"${formatter}",rImage: data[index]['senderImage'] ,sId:data[index]['receiverId'] ,chatid:data[index]['chatId'] ,rToken: "",sToken:"",sImage: data[index]['reciverImage'] ,sName:data[index]['reciverName'] ,);

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AllUsers()));
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
