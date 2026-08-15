import 'package:backend_pratice/add_post/addpostscreen.dart';
import 'package:backend_pratice/login/login_screen.dart';
import 'package:backend_pratice/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard',style: GoogleFonts.montserrat(fontSize: 20,color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }).onError((error,  stackTrace){
              Utils().tomsg(error.toString());
            });
          }, icon: Icon(Icons.login_outlined))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Addpostscreen()));
          }, icon: Icon(Icons.add, color: Colors.orange,size: 35,fontWeight: FontWeight.bold,))),
        ],
      ),
    );
  }
}
