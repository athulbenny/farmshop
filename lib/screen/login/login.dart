import 'dart:io';
import 'package:flutter/material.dart';
import '../../services/auth.dart';
import 'mobilelogin.dart';

class Login extends StatefulWidget {
  const Login({required this.toggleView});
  final Function toggleView;
  static final String id="login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  void dispose() {
    // TODO: implement dispose
    _passController;
    _phoneController;
      super.dispose();
  }

  final _phoneController = TextEditingController();
  final _passController = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body:  Container(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Login", style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.w500),),

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
                    hintText: "UserName"

                ),
                controller: _phoneController,
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
                    hintText: "Password"

                ),
                obscureText: true,
                controller: _passController,
              ),

              SizedBox(height: 16,),

              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("Login"),
                  onPressed: () async{
                  if(_formKey.currentState!.validate()){
                  dynamic result = await _auth.signInWithEmailAndPassword(_phoneController.text,_passController.text);
                  if(result==null){
                    setState(() {
                      error="Sign in failed";
                    });
                  }
                }
                  },
                ),
              ),
             Padding(
               padding: const EdgeInsets.only(left: 50.0),
               child: Row(
                      children: [
                        SizedBox(width: 20,),
                        Text("Do not have an account?",),
                        SizedBox(width: 10,),
                        // SizedBox(width: 10,),
                        TextButton(onPressed: (){
                          widget.toggleView();
                        },
                            child: Text("Signup",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),))
                        ,SizedBox(width: 20,),
                      ],),
             ),
                SizedBox(height: 12,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (builder){
                        return LoginScreen();
                      }));
                    },
                        child: Text("Signin with mobile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                  ),
                ),
                Center(
                  child: Text(error,style: TextStyle(
                      color: Colors.red
                  ),),
                ),
            ],
          ),
        ),
      ),
    );
  }
}