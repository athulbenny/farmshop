import 'package:farm_to_me/models/users.dart';
import 'package:farm_to_me/screen/homepage/Customer/customer.dart';
import 'package:farm_to_me/services/databaseManager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Delivery/delivery.dart';
import 'Farmer/farmers_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({required   this.user});
  final UserObj user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        initialData: null,
        value: UserLoginDataSaving().users,
        child: SwitchUser(user:widget.user)
    );
  }
}


class SwitchUser extends StatefulWidget {
  const SwitchUser({required   this.user});
  final UserObj user;
  @override
  State<SwitchUser> createState() => _SwitchUserState();
}

class _SwitchUserState extends State<SwitchUser> {
  String? role;UserDetails? udet;

  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<List<UserDetails>?>(context) ?? [];
    print(userList.length);
    for (int i = 0; i < userList.length; i++) {
      if (userList[i].email == widget.user.email) {
        role = userList[i].role;
        udet=userList[i];
        break;
      }
    }
    if (role == "Farmer") {
      return Farmer1(userdetails: udet!);
    }
    else if (role == "Consumer") {
      return Customer1(userdetails: udet!,);
    }
    else if(role == "Supporter"){
      return delivery(userdetails: udet!,);
    }
    else{
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade700,
          toolbarHeight: 80,
          title: Text("Home",style: GoogleFonts.poppins(),),
        ),
        body: Center(child: Text("Data is being loaded...",style: GoogleFonts.poppins(),)),
      );
    }
  }
}