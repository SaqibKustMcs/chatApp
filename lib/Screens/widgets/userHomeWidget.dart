import 'package:chatapp/Services/helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../chatModule/chatRoom.dart';
class UserHomeWidget extends StatefulWidget {

  String? sName;
  String? sImage;
  String? sId;
  String? sToken;

  String? rId ;
  String? rName;
  String? rToken;
  String? rImage;


  String chatid;
  String? timestamp;
  String msgText;


   UserHomeWidget({Key? key,this.rId,this.rName,required this.msgText,this.timestamp,this.rImage,this.sId,required this.chatid,this.rToken, required this.sToken,this.sImage,this.sName,
   }) : super(key: key);

  @override
  State<UserHomeWidget> createState() => _UserHomeWidgetState();
}

class _UserHomeWidgetState extends State<UserHomeWidget> {
  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatRoom(rEmail: "" ,rName:"${widget.rName}" ,rId: "${widget.rId}",  rImage:"${widget.rImage}",sId:"${widget.sId}" ,chatId: widget.chatid,rToken: widget.rToken,sToken: widget.sToken,)));

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 4),
        child: Stack(
          children: [
            Container(
              height: 77,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Container(height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange.shade100,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image:widget.sId==getUserID()? NetworkImage("${widget.rImage}"):NetworkImage("${widget.rImage}")
                      )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${widget.rName}",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),)
                          ,Text("${widget.msgText}",maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black),)

                        ],
                      ),
                    ),
                  ),
                ],
              ),

            ),
            Positioned.fill(

              top: 4,


                child:  Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${widget.timestamp}",style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black),),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
