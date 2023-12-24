import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram/controller/logics.dart';
import 'package:telegram/screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  double opaciy_ani = 0;

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    animationController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(seconds: 2))..repeat();
    print("value := ${animationController.value}");
    animationController.addListener(() {
      opaciy_ani = animationController.value;
      print("opacity := ${opaciy_ani}");
      setState(() {

      });
    // animationController.animateTo(duration: Duration(seconds: 1));
    });

    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ChangeNotifierProvider(create: (context) => Controller(),child: LoginScreen());
      },));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:AnimatedBuilder(animation: animationController, builder: (context, child) {
          return Opacity(opacity: animationController.value,child: Image.asset("asset/images/telegram_icon.png",height: 200,width: 200,),);
        },)
      ),
    );
  }
}
