import 'package:farm_to_me/models/users.dart';
import 'package:farm_to_me/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../services/databaseManager.dart';
import 'cart.dart';


class Customer1 extends StatefulWidget {
  const Customer1({required this.userdetails});
  final UserDetails userdetails;
  @override
  State<Customer1> createState() => _Customer1State();
}

class _Customer1State extends State<Customer1> {


  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: NewItems().users,
      child: Customer(userdetails: widget.userdetails,),
    );
  }
}


class Customer extends StatefulWidget {
  const Customer({required this.userdetails});
  final UserDetails userdetails;
  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {

  String? quantity1;double newQuantity=0.0;
  String dropdownvalue = 'Select';
  var users = ['Select','Self pick','Delivery option',];
  String newval="Delivery";

  @override
  Widget build(BuildContext context) {
    final itemList= Provider.of<List<ItemDetails>?>(context)??[];
    print(itemList.length);
    if(itemList.isNotEmpty){
      [...{...itemList}];
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.indigo[700],
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(

                  backgroundColor: Colors.indigo[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                )
                ,onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder){
                return CardConnect(userdetails: widget.userdetails,);
              }));
            }, child: Icon(Icons.add_shopping_cart_outlined)),
            IconButton(onPressed: (){
              AuthService().userSignOut();
            }, icon: Icon(Icons.logout))
          ],
          title: Text("Home",style: GoogleFonts.poppins()),        ),
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Color.fromARGB(255, 0, 82, 163)],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 15,),
              Container(
                height: MediaQuery.of(context).size.height*0.7,
                width:  MediaQuery.of(context).size.width*0.9,
                child:
                ListView.builder(

                    itemCount: itemList.length,
                    itemBuilder: (context,index){
                      return  Card(
                          child:ListTile(
                            title: Text("${itemList[index].name}",style: GoogleFonts.poppins()),
                            trailing: Text("₹ ${itemList[index].price}",style: GoogleFonts.poppins()),
                            subtitle: Text("${itemList[index].loc}",style: GoogleFonts.poppins()),
                            onTap: (){
                              showDialog(context: context, builder: (builder){
                                return AlertDialog(
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(

                                            children: [
                                              Text("Item Name:    ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(

                                            children: [

                                              Text("${itemList[index].name}",style: GoogleFonts.poppins()),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text("Available:    ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                                              SizedBox(width: 25,),
                                              Text("${itemList[index].quantity}",style: GoogleFonts.poppins()),

                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text("Price per kg   ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                                              SizedBox(width: 20,),
                                              Text("${itemList[index].price}",style: GoogleFonts.poppins()),

                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text("Location ",style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              width: MediaQuery.of(context).size.width/1.25,
                                              child: Text("${itemList[index].loc}",style: GoogleFonts.poppins(),)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text("Select the quantity",style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Container(width:MediaQuery.of(context).size.width*0.2,
                                                child: TextField(
                                                  keyboardType: TextInputType.number,
                                                  onChanged: (value){
                                                    quantity1=value;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            Text(" Mode",style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                                            SizedBox(width: 5,),
                                            DropdownButton(

                                              value: dropdownvalue,
                                              icon: const Icon(Icons.keyboard_arrow_down),
                                              items: users.map((String user) {
                                                return DropdownMenuItem(
                                                  value: user,
                                                  child: Text(user),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownvalue = newValue!;
                                                  print(newValue);
                                                  newval=newValue;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20,),
                                        Container(
                                          width: 180,height: 40,
                                          child: ElevatedButton(

                                              style: ElevatedButton.styleFrom(

                                                backgroundColor: Colors.indigo[400],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                              onPressed: () async{
                                                String docid = "${itemList[index].email}${itemList[index].itemid}";
                                                print(docid);
                                                double price=0;newQuantity=0;
                                                newQuantity = double.parse(itemList[index].price)-double.parse(quantity1!);
                                                price = double.parse(quantity1!)*(double.parse(itemList[index].price));
                                                print("${newQuantity} ${itemList[index].price} ${quantity1}");
                                                await NewItems().update(docid, newQuantity);
                                                await MyCart().addToCart(itemList[index].name, widget.userdetails.email, itemList[index].itemid,
                                                    quantity1!, price.toString(),itemList[index].email);
                                                Navigator.pop(context);
                                              }, child: Text("Add to Cart")),
                                        ),
                                        TextButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text("Cancel"))
                                      ],
                                    ),
                                  ),
                                );
                              });
                            },
                          )
                      );
                    }),
              )
            ],
          ),
        ),)
      ;      }
    else{
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            toolbarHeight: 80,
            title: Text("Home",style: GoogleFonts.poppins()),
          ),
          body: Center(child: Column(
            children: [
              SizedBox(height: 50,),
              Text("Data is being fetched",style: GoogleFonts.poppins())
            ],
          ))
      );
    }
  }
}