import 'dart:convert';

import 'package:backend_pratice/add_post/addpostscreen.dart';
import 'package:backend_pratice/login/login_screen.dart';
import 'package:backend_pratice/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../modals/getModel.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final ref = FirebaseDatabase.instance.ref('Post');
  final auth = FirebaseAuth.instance;
  final TextEditingController searchCon = TextEditingController();
  final TextEditingController editCon = TextEditingController();

  List<GetModel> getList = [];
  Future<List<GetModel>> getApi()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        getList.add(GetModel.fromJson(i));
      }
      return getList;
    }
    else{
      return getList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: GoogleFonts.montserrat(fontSize: 20, color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().tomsg(error.toString());
              });
            },
            icon: const Icon(Icons.login_outlined),
          )
        ],
      ),
      body:Column(
        children: [
          FutureBuilder(future: getApi(), builder: (context,snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(strokeWidth: 3,color: Colors.white));
            }
            else{
              return ListView.builder(
                  itemCount: getList.length,
                  itemBuilder: (context,index){
                return ListTile();
              });
            }
          })
        ],
      ),
    );
  }
}