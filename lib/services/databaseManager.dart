

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/users.dart';

class UserLoginDataSaving{
  final  CollectionReference _logincollections= FirebaseFirestore.instance.collection("userdetails");

  Future<int> registerDataToFirebase(String username,String email,String phno,String role ) async{
    try{
      await _logincollections.doc(email).set({
        "username":username,
        "email":email,
        "phone": phno,
        // "latitude":latitude,
        // "longitude":longitude,
        "role":role,
      });
      return 1;
    }catch(e){
      return 0;
    }
  }

  Stream<List<UserDetails>> get users {
    return _logincollections.snapshots().map(_usersListFromDatabase);
  }

  List<UserDetails> _usersListFromDatabase(QuerySnapshot snapshot) {
    return snapshot.docs.map((usersnapshot) {
      Map<String, dynamic> _user = jsonDecode(jsonEncode(usersnapshot.data()));
      print("travelling users is" + _user.toString());
      return UserDetails(email: _user["email"] ?? "",
          username: _user["username"] ?? "",
          role: _user["role"] ?? "",
          phno: _user["role"] ?? ""
      );
    }).toList();
  }

}

class NewItems{
  final  CollectionReference _itemcollections= FirebaseFirestore.instance.collection("itemdetails");


  Future<int> addingNewItemsToDatabase(String userEmail,String quantity,String date,String loc,String price,String name) async{
    try{
      String itemid=DateTime.now().toString().split(" ").first+"%"+DateTime.now().toString().split(" ").last;
      String docname=userEmail+""+itemid;
      await _itemcollections.doc(docname).set({
        "email":userEmail,
        "quantity":quantity,
        "itemid":itemid,
        "date":date,
        "location":loc,
        "name":name,
        "price":price,
      });

      return 1;
    }catch(e){
      print("error wile aDDIGN NEW ITEMS TOO DATABASE");
      return 0;
    }
  }

  Stream<List<ItemDetails>> get users {
    return  _itemcollections.snapshots().map(_itemListFromDatabase);
  }

  List<ItemDetails> _itemListFromDatabase(QuerySnapshot snapshot) {
    return snapshot.docs.map((usersnapshot) {
      Map<String, dynamic> _user = jsonDecode(jsonEncode(usersnapshot.data()));
      print("travelling users is" + _user.toString());
      return ItemDetails(quantity: _user["quantity"] ?? "",
        itemid: _user["itemid"] ?? "",
        date: _user["date"] ?? "",
        price: _user["price"] ?? "",
        loc: _user["location"]??"",
        name: _user["name"]??"",
        email: _user["email"]??"",
      );
    }).toList();
  }

  Future<int> update(String docid,double quantity) async{
    try{
      await _itemcollections.doc(docid).update({
        "quantity":quantity.toString(),
      });
      return 1;
    }catch(e){
      print("error while updateing $e");
      return 0;
    }
  }

  Future<int> removeFromItemCollection(String docid)async{
    try{
      await _itemcollections.doc(docid).delete();
      return 1;
    }catch(e){
      print("error while removing from itemcolection");
      return 0;
    }
  }
}

class MyCart{
  final CollectionReference _cartcollections= FirebaseFirestore.instance.collection("carted");

  Future<int> addToCart(String name,String email,String itemid,String buy,String price,String source) async{
    try{
      String docid = "$email$itemid";
      await _cartcollections.doc(docid).set({
        "email":email,
        "itemid":itemid,
        "buyQuantity":buy,
        "price":price,
        "name":name,
        "source":source
      });
      return 1;
    }catch(e){
      print("error while ading to cart $e");
      return 0;
    }
  }

  Stream<List<CartDetails>> get users {
    return  _cartcollections.snapshots().map(_cartListFromDatabase);
  }

  List<CartDetails> _cartListFromDatabase(QuerySnapshot snapshot) {
    return snapshot.docs.map((usersnapshot) {
      Map<String, dynamic> _user = jsonDecode(jsonEncode(usersnapshot.data()));
      print("travelling users is" + _user.toString());
      return CartDetails(
        itemid: _user["itemid"] ?? "",
        price: _user["price"] ?? "",
        email: _user["email"]??"",
        buy: _user["buyQuantity"]??"",
        name: _user["name"]??"",
        source: _user["source"]??"",
      );
    }).toList();
  }

  Future<int> removeFromListCart(String docid) async{
    try{
      await _cartcollections.doc(docid).delete();
      return 1;
    }catch(e){
      print("error while removing from cart $e");
      return 0;
    }
  }

}

class Channel{
  String cmail;String fmail;
  Channel({required this.cmail,required this.fmail});
  final CollectionReference _chatcollections= FirebaseFirestore.instance.collection("chat");

  Future<int> chatting(sender,msg) async{
    try{

      String email=cmail.split(".").first+""+fmail.split(".").first;
      _chatcollections.doc(email).collection("date").doc(DateTime.now().toString())
      .set({
        "sender":sender,
        "msg":msg
      });
      return 1;
    }catch(e){
      print("error in chating $e");
      return 0;
    }
  }

  Stream<List<ChatDetails>> get users {
    String email=cmail.split(".").first+""+fmail.split(".").first;
    return  _chatcollections.doc(email).collection("date").snapshots().map(_chatListFromDatabase);
  }

  List<ChatDetails> _chatListFromDatabase(QuerySnapshot snapshot) {
    return snapshot.docs.map((usersnapshot) {
      Map<String, dynamic> _user = jsonDecode(jsonEncode(usersnapshot.data()));
      print("travelling users is" + _user.toString());
      return ChatDetails(
        sender: _user["sender"] ?? "",
        msg: _user["msg"] ?? "",
      );
    }).toList();
  }
}