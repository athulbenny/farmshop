import 'package:farm_to_me/screen/login/register.dart';
import 'package:flutter/material.dart';

import 'login.dart';


class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignin = true;
  void toggleView(){
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignin) {
      return Login(toggleView: toggleView);
    }
    else return Register(toggleView : toggleView);

  }
}