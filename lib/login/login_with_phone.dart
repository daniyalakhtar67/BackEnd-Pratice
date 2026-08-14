import 'package:backend_pratice/login/VerifyCode.dart';
import 'package:backend_pratice/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool isloading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final con = TextEditingController();
  @override
  void dispose() {
    con.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login With Phone',style: GoogleFonts.roboto(
          fontSize: 20,
        )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: con,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText: '+92 3XXXXXXXXXX',
                hintStyle: GoogleFonts.roboto(
                ),
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(

                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: (){
                  setState(() {
                    isloading = true;
                  });
                  auth.verifyPhoneNumber(
                    phoneNumber: con.text,
                      verificationCompleted:(_){},
                      verificationFailed: (e){
                      Utils().tomsg(e.toString());
                      },
                      codeSent: (String verificationId, int?token){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Verifycode(verificationId: verificationId)));
                      },
                      codeAutoRetrievalTimeout: (e){
                      Utils().tomsg(e.toString());
                      });
            }
                , child: isloading ? CircularProgressIndicator(strokeWidth: 3,color: Colors.white):Text('Login',style: GoogleFonts.roboto(
              fontWeight:FontWeight.bold,
            ),))
          ],
        ),
      ),
    );
  }
}
