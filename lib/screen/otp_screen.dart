import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController q1=TextEditingController();
    TextEditingController q2=TextEditingController();
    TextEditingController q3=TextEditingController();
    TextEditingController q4=TextEditingController();
    TextEditingController q5=TextEditingController();
    TextEditingController q6=TextEditingController();
    TextEditingController otp = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Enter a Otp "),
          Form(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
            Container(
              alignment: Alignment.center,
              height: 58,
              width: 58,
              child: TextFormField(
                controller: q1,
                onSaved: (newValue) {
                  print("1");
                },
                style: Theme.of(context).textTheme.headline6,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if(value.length == 1){
                    FocusScope.of(context).nextFocus();
                  }
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 58,
              width: 58,
              child: TextFormField(
                controller: q2,
                onSaved: (newValue) {
                  print("------------------------------------1");
                },
                style: Theme.of(context).textTheme.headline6,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if(value.length == 1){
                    FocusScope.of(context).nextFocus();
                  }
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 58,
              width: 58,
              child: TextFormField(
                controller: q3,
                onSaved: (newValue) {
                  print("1");
                },
                style: Theme.of(context).textTheme.headline6,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if(value.length == 1){
                    FocusScope.of(context).nextFocus();
                  }
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 58,
              width: 58,
              child: TextFormField(
                controller: q4,
                onSaved: (newValue) {
                  print("1");
                },
                style: Theme.of(context).textTheme.headline6,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if(value.length == 1){
                    FocusScope.of(context).nextFocus();
                  }
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 58,
              width: 58,
              child: TextFormField(
                controller: q5,
                onSaved: (newValue) {
                  print("1");
                },
                style: Theme.of(context).textTheme.headline6,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if(value.length == 1){
                    FocusScope.of(context).nextFocus();
                  }
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 58,
              width: 58,
              child: TextFormField(
                controller: q6,
                onSaved: (newValue) {
                  print("1");
                },
                style: Theme.of(context).textTheme.headline6,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if(value.length == 1){
                    FocusScope.of(context).nextFocus();
                    otp.text = q1.text+q2.text+q3.text+q4.text+q5.text+q6.text;
                    print("gggggggggggggggggggggggggggggggggggggggggggggggg:= ${otp.text}");
                  }
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ],))
        ],
      ),
    );
  }
}
