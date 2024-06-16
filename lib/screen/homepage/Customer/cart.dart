import 'package:farm_to_me/models/users.dart';
import 'package:farm_to_me/services/databaseManager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../services/auth.dart';
import '../chat/chatting.dart';



class CardConnect extends StatefulWidget {
  const CardConnect({required this.userdetails});
  final UserDetails userdetails;

  @override
  State<CardConnect> createState() => _CardConnectState();
}

class _CardConnectState extends State<CardConnect> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: MyCart().users,
      child: Cart(userdetails: widget.userdetails,),
    );
  }
}




class Cart extends StatefulWidget {
  const Cart({required this.userdetails});
  final UserDetails userdetails;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  @override
  Widget build(BuildContext context) {

    final cartList = Provider.of<List<CartDetails>?>(context)??[];
    List<CartDetails> resList=[];
    for(int i=0;i<cartList.length;i++){
      if(cartList[i].email==widget.userdetails.email){
        resList.add(cartList[i]);
        [...{...resList}];
      }
    }
    if(resList.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(toolbarHeight: 80,
          backgroundColor: Colors.indigo,
          title: Text("My Cart"),
          actions: [
            IconButton(onPressed: () {
              AuthService().userSignOut();
            }, icon: Icon(Icons.logout))
          ],
        ),
        body: ListView.builder(
            itemCount: resList.length,
            itemBuilder: (context,index){
              return Card(
                child: ListTile(
                  title: Text("${resList[index].name}"),
                  trailing: Text(" ₹:  "+"${resList[index].price}"),
                  onTap: (){
                    showDialog(context: context, builder: (builder){
                      return AlertDialog(
                        actions: [
                          Column(
                            children: [
                              SizedBox(height: 20,),
                              Center(
                                child: Container(height: 50,width: 200,
                                  child: ElevatedButton( style: ElevatedButton.styleFrom(

                                    backgroundColor: Colors.indigo[400],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                      onPressed: ()async{
                                        await MyCart().removeFromListCart("${resList[index].email}${resList[index].itemid}");
                                        Navigator.pop(context);
                                      }, child: Text("Remove from cart")),
                                ),
                              ),
                              SizedBox(height: 30,),
                              Container(width: 200,height: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(

                                      backgroundColor: Colors.blue[700],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                                        return Chatting(CustomerEmail: widget.userdetails.email,Farmeremail: resList[index].source,);
                                      }));

                                    }, child: Text("Request a channel")),
                              ),
                              SizedBox(height: 30,),
                              Container(width: 200,height: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(

                                      backgroundColor: Colors.red[700],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("Cancel")),
                              ),
                              SizedBox(height: 20,)
                            ],
                          )
                        ],
                      );
                    });
                  },
                ),
              );
            }),
      );
    }
    else{
      return Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.indigo,
          toolbarHeight: 80,
          title: Text("My Cart",style: GoogleFonts.poppins(),),

        ),
        body: Center(
          child: Text("Cart is empty or querying database",style: GoogleFonts.poppins(color: Colors.white),),
        ),
      );
    }
  }
}