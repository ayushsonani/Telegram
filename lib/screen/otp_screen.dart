import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:telegram/controller/logics.dart';
import 'package:telegram/screen/profile_edit_screen.dart';

class OtpScreen extends StatelessWidget {
  TextEditingController q1 = TextEditingController();
  TextEditingController q2 = TextEditingController();
  TextEditingController q3 = TextEditingController();
  TextEditingController q4 = TextEditingController();
  TextEditingController q5 = TextEditingController();
  TextEditingController q6 = TextEditingController();
  TextEditingController otp = TextEditingController();
  String phone_verify_id = "";

  OtpScreen(this.phone_verify_id);

  @override
  Widget build(BuildContext context) {
    Controller controller = Provider.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Enter a Otp "),
          Form(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 15.5,
                width: MediaQuery.of(context).size.width / 7.5,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: q1,
                  onSaved: (newValue) {
                    print("1");
                  },
                  style: Theme.of(context).textTheme.headline6,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.length == 1) {
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
                height: MediaQuery.of(context).size.height / 15.5,
                width: MediaQuery.of(context).size.width / 7.5,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: q2,
                  onSaved: (newValue) {
                    print("------------------------------------1");
                  },
                  style: Theme.of(context).textTheme.headline6,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.length == 1) {
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
                height: MediaQuery.of(context).size.height / 15.5,
                width: MediaQuery.of(context).size.width / 7.5,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: q3,
                  onSaved: (newValue) {
                    print("1");
                  },
                  style: Theme.of(context).textTheme.headline6,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.length == 1) {
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
                height: MediaQuery.of(context).size.height / 15.5,
                width: MediaQuery.of(context).size.width / 7.5,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: q4,
                  onSaved: (newValue) {
                    print("1");
                  },
                  style: Theme.of(context).textTheme.headline6,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.length == 1) {
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
                height: MediaQuery.of(context).size.height / 15.5,
                width: MediaQuery.of(context).size.width / 7.5,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: q5,
                  onSaved: (newValue) {
                    print("1");
                  },
                  style: Theme.of(context).textTheme.headline6,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.length == 1) {
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
                height: MediaQuery.of(context).size.height / 15.5,
                width: MediaQuery.of(context).size.width / 7.5,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: q6,
                  onSaved: (newValue) {
                    print("1");
                  },
                  style: Theme.of(context).textTheme.headline6,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                      otp.text = q1.text +
                          q2.text +
                          q3.text +
                          q4.text +
                          q5.text +
                          q6.text;
                      print(
                          "gggggggggggggggggggggggggggggggggggggggggggggggg:= ${otp.text}");
                    }
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            ],
          )),
          ElevatedButton(
              onPressed: () {
                // otp is true or not check this function use
                controller.otp_chack(otp.text, phone_verify_id);

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ChangeNotifierProvider(
                      create: (context) => Controller(),
                      child: ProfileEditScreen(),
                    );
                  },
                ));
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
