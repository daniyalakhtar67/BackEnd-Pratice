import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class Addpostscreen extends StatefulWidget {
  const Addpostscreen({super.key});

  @override
  State<Addpostscreen> createState() => _AddpostscreenState();
}

class _AddpostscreenState extends State<Addpostscreen> {
  bool isloading = false;
  final dbRef = FirebaseDatabase.instance.ref('Post');
  final TextEditingController con = TextEditingController();

  @override
  void dispose() {
    con.dispose();
    super.dispose();
  }

  Future<void> addPost() async {
    final text = con.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Post cannot be empty")),
      );
      return;
    }

    setState(() => isloading = true);

    try {
      final newPostRef = dbRef.push();
      await newPostRef.set({
        'id': newPostRef.key,
        'text': text,
        'createdAt': ServerValue.timestamp,
      });

      con.clear();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Post added!")),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => isloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post', style: GoogleFonts.roboto()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: TextFormField(
                controller: con,
                maxLines: 5,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "What is in your mind?",
                  hintStyle: GoogleFonts.roboto(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade500,
              minimumSize: const Size(200, 50),
            ),
            onPressed: isloading ? null : addPost,
            child: isloading
                ? const CircularProgressIndicator(strokeWidth: 3, color: Colors.white)
                : Text(
              'ADD',
              style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}