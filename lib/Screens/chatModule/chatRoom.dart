import 'dart:convert';
import 'dart:io';
import 'package:chatapp/controller/appController.dart';
import 'package:crypto/crypto.dart';

import 'package:chatapp/Screens/widgets/customAppBar.dart';
import 'package:chatapp/Services/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart'as http;

import '../../models/messageModel.dart';

class ChatRoom extends StatefulWidget {
  String? chatId;

  String? sId;
  String? sName;
  String? sImage;
  String? sToken;


  String rId;
  String? rEmail;
  String rName;
  String? rImage;
  String? rToken;



  ChatRoom(
      {Key? key, required this.rEmail, required this.rId, required this.rName,required this.rImage,this.sId,this.chatId,this.rToken,this.sToken})
      : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  File? _file;
  TextEditingController textController = TextEditingController();
   AppController appController=Get.find<AppController>();
  bool check = true;

  var combieChatId;
  // List chatIds = [];
  // bool chatIds=

  @override
  // updateChatRoom() async {
  //   await FirebaseFirestore.instance.collection("users").doc(getUserID()).set({
  //     'chatIds': {combieChatId},
  //     'UserName': 'saqib ali',
  //     'UserEmail': "saqibali@gmail.com",
  //     'UserPassword': 123456,
  //     'uId': getUserID(),
  //     'termAndServices': "${true}",
  //     'aboutUs': "hy",
  //     'nativeLanguage': "urdu",
  //     'bibleMemorization': "no"
  //   });
  // }

