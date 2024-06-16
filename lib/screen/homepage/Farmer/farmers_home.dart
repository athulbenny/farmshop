import 'package:farm_to_me/models/users.dart';
import 'package:farm_to_me/screen/homepage/Farmer/myCustomers.dart';
import 'package:farm_to_me/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../services/databaseManager.dart';


class Farmer1 extends StatefulWidget {
  const Farmer1({required this.userdetails});
  final UserDetails userdetails;
  @override
  State<Farmer1> createState() => _Farmer1State();
}

class _Farmer1State extends State<Farmer1> {


  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: NewItems().users,
      child: Farmer(userdetails: widget.userdetails,),
    );
  }
}


class Farmer extends StatefulWidget {
  const Farmer({required this.userdetails});
  final UserDetails userdetails;
  @override
  State<Farmer> createState() => _FarmerState();
}

class _FarmerState extends State<Farmer> {



  TextEditingController quantity = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController loc = new TextEditingController();
  TextEditingController name = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<ItemDetails> myList=[];
    final itemList= Provider.of<List<ItemDetails>?>(context)??[];
    for(int i=0;i<itemList.length;i++){
      if(widget.userdetails.email==itemList[i].email){
        myList.add(itemList[i]);
        [...{...myList}];
        print("my list ${myList.length}");
      }
    }
    print(myList.length);
    if(itemList.isNotEmpty){
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.green.shade800,

            title: Text("Home",style: GoogleFonts.poppins(),),
            actions: [
              ElevatedButton(style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor:  Colors.green.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1),
                ),
              ),onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder){
                  return MyCustomers(userdetails: widget.userdetails);
                }));
              }, child: Icon(Icons.add_alert)),
              SizedBox(width: 10,),
              ElevatedButton(

                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.green.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                onPressed: (){
                  AuthService().userSignOut();
                },child: Icon(Icons.logout),),
            ]
        ),
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,end: Alignment.bottomRight,
              colors: [Colors.green.shade50,Colors.green.shade200,Colors.green.shade500, Colors.green.shade900],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(height: MediaQuery.of(context).size.height/1.5,
                child: ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (context,index){
                      return  Card(
                          child:ListTile(
                            tileColor: Colors.blue[50],
                            onLongPress: ()async{
                              String docid = "${myList[index].email}${myList[index].itemid}";
                              await NewItems().removeFromItemCollection(docid);
                            },
                            title: Text("${myList[index].name}"),
                            trailing: Text("₹ "+"${myList[index].price}"),
                            subtitle: Text("${myList[index].loc}"),
                          )
                      );
                    }),
              ),
              Container(height: 60,width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.black12,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    showDialog(context: context, builder: (builder){
                      return Container(
                        height: MediaQuery.of(context).size.height*0.8,
                        child: AlertDialog(
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children:[
                                    Expanded(flex: 1,child: Text("Name",style: TextStyle(fontSize: 18.0),)),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children:[

                                    Expanded(flex:1,
                                      child: TextFormField(
                                        controller: name,
                                        decoration: InputDecoration(
                                            hintText: 'Name of the product'
                                        ),validator: (val)=> val!.isEmpty?"Name of the product cannot be empty":null,
                                      ),
                                    ),]),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children:[
                                    Expanded(flex: 1,child: Text("Quantity",style: TextStyle(fontSize: 18.0),)),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children:[

                                    Expanded(flex:1,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: quantity,
                                        decoration: InputDecoration(
                                            hintText: 'Quantity (in kg)'
                                        ),validator: (val)=> val!.isEmpty?"quantity cannot be empty":null,
                                      ),
                                    ),]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children:[
                                    Expanded(flex: 1,child: Text("Price",style: TextStyle(fontSize: 18.0),)),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children:[
                                    Expanded(flex:1,
                                      child: TextFormField(
                                        controller: price,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: 'Price in Rupees'
                                        ),validator: (val)=> val!.isEmpty?"Price cannot be empty":null,
                                      ),
                                    ),]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children:[
                                    Expanded(flex: 1,child: Text("location",style: TextStyle(fontSize: 18.0),)),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children:[

                                    Expanded(flex:1,
                                      child: TextFormField(
                                        controller: loc,
                                        decoration: InputDecoration(
                                            hintText: 'location'
                                        ),validator: (val)=> val!.isEmpty?"location cannot be empty":null,
                                      ),
                                    ),]),
                                ),
                              ],
                            ),
                          ),
                          title: Text("Add Item"),
                          actions: [

                            ElevatedButton(onPressed: () async{
                              await NewItems().addingNewItemsToDatabase(widget.userdetails.email,quantity.text,DateTime.now().toString().split(' ').first,loc.text,price.text,name.text);
                              Navigator.pop(context);
                            }, child: Text("Submit")),
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("Cancel")),
                          ],
                        ),
                      );
                    });
                  },child: Text("Add Items",style: GoogleFonts.poppins(),),
                ),
              )
            ],
          ),
        ),
      );}
    else{
      return Scaffold(
        appBar: AppBar(
          backgroundColor:  Colors.green.shade800,
          toolbarHeight: 80,
          title: Text("Home",style: GoogleFonts.poppins(),),
        ),
        body: Container(width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,end: Alignment.bottomRight,
              colors: [Colors.green.shade50,Colors.green.shade200,Colors.green.shade500, Colors.green.shade900],
            ),
          ),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                showDialog(context: context, builder: (builder){
                  return Container(
                    height: MediaQuery.of(context).size.height/2,
                    child: AlertDialog(
                      title: Text("Add Item"),
                      actions: [
                        Column(
                          children: [
                            Row(children:[
                              Expanded(flex:3,
                                child: TextFormField(
                                  controller: name,
                                  decoration: InputDecoration(
                                      hintText: 'Name of the product'
                                  ),validator: (val)=> val!.isEmpty?"Name of the product cannot be empty":null,
                                ),
                              ),]),
                            Row(children:[
                              Expanded(flex:3,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: quantity,
                                  decoration: InputDecoration(
                                      hintText: 'Quantity(in kg)'
                                  ),validator: (val)=> val!.isEmpty?"quantity cannot be empty":null,
                                ),
                              ),]),
                            Row(children:[
                              Expanded(flex:3,
                                child: TextFormField(
                                  controller: price,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: 'Price in Rupees'
                                  ),validator: (val)=> val!.isEmpty?"Price cannot be empty":null,
                                ),
                              ),]),
                            Row(children:[
                              Expanded(flex:3,
                                child: TextFormField(
                                  controller: loc,
                                  decoration: InputDecoration(
                                      hintText: 'Location'
                                  ),validator: (val)=> val!.isEmpty?"location cannot be empty":null,
                                ),
                              ),]),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: Container(
                            height: 50,width: 200,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(

                                  backgroundColor: Colors.green.shade800,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () async{
                                  await NewItems().addingNewItemsToDatabase(widget.userdetails.email,quantity.text,DateTime.now().toString().split(' ').first,loc.text,price.text,name.text);
                                  Navigator.pop(context);
                                }, child: Text("Add ",style: GoogleFonts.poppins(),)),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Center(
                          child: TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text("Cancel")),
                        ),
                      ],
                    ),
                  );
                });
              },child: Text("Add Items",style: GoogleFonts.poppins(),),
            ),
          ),
        ),
      );
    }
  }
}