import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram/controller/logics.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Controller controller = Provider.of(context);

    TextEditingController num1cont = TextEditingController();
    TextEditingController num2cont = TextEditingController();
    TextEditingController num3cont = TextEditingController();
    TextEditingController num4cont = TextEditingController();
    TextEditingController num5cont = TextEditingController();
    TextEditingController num6cont = TextEditingController();

    FocusNode num1 =FocusNode();
    FocusNode num2 =FocusNode();
    FocusNode num3 =FocusNode();
    FocusNode num4 =FocusNode();
    FocusNode num5 =FocusNode();
    FocusNode num6 =FocusNode();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2,color: Colors.blue)
                ),
                alignment: Alignment.center,
                child: TextField(maxLength: 1,controller: num1cont,focusNode: num1,onEditingComplete: () => num2.requestFocus(),),
              ),
              Container(
                padding: EdgeInsets.all(4),
                width: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2,color: Colors.blue)
                ),
                alignment: Alignment.center,
                child: TextField(controller: num2cont,focusNode: num2,onEditingComplete: () => num2.requestFocus(),),
              ),
            ],
          )
        ],
      ),
    );
  }
}
