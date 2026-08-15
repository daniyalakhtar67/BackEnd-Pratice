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
    TextEditingController con = TextEditingController();
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
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: TextFormField(
              controller: con,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                hintStyle: GoogleFonts.roboto(
                  fontSize: 20,
                  color: Colors.white38,
                ),
                border: UnderlineInputBorder(),
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
          ),
          SizedBox(height: 30),
          Expanded(child:FirebaseAnimatedList(
      defaultChild: Center(child: CircularProgressIndicator(strokeWidth: 3,color: Colors.white)),
      query: ref,
          itemBuilder: (context, snapshot, animation, index){
            final data = snapshot.value as Map?;
            if(data==null) return SizedBox.shrink();
            return ListTile(
              title: Text(data['text']?.toString() ?? ""),
              subtitle: Text(data['id']?.toString()??""),
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
