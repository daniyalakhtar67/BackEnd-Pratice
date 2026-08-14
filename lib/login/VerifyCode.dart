import 'package:backend_pratice/dashboard/dashboard.dart';
import 'package:backend_pratice/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Verifycode extends StatefulWidget {
  final String verificationId;
  const Verifycode({super.key, required this.verificationId});

  @override
  State<Verifycode> createState() => _VerifycodeState();
}

class _VerifycodeState extends State<Verifycode> {
  final con = TextEditingController();
  bool isloading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    con.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Code'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: [
            TextFormField(
              controller: con,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '123456',
                hintStyle: GoogleFonts.roboto(),
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: isloading
                  ? null
                  : () async {
                setState(() {
                  isloading = true;
                });
                final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: con.text.toString(),
                );
                try {
                  await auth.signInWithCredential(credential);
                  if (!context.mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );
                } catch (e) {
                  Utils().tomsg(e.toString());
                } finally {
                  if (context.mounted) {
                    setState(() {
                      isloading = false;
                    });
                  }
                }
              },
              child: isloading
                  ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
                  : Text(
                'Verify',
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}