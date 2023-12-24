import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
             child: Column(
               children: [
                TextFormField(
                  controller: country,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.arrow_forward_ios_rounded),
                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    labelText: "Country",
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.3),fontSize: 20),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.2,color: Colors.black.withOpacity(0.3))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2,color: Colors.blue,)
                    )
                  ),
                ),
                 SizedBox(height: 15,),
                 TextFormField(
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
               ],
             ),
           )),

           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               ElevatedButton(onPressed: () async {
                await controller.phone_auth(phone.text,context);
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
