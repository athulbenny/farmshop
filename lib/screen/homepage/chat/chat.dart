import 'package:farm_to_me/models/users.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../services/databaseManager.dart';

class Chatting1 extends StatefulWidget {
  const Chatting1({required this.CustomerEmail,required this.Farmeremail});
  final String Farmeremail;
  final String CustomerEmail;
  @override
  State<Chatting1> createState() => _Chatting1State();
}

class _Chatting1State extends State<Chatting1> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: Channel(fmail: widget.CustomerEmail,cmail: widget.Farmeremail).users,
      child: Chatinghere(CustomerEmail: widget.CustomerEmail,Farmeremail: widget.Farmeremail),
    );
  }
}

class Chatinghere extends StatefulWidget {
  const Chatinghere({required this.CustomerEmail,required this.Farmeremail});
  final String Farmeremail;
  final String CustomerEmail;

  @override
  State<Chatinghere> createState() => _ChatinghereState();
}

class _ChatinghereState extends State<Chatinghere> {
  TextEditingController _cont= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<ChatDetails> listofmsgs=[];
    listofmsgs = Provider.of<List<ChatDetails>?>(context)??[];
    if(listofmsgs.isNotEmpty){
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title:Text("Chat with ${widget.Farmeremail}"),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/1.25,
              child: ListView.builder(
                  itemCount: listofmsgs.length,
                  itemBuilder: (context,index){
                    if(listofmsgs[index].sender==widget.Farmeremail){
                      return Padding(
                          padding: EdgeInsets.only(left: 50),
                          child: Card(
                            child: ListTile(title: Text("${listofmsgs[index].msg}"),),
                          ));}
                    else{
                      return Padding(
                          padding: EdgeInsets.only(right: 50),
                          child: Card(
                            child: ListTile(title: Text("${listofmsgs[index].msg}"),),
                          ));
                    }
                  }
              ),
            ),
            Align(alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width/1.5,
                      child: TextField(controller: _cont,)),
                  IconButton(icon: Icon(Icons.send),
                    onPressed: () async{
                      await Channel(cmail: widget.CustomerEmail,fmail: widget.Farmeremail)
                          .chatting(widget.CustomerEmail,_cont.text);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      );}
    else{
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green.shade700,
            toolbarHeight: 80,
            title: Text("Chatting",style: GoogleFonts.poppins(),),
          ),
          body: Column(children: [
            Text("Data is being loaded...",style: GoogleFonts.poppins(),),
            Align(alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width/1.5,
                      child: TextField(controller: _cont,)),
                  IconButton(icon: Icon(Icons.send),
                    onPressed: () async{
                      await Channel(cmail: widget.CustomerEmail,fmail: widget.Farmeremail)
                          .chatting(widget.Farmeremail,_cont.text);
                    },
                  )
                ],
              ),

            )
          ])
      );
    }
  }
}
