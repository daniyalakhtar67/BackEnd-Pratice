import 'dart:convert';

import 'package:backend_pratice/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Imageapi extends StatefulWidget {
  const Imageapi({super.key});

  @override
  State<Imageapi> createState() => _ImageapiState();
}

class _ImageapiState extends State<Imageapi> {
  List<Photos> imagelist = [];
  Future<List<Photos>> getImages()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        imagelist.add(photos);
      }
      return imagelist;
    }
    else{
      return imagelist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: FutureBuilder(future: getImages(), builder: (context,AsyncSnapshot<List<Photos>>snapshot){
            return ListView.builder( itemCount: imagelist.length, itemBuilder: (context, index){
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:  NetworkImage(snapshot.data![index].url.toString()),
                ),
                subtitle: Text(snapshot.data![index].title.toString()),
                title: Text(snapshot.data![index].id.toString()),
              );
            });
          }))
        ],
      ),
    );
  }
}
class Photos{
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}