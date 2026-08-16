import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../modals/Complex_Json_Model.dart';
class CJson extends StatefulWidget {
  const CJson({super.key});

  @override
  State<CJson> createState() => _CJsonState();
}

class _CJsonState extends State<CJson> {
  Future<ComplexJsonModel> getdata()async{
    final response = await http.get(Uri.parse('https://webhook.site/d24f9761-dfba-4759-bcda-f42f3dd539b7'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
       return ComplexJsonModel.fromJson(data);
    }else{
      return ComplexJsonModel.fromJson(data);
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: FutureBuilder(future: getdata(), builder: (context, snapshot){
           if(!snapshot.hasData){
             return Center(child: CircularProgressIndicator(strokeWidth: 3,color: Colors.white));
           }else {
             return ListView.builder(
                 itemCount: snapshot.data!.data!.length,
                 itemBuilder: (context, index) {
                   return Column(
                     children: [
                       Container(
                         height: MediaQuery.of(context).size.height*.3,
                         width: MediaQuery.of(context).size.width*.1,
                         child: ListView.builder(
                             itemBuilder: (context,pos){

                         })
                       )
                     ],
                   );
                 });
           }
          }))
        ],
      ),
    );
  }
}
