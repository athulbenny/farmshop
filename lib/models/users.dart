import 'package:provider/provider.dart';

class UserObj {
  String uid;
  String email;
  UserObj({required this.uid,required this.email});
}

class UserOb{
  String uid;
  UserOb({required this.uid});
}

class UserDetails{
  String username;
  String email;
  String role;
  String phno;
  UserDetails({required this.role,required this.phno,required this.email, required this.username});
}

class ItemDetails{
  String quantity;String itemid;String date;String loc;String price;String name;String email;
  ItemDetails({required this.date,required this.loc,required this.price,required this.itemid,required this.quantity
    ,required this.name, required this.email});
}

class CartDetails{
  String email;String itemid;String buy;String price;String name;String source;
  CartDetails({required this.itemid,required this.price,
    required this.email,required this.buy,required this.name, required this.source});
}

class ChatDetails{
  String sender;
  String msg;
  ChatDetails({required this.msg,required this.sender});
}