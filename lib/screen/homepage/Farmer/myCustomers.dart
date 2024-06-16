import 'package:farm_to_me/services/databaseManager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/users.dart';
import '../chat/chat.dart';
import '../chat/chatting.dart';

class MyCustomers extends StatefulWidget {
  const MyCustomers({required this.userdetails});
  final UserDetails userdetails;

  @override
  State<MyCustomers> createState() => _MyCustomersState();
}

class _MyCustomersState extends State<MyCustomers> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: MyCart().users,
      initialData: null,
      child: FarmerCust(userdetails: widget.userdetails),
    );
  }
}



class FarmerCust extends StatefulWidget {
  const FarmerCust({required this.userdetails});
  final UserDetails userdetails;

  @override
  State<FarmerCust> createState() => _FarmerCustState();
}

class _FarmerCustState extends State<FarmerCust> {
  @override
  Widget build(BuildContext context) {
    List<CartDetails> resList=[];
    final listUsersAndItems = Provider.of<List<CartDetails>?>(context)??[];
    for(int i=0;i<listUsersAndItems.length;i++){
      if(listUsersAndItems[i].source==widget.userdetails.email){
        resList.add(listUsersAndItems[i]);
        [...{...resList}];
      }
    }
    if(resList.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade700,
          toolbarHeight: 80,
          title: Text("Notifications",style: GoogleFonts.poppins(),),
        ),
        body: Container(
          child: ListView.builder(
              itemCount: resList.length,
              itemBuilder: (context,index){
                return
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(child: Text("${resList[index].email} ordered ${resList[index].buy} kg of ${resList[index].name}  ")),
                                  ElevatedButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (builder){
                                      return Chatting1(CustomerEmail: widget.userdetails.email,Farmeremail: resList[index].email,);
                                    }));
                                  }, child: Icon(Icons.change_circle))
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Rs: ${resList[index].price} ")
                          ],
                        ),
                      ),
                    ),
                  );
              }),
        ),
      );
    }
    else{
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade700,
          toolbarHeight: 80,
          title: Text("Notifications",style: GoogleFonts.poppins(),),
        ),
        body: Center(child: Text("Data is being loaded...",style: GoogleFonts.poppins(),)),
      );
    }
  }
}
