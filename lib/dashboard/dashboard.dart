import 'package:backend_pratice/add_post/addpostscreen.dart';
import 'package:backend_pratice/login/login_screen.dart';
import 'package:backend_pratice/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
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
    final ref = FirebaseDatabase.instance.ref('Post');
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
          Expanded(
            child: FirebaseAnimatedList(query: ref,
             defaultChild: Text('Loading'),
             itemBuilder:( context,  snapshot,  animation,  index){
              final data = snapshot.value as Map?;
              if(data==null) return SizedBox.shrink();
              return ListTile(
                title: Text(data['text']?.toString() ?? ''), // ?? '' -> due to this my project can't crash
                subtitle: Text(data['id']?.toString() ?? ''),
                trailing:Column(
                  children: [
                    Text(data['createdAt']?.toString() ?? ''),
                  ],
                ),
              );
            }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Addpostscreen()));
      },
      child:Icon(Icons.add,size: 30,color: Colors.white)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
