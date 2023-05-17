import 'package:chatapp/Screens/chatModule/chatRoom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AllUserWidget extends StatefulWidget {
  String userId;
  String uName;

   AllUserWidget({Key? key,required this.uName,required this.userId}) : super(key: key);

  @override
  State<AllUserWidget> createState() => _AllUserWidgetState();
}

class _AllUserWidgetState extends State<AllUserWidget> {
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatRoom()));
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 4),
        child: Container(
          height: 65,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              Container(height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.greenAccent
                ),
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.userId}",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),)
                  ,Text("${widget.uName}",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.white),)

                ],
              )
            ],
          ),

        ),
      ),
    );
  }
}
