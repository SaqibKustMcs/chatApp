import 'package:chatapp/Screens/chatModule/homeScreen.dart';
import 'package:chatapp/Services/chatServices.dart';
import 'package:chatapp/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../Services/helper.dart';
import '../controller/appController.dart';
import '../customTextFormField.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
   SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ChatServices _chatServices=ChatServices();
  UserModel _userModel=UserModel();
  TextEditingController _nameC =TextEditingController();
  TextEditingController _emailC=TextEditingController();
  TextEditingController _pwdC=TextEditingController();

  bool value = false;
  bool isLoading = false;
  final _appController=Get.find<AppController>();


  bool visible=false;

  makeLoadingTrue() {
    isLoading = true;
    setState(() {});
  }

  makeLoadingFalse() {
    isLoading = false;
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailC.dispose();
    _pwdC.dispose();
    _nameC.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // print("mmmmmm hy rozaaa baoo okhaa,,,,,,,,,,,,,,,,,,,,"
    // );
    return Scaffold(
      backgroundColor: Color(0xff424242),
      body: LoadingOverlay(
         opacity: 0.2,

        isLoading:isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Form(
                     key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50,),
                      // Container(
                      //   height: 130,
                      //   width: 130,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     border: Border.all(
                      //         width: 7, color: Color(0xffD9D9D9)),
                      //   ),
                      //   child: Image.asset("assets/images/splash.png"),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Let’s get started!",
                        style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffD9D9D9)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Create an account to start memorizing Bible verse now, keep track of streaks, and  synced across devices.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffD9D9D9)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFields(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Name is Required';
                          }



                          return null;
                        },
                        controller: _nameC,
                        hintText: "Name",
                        prefixIcon: Icon(Icons.person,color:Color(0xffD9D9D9)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFields(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email is Required';
                          }

                          if (!RegExp(
                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(value)) {
                            return 'Please enter a valid email Address';
                          }

                          return null;
                        },
                        controller: _emailC,
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email_rounded,color: Color(0xffD9D9D9),),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFields(
                        controller: _pwdC,
                        validator:  (value) {
                if (value.isEmpty) {
                return "* Password is  Required";
                } else if (value.length < 6) {
                return "Password should be atleast 6 characters";
                } else if (value.length > 15) {
                return "Password should not be greater than 15 characters";
                } else
                return null;
                },
                        obscure: visible==true?false:
                        true,
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock,color: Color(0xffD9D9D9),),

                        leadinIcon: InkWell(
                            onTap: (){
                              setState(() {
                                visible==true?visible=false:visible=true;

                              });
                            },
                            child: Icon(visible==true?Icons.visibility_off:Icons.visibility,color: Color(0xffD9D9D9),),),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Checkbox(
                            fillColor: MaterialStateProperty.all(Colors.grey),
                            checkColor: Colors.black,
                            activeColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            value: this.value,
                            onChanged: (value) {
                              setState(() {
                                this.value = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: Container(

                              child: RichText(text:
                                 TextSpan(
                                 text: "By using KJVERSE, I agree with our ",

                                  style: GoogleFonts.poppins(

                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color:Color(0xffD9D9D9)),
                                   children: [
                                     TextSpan(
                                       text: "Term & Conditions And Privacy Policy",
                                       style: GoogleFonts.poppins(


                                           fontSize: 13,
                                           fontWeight: FontWeight.w700,
                                           color: Color(0xffD9D9D9)),
                                     )
                                   ]
                                ),


                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          // Container(
                          //   height: 50,
                          //   width: 100,
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(20)
                          //   ),
                          //   child: Image.asset("assets/images/google.png"),
                          //
                          // ),
                          // SizedBox(width: 10,),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()&& value==true) {

                                  // _userModel.uPassword=_pwdC.text;
                                  // _userModel.uEmail=_emailC.text;
                                  // _userModel.uName=_nameC.text;
                                  // _userModel.uProfileImage="";
                                  // _userModel.aboutUs="how are you";
                                  // _userModel.uId=getUserID();
                                  // _userModel.isOnline=true;
                                  //
                                  // _chatServices.createUser( userModel: _userModel).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())));
                                   _signUpUser(context);
                                  return;



                                }
                                // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>VerificationMethod()), (route) => false);
                              },
                              child: Container(
                                height: 50,

                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    "Sign Up",
                                    style: GoogleFonts.poppins(
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an Account? ",
                            style: TextStyle(color: Color(0xffD9D9D9)),
                          ),
                          InkWell(
                            onTap: () {


                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              "sign in",
                              style: TextStyle(color: Colors.yellow),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  _signUpUser(BuildContext context) async {
    makeLoadingTrue();
    FocusScope.of(context);
    try {
      ///This will allow user to register in firebase
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emailC.text, password: _pwdC.text)
          .whenComplete(() {
        FirebaseFirestore.instance.collection('users').doc(getUserID()).set({
          'UserName': _nameC.text,
          'UserEmail': _emailC.text,
          'UserPassword': _pwdC.text,
          'userImage':"",
          'uId':getUserID(),
          'token':_appController.token.value,
          'termAndServices':"${value}",
          'aboutUs':"${_appController.aboutUs}",
        'nativeLanguage':"${_appController.nativeLanguage}",
          'bibleMemorization':"${_appController.bibleMemorization}"



        });
        makeLoadingFalse();
      })
          .then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              backgroundColor: Color(0xff424242),
              title: Text('Message!',style: TextStyle(color: Color(0xffD9D9D9))),
              content: Text("Registered successfully",style: TextStyle(color: Color(0xffD9D9D9))),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay',style: TextStyle(color: Color(0xffD9D9D9))),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  },
                ),
              ],
            );
          },
        );
      });
    } on FirebaseAuthException catch (ex) {
      makeLoadingFalse();
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('ALert!',style: TextStyle(color: Color(0xffD9D9D9))),
            content: Text(ex.message!,style: TextStyle(color: Color(0xffD9D9D9))),
            actions: <Widget>[
              TextButton(
                child: Text('Okay',style: TextStyle(color: Color(0xffD9D9D9)),),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                },
              ),
            ],
          );
        },
      );
    }
  }
  String? validateEmail(String? value) {
    String pattern =

        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    ;
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }
}
