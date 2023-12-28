import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegram/controller/logics.dart';
import 'package:telegram/screen/home_screen.dart';
import 'package:telegram/screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  double opaciy_ani = 0;

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    animationController.dispose();
  }

  get_share_preference() async {
    Controller.sharedPreferences = await SharedPreferences.getInstance();

    Controller.show = Controller.sharedPreferences?.getBool('show') ?? false;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
    print("value := ${animationController.value}");
    animationController.addListener(() {
      opaciy_ani = animationController.value;
      print("opacity := ${opaciy_ani}");
      setState(() {});
      // animationController.animateTo(duration: Duration(seconds: 1));
    });

    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return ChangeNotifierProvider(
              create: (context) => Controller(),
              child: FirebaseAuth.instance.currentUser?.uid == null
                  ? LoginScreen()
                  : HomeScreen());
        },
      ));

      FirebaseAuth.instance.currentUser?.uid == "" ? null : getData();
    });
  }

  getData() async {
    var data = await FirebaseFirestore.instance.collection('user').get();

    for (int i = 0; i < data.docs.length; i++) {
      if (data.docs[i].data()['user_id'] ==
          FirebaseAuth.instance.currentUser?.uid) {
        Controller.mobile_number = data.docs[i].data()['mobile'];
        Controller.doc_id_sender = data.docs[i].id;
        print(
            "-----------=========== mobile number =======${Controller.mobile_number}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Opacity(
            opacity: animationController.value,
            child: Image.asset(
              "asset/images/telegram_icon.png",
              height: 200,
              width: 200,
            ),
          );
        },
      )),
    );
  }
}
