import 'package:backend_pratice/add_post/addpostscreen.dart';
import 'package:backend_pratice/login/login_screen.dart';
import 'package:backend_pratice/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // ye sab ab class-level fields hain, taaki showMyDialog() mein bhi use ho sakein
  final ref = FirebaseDatabase.instance.ref('Post');
  final auth = FirebaseAuth.instance;
  final TextEditingController searchCon = TextEditingController();
  final TextEditingController editCon = TextEditingController();

  Future<void> showMyDialog(String title, String key) async {
    editCon.text = title;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update'),
          content: TextFormField(
            controller: editCon,
            decoration: const InputDecoration(hintText: 'Edit'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ref.child(key).update({
                  'text': editCon.text,
                }).then((value) {
                  Utils().tomsg('Post Updated');
                }).onError((error, stackTrace) {
                  Utils().tomsg(error.toString());
                });
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: GoogleFonts.montserrat(fontSize: 20, color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().tomsg(error.toString());
              });
            },
            icon: const Icon(Icons.login_outlined),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: TextFormField(
              controller: searchCon,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                hintStyle: GoogleFonts.roboto(fontSize: 20, color: Colors.white38),
                border: const UnderlineInputBorder(),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: FirebaseAnimatedList(
              defaultChild: const Center(
                child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
              ),
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                final data = snapshot.value as Map?;
                if (data == null) return const SizedBox.shrink();

                final title = data['text']?.toString() ?? '';
                final key = snapshot.key.toString();

                // search filter: khali box hai to sab dikhao, warna match karo
                if (searchCon.text.isNotEmpty &&
                    !title.toLowerCase().contains(searchCon.text.toLowerCase())) {
                  return const SizedBox.shrink();
                }

                return ListTile(
                  title: Text(title),
                  subtitle: Text(data['id']?.toString() ?? ''),
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            showMyDialog(title, key);
                          },
                          title: const Text('Edit'),
                          leading: const Icon(Icons.edit),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            ref.child(key).remove();
                          },
                          title: const Text('Delete'),
                          leading: const Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Addpostscreen()));
        },
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}