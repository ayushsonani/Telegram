import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class App_ui_widget {
   Widget otp_container({required BuildContext context,required TextEditingController? textEditingController,required TextEditingController? saveotp}){
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height/15.5,
      width: MediaQuery.of(context).size.width/7.5,
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(width: 1,),
          borderRadius: BorderRadius.circular(15)
      ),
      child: TextFormField(
        decoration:InputDecoration(
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none)
        ),
        controller: textEditingController,
        onSaved: (newValue) {
          print("1");
        },
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if(value.length == 1){
            FocusScope.of(context).nextFocus();
            saveotp?.text = saveotp.text + textEditingController!.text;
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}