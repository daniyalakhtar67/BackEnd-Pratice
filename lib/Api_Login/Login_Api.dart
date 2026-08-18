import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class LoginApi extends StatefulWidget {
  const LoginApi({super.key});

  @override
  State<LoginApi> createState() => _LoginApiState();
}

class _LoginApiState extends State<LoginApi> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isloading = false;
  final _key = GlobalKey<FormState>();
  void login(String email, String password)async{
    try{
      Response response =await post(
        Uri.parse('https://reqres.in/api/login'),
        headers: {
          'Content-Type':'application/json',
          'x-api-key':'reqres_ffaa3d64c9b447318385e28486d82607',
        },
        body: jsonEncode({
          'email': email,
          'password': pass,
        }
        )
      );
      if(response.statusCode==200){
        print('Account Created Successfully');
        print(response.body);
      }else{
        print('Failed: ${response.body}');
      }
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login',style: GoogleFonts.roboto(),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: 'Enter your email',
                hintStyle: GoogleFonts.roboto(),
                border: UnderlineInputBorder(),
              ),
              validator: (value){
                if(value!.isEmpty){
                  print('Enter Email');
                }
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: pass,
              obscureText: true,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                prefixIcon: IconButton(onPressed: (){
                  setState(() {
                    isloading = true;
                  });
                }, icon: isloading ? Icon(Icons.remove_red_eye):Icon(Icons.remove_red_eye_outlined)),
                hintText: 'Enter your password',
                hintStyle: GoogleFonts.roboto(),
                border: UnderlineInputBorder(),
              ),
              validator: (value){
                if(value!.isEmpty){
                  print('Enter password');
                }
              },
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: (){
                login(email.text.toString(), pass.text.toString());
              },
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                child: Center(child: Text('Login',style: GoogleFonts.roboto(fontSize: 18))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
