import 'dart:convert';

import 'package:backend_pratice/modals/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ComplexJson extends StatefulWidget {
  const ComplexJson({super.key});

  @override
  State<ComplexJson> createState() => _ComplexJsonState();
}

class _ComplexJsonState extends State<ComplexJson> {
  List<UserModel> userlist = [];
  Future<List<UserModel>> getUser()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        // print(i['name']);   -> for one simple data
        userlist.add(UserModel.fromJson(i));
      }
      return userlist;

    }
    else{
      return userlist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: FutureBuilder(future: getUser(), builder: (context,AsyncSnapshot<List<UserModel>>snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(strokeWidth: 3,color: Colors.white),
            );
          }else{
            return ListView.builder(
                itemCount: userlist.length,
                itemBuilder: (context, index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Resuseable(title: ('Id'), value: snapshot.data![index].id.toString()),
                          Resuseable(title: 'Name', value: snapshot.data![index].name.toString()),
                          Resuseable(title: 'Email', value: snapshot.data![index].email.toString()),
                          Resuseable(title: 'Address', value: snapshot.data![index].address!.city.toString()),
                        ],
                      ),
                    ),
                  );
                });
          }
          }))
        ],
      ),
    );
  }
}

class Resuseable extends StatelessWidget {
  String title, value;
  Resuseable({super.key, required  this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
