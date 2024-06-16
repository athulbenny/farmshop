import 'package:farm_to_me/screen/login/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/users.dart';
import 'homepage/homepage.dart';


class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserObj?>(context);
    if(user==null){
      return Authenticate();
    }
    else{
      return HomePage(user: user,);
    }
  }
}