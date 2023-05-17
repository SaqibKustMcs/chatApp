import 'package:chatapp/Screens/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../controller/appController.dart';
import '../customTextFormField.dart';
import 'chatModule/homeScreen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailC=TextEditingController();
  TextEditingController _pwdC=TextEditingController();

  bool value = false;
  bool isLoading = false;

  // final _appController=Get.find<AppController>();


  bool visible=true;

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff424242),
      body: LoadingOverlay(
        opacity: 0.2,


        isLoading:isLoading ,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.h,),
                  // Container(
                  //   height: 130.h,
                  //   width: 130.w,
                  //   decoration: BoxDecoration(
                  //
                  //     shape: BoxShape.circle,
                  //     border: Border.all(width: 7,color: Color(0xffD9D9D9)),
                  //
                  //
                  //   )
                  //   ,child: Image.asset("assets/images/splash.png"),
                  //
                  // ),
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Welcome Back!",style: GoogleFonts.poppins(fontSize: 25.sp,fontWeight: FontWeight.w600,color: Colors.white),),
                    ],
                  )
                ,SizedBox(height: 10.h,),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Please Login to your account",style: GoogleFonts.poppins(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Color(0xffD9D9D9)),),
                  ],
                )
                    ,
                    SizedBox(height: 10.h,),
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
                      prefixIcon: Icon(Icons.email_rounded),
                    ),
                      SizedBox(height: 10.h,),

                    CustomTextFields(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "* Password is  Required";
                        } else if (value.length < 6) {
                          return "Password should be atleast 6 characters";
                        } else if (value.length > 15) {
                          return "Password should not be greater than 15 characters";
                        } else
                          return null;
                      },
                      obscure: visible==true?true:false,
                      controller: _pwdC,
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      leadinIcon: InkWell(
                          onTap: (){
                            setState(() {
                              visible==true?visible=false:visible=true;

                            });
                          },

                          child: Icon(visible==true?Icons.visibility:Icons.visibility_off,color: Color(0xffD9D9D9),)),
                    ),
                    SizedBox(height: 10.h,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
                            },
                            child: Text("Fogot Password",style: GoogleFonts.poppins(decoration: TextDecoration.underline,fontSize: 14,fontWeight: FontWeight.w500,color:Colors.white),)),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    GestureDetector(
                      onTap:(){
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context);
                           _loginUser(context);
                          return;



                        }
                        else
                          print("nai ho raha");

                        // _showDialog(context);

                      },
                      child: Container(height: 50.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20.r)
                        ),
                        child: Center(
                          child: Text("Login",style: GoogleFonts.poppins(
                              color: Colors.yellow,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp

                          ),),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an Account? ",style: TextStyle(
                            color: Color(0xffD9D9D9)
                        ),),

                        InkWell(
                          onTap: (){
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                          },
                          child: Text("sign up"
                            ,style: TextStyle(
                                color: Colors.yellow
                            ),),
                        ),
                      ],
                    )


                  ],),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          titleTextStyle: GoogleFonts.poppins(),
          backgroundColor: Color(0xff424242),

          content: Container(
            height: 150.h,
            width: MediaQuery.of(context).size.width*0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text("Oops",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20.sp),),
                SizedBox(height: 10.h,),
                Text("Incorrect email and password combinations. Please use the fogot password below to reset your password",textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12.sp),),
                SizedBox(height: 10.h,),
                Container(
                  height: 0.5.h,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                ),
                SizedBox(height: 10.h,),
                InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>bottomNavigationBar()));
                    },
                    child: Text("Seen",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20.sp),)),


              ],
            ),
          ),

        );
      },
    );
  }
  _loginUser(BuildContext context) async {
    makeLoadingTrue();
    try {
      ///This will allow user to register in firebase
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _emailC.text, password: _pwdC.text)
          .whenComplete(() => makeLoadingFalse())
          .then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              backgroundColor: Color(0xff00005b),
              title: Text('Message!'),
              content: Text("LoggedIn successfully"),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay',style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  },
                ),
              ],
            );
          },
        );
      });
      ;
    } on FirebaseAuthException catch (e) {
      makeLoadingFalse();
      return showDialog<void>(
        context: context,
        barrierDismissible: false,


        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: Color(0xffD9D9D9),

            title: Text('ALert!'),
            content: Text(e.message!),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
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
}
