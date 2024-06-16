import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../homepage/home.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    _passController;
    _phoneController;
    super.dispose();
  }

  final _phoneController = TextEditingController();
  final _passController = TextEditingController();
  final _codeController = TextEditingController();

  Future registerUser(String mobile, BuildContext context) async{
    AuthCredential? _credential;

    FirebaseAuth _auth = FirebaseAuth.instance;
    String smsCode;

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential){_auth.signInWithCredential(_credential!).then((UserCredential result){Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Home(user: result.user!)
        ));}).catchError((e){
          print(e);
        });},
        verificationFailed: (FirebaseAuthException exception){
          print("error thruogh verfication exception");
        },
        codeSent: (String verificationId, int? forceResendingToken){
          //show dialog to take input from the user
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text("Enter SMS Code"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                    ),

                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text("Done"),
                    onPressed: () {
                      FirebaseAuth auth = FirebaseAuth.instance;

                      smsCode = _codeController.text.trim();

                      _credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
                      auth.signInWithCredential(_credential!).then((UserCredential result){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => Home(user: result.user!)
                        ));
                      }).catchError((e){
                        print(e);
                      });
                    },
                  )
                ],
              )
          );},
        codeAutoRetrievalTimeout: (String verificationId){
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        }
    );}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(32),
          child: Form(
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
                      hintText: "Phone Number"

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

                  controller: _passController,
                ),

                SizedBox(height: 16,),

                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("Login"),
                    onPressed: (){
                      registerUser("+919744573172",context);
                    },
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
