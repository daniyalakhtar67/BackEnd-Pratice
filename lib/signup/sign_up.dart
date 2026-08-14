import 'package:backend_pratice/login/login_screen.dart';
import 'package:backend_pratice/signup/sign_up.dart';
import 'package:backend_pratice/widgets/Uihelper.dart';
import 'package:backend_pratice/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool obscurePassword = true; // password hide/show ke liye
  bool isloading = false;      // signup call ke dauran spinner ke liye
  final _formfeild = GlobalKey<FormState>();
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

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
        title: Text('SignUp '),
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
                obscureText: obscurePassword,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  hintText: 'PassWord',
                  prefixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
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
                onPressed: isloading
                    ? null // loading ke dauran button disable
                    : () {
                  if (_formfeild.currentState!.validate()) {
                    setState(() {
                      isloading = true;
                    });
                    _auth
                        .createUserWithEmailAndPassword(
                      email: c1.text.toString(),
                      password: c2.text.toString(),
                    )
                        .then((value) {
                      setState(() {
                        isloading = false;
                      });
                      Utils().tomsg('Account Created successfully');
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    }).onError((error, stackTrace) {
                      Utils().tomsg(error.toString());
                      setState(() {
                        isloading = false;
                      });
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
                child: isloading
                    ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
                    : Text('SignUp'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 14, color: Colors.orange),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}