  void initState() {



  createCombinedId(user1: getUserID() , user2:widget.rId);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print(";;;;;;;mmmmmmmmmmmmmmmmmm;;;;;;;;");

    print(widget.chatId);
    print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");


    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body:InkWell(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  children: [
                    CustomAppBar(title: "${widget.rName}",image: true,rImage: "${widget.rImage}",visibility: true),
                    Expanded(
                      // 5f23ff0ee49a94920ec64a9fa886a58a1d138277

                      child: StreamBuilder(
                          stream:widget.chatId==""? FirebaseFirestore.instance
                              .collection("message")
                              .doc(appController.combinedId.value)
                              .collection("messages")
                              .orderBy("timestamp", descending: true)
                              .snapshots():
                          FirebaseFirestore.instance
                              .collection("message")
                              .doc(widget.chatId)
                              .collection("messages")
                              .orderBy("timestamp", descending: true)
                              .snapshots(),

                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              print(appController.combinedId);
                              var data = snapshot.data.docs;
                              print(data);

                              return ListView.builder(

                                reverse: true,
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  print(data[index]['messageContent']);
                                  Timestamp timestamp = data[index]['timestamp'];
                                  DateTime dateTime =
                                  DateTime.fromMillisecondsSinceEpoch(
                                      timestamp.seconds * 1000);
                                  String formatter =
                                  DateFormat.jm().format(dateTime);

                                  print(timestamp);
                                  return messageContainer(
                                      myId: '${data[index]["senderId"]}',
                                      text: "${data[index]["messageContent"]}",
                                      timestamp: formatter,
                                      docId: '${data[index]["docId"]}');
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Center(child: Icon(Icons.error_outline));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {

                              });
                            },
                            style: GoogleFonts.dmSans(color: Colors.black),
                            controller: textController,

                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: ()async{
                                      try {
                                        await getFile();
                                        setState(() {

                                        });


                                        // if (image != null) {
                                        //   // Upload the image to Firebase Storage
                                        //
                                        //   Reference ref = FirebaseStorage.instance.ref().child('images/$image');
                                        //   TaskSnapshot uploadTask = await ref.putFile(File(image.path));
                                        //   String imageUrl = await uploadTask.ref.getDownloadURL();
                                        //   print(imageUrl);
                                        //   // Do something with the image URL
                                        // }
                                      } catch (e) {
                                        print('Error selecting image: $e');
                                      }

                                    },
                                    child: Icon(Icons.camera_alt_outlined,color: Colors.blueGrey,)),
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                                hintText:file?.name!=null?"saqib": "Enter your text",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide(color: Colors.green)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide(color: Colors.green))),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        InkWell(
                          onTap:widget.chatId==""? () {
                            textController.text.trim().isEmpty ||
                                textController.text.trim() == ''
                                ? null
                                :sendMessage(myId: "", receiverId: "");
                            // :widget.chatId==""? sendMessageHome(myId: '', receiverId: ''):sendMessage(myId: '', receiverId: "", messageContent: "");
                          }:() {
                            textController.text.trim().isEmpty ||
                                textController.text.trim() == ''
                                ? null
                                :sendMessageHome(myId: "", receiverId: "");
                            // :widget.chatId==""? sendMessageHome(myId: '', receiverId: ''):sendMessage(myId: '', receiverId: "", messageContent: "");
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: textController.text.trim().isEmpty ||
                                    textController.text == ''
                                    ? Colors.brown.shade100
                                    : Colors.green,
                                shape: BoxShape.circle),
                            child: textController.text.trim().isEmpty
                                ? Icon(Icons.send)
                                : Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      )


    );
  }

  String currentId = getUserID();
  void  createCombinedId({required String user1, required String user2}) {

    // Concatenate the user IDs in alphabetical order

    String userId1 = user1;
    String userId2 = user2;
    String combinedId = '';
    if (userId1.compareTo(userId2) < 0) {
      combinedId = userId1 +'_'+userId2;
    } else {
      combinedId = userId2 +"_"+ userId1;
    }
    // Hash the combined ID to create a unique ID
    var bytes = utf8.encode(combinedId);
    appController.combinedId.value = sha1.convert(bytes).toString();
    print(appController.combinedId);

  }



   // String result = getUserID() + widget.rId;
   // final CollectionReference messagesCollection = FirebaseFirestore.instance.collection('message').doc(digest).collection('messages');

  Future<void> sendMessage(
      {required String myId,
      required String receiverId,
      String? messageContent}) async {
    // createCombinedId(user1: getUserID(), user2: widget.rId);
    CollectionReference userDetail = await FirebaseFirestore.instance
        .collection('users');
    var sender=await userDetail.doc(getUserID()).get();
    var receiver=await userDetail.doc(widget.rId).get();
    print("mmmmmmm mmmmmmm mmmmmmm mmmmmmmm mmmmmmm");
    CollectionReference messages = await FirebaseFirestore.instance
        .collection('message')
        .doc(appController.combinedId.value)
        .collection('messages');
    // CollectionReference messages1 = await FirebaseFirestore.instance
    //     .collection('message')
    //     .doc(widget.chatId);
    //     .collection('messages');
    CollectionReference recentChatIds = await FirebaseFirestore.instance
        .collection('recentChatIds').doc(getUserID()).collection("myChatIds");
    CollectionReference recentChatIds1 = await FirebaseFirestore.instance
        .collection('recentChatIds').doc(widget.rId).collection("myChatIds");
    CollectionReference recentChat = await FirebaseFirestore.instance
        .collection('message')
        .doc(appController.combinedId.value)
        .collection('recentChat');
    String id=DateTime.now().toString();

    await messages.doc(id).set({
      'sToken':sender['token'],
      'rToken':receiver['token'],

      'senderId': getUserID(),
      "senderName":sender['UserName'],
      "senderImage":'',
      "reciverName":receiver['UserName'],
      'reciverImage':'',
      'receiverId': widget.rId,
      'messageContent': textController.text,
      'timestamp': Timestamp.now(),
      'chatId': appController.combinedId.value,
      'docId': '${id}',
      'isRead':false,

    }).then((value)async {
      await recentChat.doc(appController.combinedId.value).set({
        'sToken':sender['token'],
        'rToken':receiver['token'],
        'senderId': getUserID(),
        "senderName":sender['UserName'],
        "senderImage":'',
        "reciverName":receiver['UserName'],
        'reciverImage':'',
        'receiverId': widget.rId,
        'messageContent': textController.text,
        'timestamp': Timestamp.now(),
        'chatId':appController.combinedId.value,
        'docId': '${id}',
        'isRead':false,
      });
      await recentChatIds1.doc(appController.combinedId.value).set({

        'sToken':sender['token'],
        'rToken':receiver['token'],
        'senderId': getUserID(),
        "senderName":receiver['UserName'],
        "senderImage":receiver['userImage'],
        "reciverName":sender['UserName'],
        'reciverImage':sender['userImage'],
        'receiverId': widget.rId,
        'messageContent': textController.text,
        'timestamp': Timestamp.now(),
        'chatId': appController.combinedId.value,
        'docId': '${id}',
        'isRead':false,

      });
      await recentChatIds.doc(appController.combinedId.value).set({
        'sToken':sender['token'],
        'rToken':receiver['token'],
        'senderId': getUserID(),
        "senderName":sender['UserName'],
        "senderImage":sender['userImage'],
        "reciverName":receiver['UserName'],
        'reciverImage':receiver['userImage'],
        'receiverId': widget.rId,
        'messageContent': textController.text,
        'timestamp': Timestamp.now(),
        'chatId': appController.combinedId.value,
        'docId': '${id}',
        'isRead':false,
      });

      print(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,${appController.combinedId.value}");
      //
       sendNotification(msgText: "${textController.text}", userName: "${sender['UserName']}", token:"${receiver['token']}" );
      textController.text = '';
      setState(() {});
    });
  }
  Future<void> sendMessageHome(
      {required String myId,
        required String receiverId,
        String? messageContent}) async {
    // createCombinedId(user1: getUserID(), user2: widget.rId);
    CollectionReference userDetail = await FirebaseFirestore.instance
        .collection('users');
    var sender=await userDetail.doc(getUserID()).get();
    var receiver=await userDetail.doc(widget.rId).get();
    print("mmmmmmm mmmmmmm mmmmmHHHHmm mmmmmmmm mmmmmmm");
    CollectionReference messages = await FirebaseFirestore.instance
        .collection('message')
        .doc(widget.chatId)
        .collection('messages');
    CollectionReference recentChatIds = await FirebaseFirestore.instance
        .collection('recentChatIds').doc(getUserID()).collection("myChatIds");
    CollectionReference recentChatIds1 = await FirebaseFirestore.instance
        .collection('recentChatIds').doc(widget.rId).collection("myChatIds");
    CollectionReference recentChat = await FirebaseFirestore.instance
        .collection('message')
        .doc(widget.chatId)
        .collection('recentChat');
    String id=DateTime.now().toString();

    await messages.doc(id).set({
      'sToken':sender['token'],
      'rToken':receiver['token'],
      'senderId': getUserID(),
      "senderName":sender['UserName'],
      "senderImage":'',
      "reciverName":receiver['UserName'],
      'reciverImage':'',
      'receiverId': widget.rId,
      'messageContent': textController.text,
      'timestamp': Timestamp.now(),
      'chatId': widget.chatId,
      'docId': '${id}',
      'isRead':false,
    }).then((value)async {
      await recentChat.doc(widget.chatId).set({
        'sToken':sender['token'],
        'rToken':receiver['token'],
        'senderId': getUserID(),
        "senderName":sender['UserName'],
        "senderImage":'',
        "reciverName":receiver['UserName'],
        'reciverImage':'',
        'receiverId': widget.rId,
        'messageContent': textController.text,
        'timestamp': Timestamp.now(),
        'chatId':widget.chatId,
        'docId': '${id}',
        'isRead':false,
      });
      await recentChatIds1.doc(widget.chatId).set({
        'sToken':sender['token'],
        'rToken':receiver['token'],
        'senderId': getUserID(),
        "senderName":receiver['UserName'],
        "senderImage":receiver['userImage'],
        "reciverName":sender['UserName'],
        'reciverImage':sender['userImage'],
        'receiverId': widget.rId,
        'messageContent': textController.text,
        'timestamp': Timestamp.now(),
        'chatId': widget.chatId,
        'docId': '${id}',
        'isRead':false,

      });
      await recentChatIds.doc(widget.chatId).set({
        'sToken':sender['token'],
        'rToken':receiver['token'],
        'senderId': getUserID(),
        "senderName":sender['UserName'],
        "senderImage":sender['userImage'],
        "reciverName":receiver['UserName'],
        'reciverImage':receiver['userImage'],
        'receiverId': widget.rId,
        'messageContent': textController.text,
        'timestamp': Timestamp.now(),
        'chatId': widget.chatId,
        'docId': '${id}',
        'isRead':false,
      });
      print(",,,,,,,,,,notifi,,,,,,,,,,,,,,,,,,,,,,,,,,,${appController.combinedId.value}");
        sendNotification(msgText: "${textController.text}", userName: "${sender['UserName']}",token: '${receiver['token']}');
      textController.text = '';
      print("notifiii successs");

    });
  }

  Widget messageContainer(
      {required String myId,
      String? text,
      String? timestamp,
      required String docId}) {
    String docId1 = docId.toString();

// print(dateString);
    // DateTime dateTime = DateTime.parse(dateString);
    // String formatter = DateFormat.jm().format(dateTime);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Row(
        mainAxisAlignment: myId == getUserID()
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            padding: EdgeInsets.all(10),
            decoration: myId == getUserID()
                ? BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10)),
                    color: Colors.black)
                : BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(0)),
                    color: Colors.brown),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 8,
                        child: Row(
                          children: [
                            Flexible(
                                child: Text(
                              "${text}",
                              style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 17),
                            )),
                          ],
                        )),
                    InkWell(
                        onTap: () async {
                          print("kkkkkkk");
                          print(docId);
                          print("kkkkkkk");

                          await widget.chatId==""? FirebaseFirestore.instance
                              .collection('message')
                              .doc(combieChatId.toString())
                              .collection('messages')
                              .doc(docId)
                              .delete().whenComplete(() => print("saqib")): FirebaseFirestore.instance
                             .collection('message')
                             .doc(widget.chatId)
                             .collection('messages')
                             .doc(docId)
                             .delete().then((value) => print("delete ssss"));;


                        },
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 19,
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${timestamp}",
                      style: GoogleFonts.dmSans(color: Colors.orange),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  PlatformFile? file;

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = result.files.first;

      print(file?.name);
      print(file?.bytes);
      print(file?.size);
      print(file?.extension);
      print(file?.path);
    } else {
      // User canceled the picker
    }
  }

  static Future sendNotification(
  { String? userName,String? msgText,String? token}
      ) async {
    print("check");
    var appController=Get.find<AppController>();

    try {


      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
        'key=AAAA2g9jceQ:APA91bHXwzjOtSxBaWzpcCZPqVHLbYZy4ICnz3X6MagNe0QFQsEnOWsEZPhBoCyMU83JWKgdfgFzovmOgPglQR7njLb1iibMWhKdxZUdhHBuxrV715Ltm4jKDxKPuo9ct9902TSBFie4'
      };

      var request = http.Request(
          'POST', Uri.parse('https://fcm.googleapis.com/fcm/send?'));

      request.body = json.encode({

        "registration_ids": ["${token}"],
        "data": {
          "requestId":"123456",
          "userId":getUserID(),
          'userrating':5.0,
          'currentLocation':"bbbbb"


        },
        "notification": {

          "body": "${msgText}",
          "title": "${userName}",
          "android_channel_id": "pushnotificationapp",
          "sound": false,
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
      print(response);
      print(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");




      if (response.statusCode == 200) {
        var jsonnn = await response.stream.bytesToString();
        var decoded = jsonDecode(jsonnn);
        print('www');
        print(decoded);
        print('www');
        return decoded;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


}
