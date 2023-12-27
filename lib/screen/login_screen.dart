import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:telegram/controller/logics.dart';
import 'package:telegram/controller/uicontroller.dart';
import 'package:telegram/screen/otp_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController phone = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController country = TextEditingController();
  FocusNode phonefoc = FocusNode();
  FocusNode otpfoc = FocusNode();
  @override
  Widget build(BuildContext context) {

    Controller controller = Provider.of(context);


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
       body: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Text("Your Phone",style: TextStyle(
                 color: Colors.black,
                 fontSize: 30,
                 fontFamily: 'telegram',
                 fontWeight: FontWeight.w300,
                 //height: 0.04,
                 letterSpacing: 0.40,
               ),
               ),
             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Container(
                 alignment: Alignment.center,
                 height: MediaQuery.of(context).size.height/20,
                 width: MediaQuery.of(context).size.width/1.5,
                 child: Text("Please confirm your country code and enter your phone number.",textAlign: TextAlign.center,style: Ui.AppText),
               ),
             ],
           ),
           Form(child: Padding(
             padding: EdgeInsets.all(MediaQuery.of(context).size.width/12),
             child: Row(
               children: [
                 SizedBox(
                   width: 80,
                   height: 50,
                   child: TextFormField(
                     controller: country,
                     decoration: InputDecoration(
                         contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                         labelText: "Country",
                         labelStyle: TextStyle(color: Colors.black.withOpacity(0.3),fontSize: 20),
                         enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.2,color: Colors.black.withOpacity(0.3))),
                         focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(width: 2,color: Colors.blue,)
                         )
                     ),
                   ),
                 ),
                 const Padding(
                   padding: EdgeInsets.symmetric(
                       vertical: 7.0),
                   child: VerticalDivider(
                     thickness: 2,
                   ),
                 ),
                 SizedBox(
                   height: 50,
                   width: 200,
                   child: TextFormField(
                     controller: phone,
                     decoration: InputDecoration(
                         suffixIcon: Icon(Icons.arrow_forward_ios_rounded),
                         contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                         labelText: "Phone",
                         labelStyle: TextStyle(color: Colors.black.withOpacity(0.3),fontSize: 20),
                         enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.2,color: Colors.black.withOpacity(0.3))),
                         focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(width: 2,color: Colors.blue,)
                         )
                     ),
                   ),
                 ),
               ],
             ),
           )),

           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               ElevatedButton(onPressed: () async {
                await controller.phone_auth(phone.text,context);
                 controller.user_id_get();
               }, child: Text("Send Otp"))
             ],
           ),


           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               ElevatedButton(onPressed: () {
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                   return ChangeNotifierProvider(create: (context) => Controller(),child: HomeScreen());
                 },));
               }, child: Text("home page"))
             ],
           )
         ],
       ),
    );
  }
}


// class OtpScreen extends StatefulWidget {
//   final String phone;
//
//   const OtpScreen({Key? key, required this.phone}) : super(key: key);
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   String otpCode = "";
//   String otp = "";
//   bool isLoaded = false;
//   final _formKey = GlobalKey<FormState>();
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//   @override
//   void initState() {
//     _listenOtp();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     SmsAutoFill().unregisterListener();
//     print("Unregistered Listener");
//     super.dispose();
//   }
//
//   void _listenOtp() async {
//     await SmsAutoFill().listenForCode();
//     print("OTP Listen is called");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ColorfulSafeArea(
//         color: const Color(0xFF8C4A52),
//         child: SafeArea(
//             child: Scaffold(
//               backgroundColor: isLoaded ? Colors.white : const Color(0xFF8C4A52),
//               body: isLoaded
//                   ? const Center(child: CircularProgressIndicator())
//                   : CustomScrollView(
//                 slivers: [
//                   SliverFillRemaining(
//                     hasScrollBody: false,
//                     child: Column(
//                       children: [
//                         Container(
//                             alignment: Alignment.center,
//                             padding: const EdgeInsets.only(top: 50),
//                             child: Container(
//                               height: 50,
//                             )),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         WhiteContainer(
//                           headerText: "Enter OTP",
//                           labelText:
//                           "OTP has been successfully sent to your \n ${widget.phone}",
//                           child: Container(
//                             height: 70,
//                             width: MediaQuery.of(context).size.width,
//                             child: Column(
//                               children: [
//                                 PinFieldAutoFill(
//                                   currentCode: otpCode,
//                                   decoration: const BoxLooseDecoration(
//                                       radius: Radius.circular(12),
//                                       strokeColorBuilder: FixedColorBuilder(
//                                           Color(0xFF8C4A52))),
//                                   codeLength: 6,
//                                   onCodeChanged: (code) {
//                                     print("OnCodeChanged : $code");
//                                     otpCode = code.toString();
//                                   },
//                                   onCodeSubmitted: (val) {
//                                     print("OnCodeSubmitted : $val");
//                                   },
//                                 )
//
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               bottomNavigationBar: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
//                 color: Colors.white,
//                 child: GestureDetector(
//                   onTap: () async {
//                     print("OTP: $otpCode");
//                     setState(() {
//                       isLoaded = true;
//                     });
//                     if (_formKey.currentState!.validate()) {
//                       try {
//                         PhoneAuthCredential credential =
//                         PhoneAuthProvider.credential(
//                             verificationId: CommonUtils.verify,
//                             smsCode: otpCode);
//                         await auth.signInWithCredential(credential);
//                         setState(() {
//                           isLoaded = false;
//                         });
//                         Navigator.of(context).pushReplacement(MaterialPageRoute(
//                             builder: (context) => const HomeScreen()));
//                       } catch (e) {
//                         setState(() {
//                           isLoaded = false;
//                         });
//                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                             content: Text("Wrong OTP! Please enter again")));
//                         print("Wrong OTP");
//                       }
//                     }
//                   },
//                   child: const BorderBox(
//                     margin: false,
//                     color: Color(0xFF8C4A52),
//                     height: 50,
//                     child: Text(
//                       "Continue",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             )));
//   }
// }