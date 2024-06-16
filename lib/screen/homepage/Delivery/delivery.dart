import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../models/users.dart';
import '../../../services/auth.dart';
import '../../../services/databaseManager.dart';



class delivery extends StatefulWidget {
  const delivery({required this.userdetails});
  final UserDetails userdetails;

  @override
  State<delivery> createState() => _deliveryState();
}

class _deliveryState extends State<delivery> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: MyCart().users,
      initialData: null,
      child: DeliveryBoys(userdetails: widget.userdetails),
    );
  }
}




class DeliveryBoys extends StatefulWidget {
  const DeliveryBoys({required this.userdetails});
  final UserDetails userdetails;

  @override
  State<DeliveryBoys> createState() => _DeliveryBoysState();
}

class _DeliveryBoysState extends State<DeliveryBoys> {
@override
  void dispose() {
    // TODO: implement dispose
  _dateController;
  _passController;
    super.dispose();
  }
  final _dateController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final listUsersAndItems = Provider.of<List<CartDetails>?>(context)??[];
    if(listUsersAndItems.isNotEmpty){
    return Scaffold(
      backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          toolbarHeight: 80,
          title: Text("Supporters",style: GoogleFonts.poppins(),),
          actions: [
            IconButton(onPressed: () async{
              await AuthService().userSignOut();
            }, icon: Icon(Icons.logout))
          ],
        ),
        body: Container(
        child: ListView.builder(
        itemCount: listUsersAndItems.length,
        itemBuilder: (context,index){
          return
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 6),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 58.0),
                          child: Column(
                            children: [
                              Text("Receiver: ${listUsersAndItems[index].email} "),
                              Text("Item: ${listUsersAndItems[index].buy} kg of ${listUsersAndItems[index].name}"),
                              Text("Source: ${listUsersAndItems[index].source} "),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(onPressed: (){
                            showDialog(context: context, builder: (builder){
                            return AlertDialog(
                              actions :[ Container(
                                  child:  Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Details of Delivering of Items", style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.w500),),

                                        SizedBox(height: 16,),

                                        TextFormField(
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  borderSide: BorderSide(color: Colors.grey)
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  borderSide: BorderSide(color: Colors.grey)
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              hintText: "expected date of Transferring"

                                          ),
                                          controller: _dateController,
                                        ),

                                        SizedBox(height: 16,),

                                        TextFormField(
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  borderSide: BorderSide(color: Colors.grey)
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  borderSide: BorderSide(color: Colors.grey)
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              hintText: "Unique uid"

                                          ),
                                          obscureText: true,
                                          controller: _passController,
                                        ),

                                        SizedBox(height: 16,),

                                      ],
                                    ),
                                  ),
                                ),
                                ElevatedButton(onPressed: (){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Details are mailed")));
                                  Navigator.pop(context);
                                }, child: Text("Submit")),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("Cancel"))
                            ]);

                          });
                            },child: Text("Accept"),)
                      ],
                    ),
                  ),
                ),
              ),
            );
        }),
    )
    );
  }
    else{
    return Scaffold(
    appBar: AppBar(
    backgroundColor: Colors.green.shade700,
    toolbarHeight: 80,
    title: Text("Supporters",style: GoogleFonts.poppins(),),
    ),
    body: Center(child: Text("Data is being loaded...",style: GoogleFonts.poppins(),)),
    );
    }
  }
}
