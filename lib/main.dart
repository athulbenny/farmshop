import 'package:farm_to_me/screen/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import 'models/users.dart';




void main () async{
  WidgetsFlutterBinding.ensureInitialized();






  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDytZzMm5qumYwjXdICEjJwTSM5I3xyM94",
          appId: "1:503477268361:android:992eaf60535859fce47b58",
          messagingSenderId: "503477268361",
          projectId: "miniproject-beea5")
  );



  runApp(MyApp());

}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserObj?>.value(
      initialData: null,
      value:AuthService().user,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(

            primarySwatch: Colors.blue,
          ),
          home:Wrapper()
      ),
    );
  }
}
