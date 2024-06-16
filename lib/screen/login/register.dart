import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../wrapper.dart';




class Register extends StatefulWidget {
  const Register({required this.toggleView});
  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth=AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    username1;
    passsword1;
    confirmPasssword1;
    phno;
    email;name;
    super.dispose();
  }

  TextEditingController username1=TextEditingController();
  TextEditingController passsword1=TextEditingController();
  TextEditingController confirmPasssword1=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController location=TextEditingController();
  TextEditingController phno=TextEditingController();
  TextEditingController email=TextEditingController();

  String dropdownvalue = 'Select';
  var users = ['Select','Farmer','Consumer',"Supporter"];
  String newval="Farmer";
  String error="";
  bool validate=false,visible=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar
        (toolbarHeight: 80,
        backgroundColor: Colors.indigo[400],
        elevation: 10.0,
        title: Text('Sign up'),
        actions: [
          BackButton(
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (builder){
              return Wrapper();
            }));},
          )
        ],
      ),
      body: SingleChildScrollView(//physics: NeverScrollableScrollPhysics(),
        child: Container(

            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(children:[

                    Expanded(flex:1,
                      child: TextField(
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
                            hintText: "Enter the UserName"

                        ),
                        controller: username1,
                      ),
                    ),]),
                  SizedBox(height: 20,),
                  Row(children:[

                    Expanded(flex:3,
                      child: TextFormField(
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
                            hintText: "Email id"

                        ),
                        controller: email,
                        validator: (val)=> val!.isEmpty?"email cannot be empty":null,
                      ),
                    ),]),
                  SizedBox(height: 20,),
                  Row(children:[

                    Expanded(flex:3,
                      child: TextFormField(
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
                            hintText: 'Enter your password',
                            errorText: passsword1.text.length<8?"password must be atlest eight character long":""
                        ),
                        obscureText: true,
                        controller: passsword1,
                      ),
                    ),]),SizedBox(height: 20,),

                  Row(children:[

                    Expanded(flex:3,
                      child: TextFormField(
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
                            hintText: "Re-enter your password",
                            errorText: confirmPasssword1==passsword1?"password must be atlest eight character long":""

                        ),
                        obscureText: true,
                        controller: confirmPasssword1,
                      ),
                    ),]),SizedBox(height: 20,),
                  Row(children:[

                    Expanded(flex:3,
                      child: TextField(
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
                            hintText: "Enter your full name"

                        ),
                        controller: name,
                      ),
                    ),]),SizedBox(height: 20,),
                  Row(children:[

                    Expanded(flex:3,
                      child: TextField(
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
                            hintText: "Enter your phone number"

                        ),
                        controller: phno,
                      ),
                    ),]),SizedBox(height: 20,),
                  Row(children:[

                    Expanded(flex: 2,
                      child: DropdownButton(
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
                    ),]),

                  SizedBox(height: 40,),
                  Container(
                    height: 50,width: 200,
                    child: ElevatedButton( style: ElevatedButton.styleFrom(

                      backgroundColor: Colors.indigo[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),onPressed: ()async{
                      dynamic result;
                      //if(_formKey.currentState!.validate()){}
                      if(passsword1.text.length<8){
                        validate=true;
                      }else{validate=false;

                      dynamic result =await _auth.registerWithEmailandPasswordowner(
                          username1.text,passsword1.text,email.text,phno.text,newval);
                      if(result==null){
                        setState(() {
                          error="Registration failed";
                        });
                      }
                      }

                    }, child: Text('Register')),
                  ),
                  SizedBox(height: 12,),
                  Center(
                    child: Text(error,style: TextStyle(
                      color: Colors.red,
                    ),),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }

}