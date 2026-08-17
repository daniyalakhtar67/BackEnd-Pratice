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
  void initState() {
    // TODO: implement initState
    super.initState();
    // _futureData = getdata();
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
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       ListTile(
                         title: Text(snapshot.data!.data![index].shop!.name.toString()),
                         subtitle: Text(snapshot.data!.data![index].shop!.isActive.toString()),
                         leading: CircleAvatar(
                           backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                         ),
                       ),
                       Container(
                         height: MediaQuery.of(context).size.height*.3,
                         width: double.infinity,
                         child: ListView.builder(
                           itemCount: snapshot.data!.data![index].images!.length,
                             itemBuilder: (context, pos){
                               return Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Container(
                                   height: MediaQuery.of(context).size.height*.25,
                                   width: MediaQuery.of(context).size.width*.5,
                                   decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                        snapshot.data!.data![index].images![pos].url.toString())),
                                   ),
                                 ),
                               );
                             }),
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
