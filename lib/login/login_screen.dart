import 'package:backend_pratice/signup/sign_up.dart';
import 'package:backend_pratice/widgets/Uihelper.dart';
import 'package:backend_pratice/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isloading = false;
  bool obsurepass = true;
  final _formfeild = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();

  @override
  void dispose() {
    c1.dispose();
    c2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formfeild,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: c1,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your Email',
                  prefixIcon: Icon(Icons.email),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: c2,
                keyboardType: TextInputType.text,
                obscureText: obsurepass,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  hintText: 'PassWord',
                  prefixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsurepass = !obsurepass;
                      });
                    },
                    icon: Icon(
                      obsurepass
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                    ),
                  ),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isloading? null : () {
                  if (_formfeild.currentState!.validate()) {
                    _auth.signInWithEmailAndPassword(email: c1.text.toString(), password: c2.text.toString()
                    ).then((value){
                      Utils().tomsg(value.user!.email.toString());
                    })
                        .onError((error, stackTrace){
                          Utils().tomsg(error.toString());
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: isloading ? SizedBox(height: 20,width: 20,child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )):Text('Login'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Does not have account?',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: Text(
                      ' SignUp',
                      style: TextStyle(fontSize: 14, color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}