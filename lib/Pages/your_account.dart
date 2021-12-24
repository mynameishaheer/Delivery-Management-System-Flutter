import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final String documentId;

  UserDetails(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Your Account'),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 16, top: 40, right: 16),
          child: GestureDetector(
            child: ListView(
              children: [
                Text(
                  'View Profile',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
                ),
                SizedBox(
                  height: 30,
                ),
                getUserDetail(users, 'Name', 'Full Name'),
                getUserDetail(users, 'Phone Number', 'Phone Number'),
                getUserDetail(users, 'CNIC Number', 'CNIC Number'),
                getUserDetail(users, 'Address', 'Address'),
                getUserDetail(users, 'Business Name', 'Business Name'),
              ],
            ),
          ),
        ));
  }

  late String nameVar = 'oh';

  FutureBuilder<DocumentSnapshot<Object?>> getUserDetail(
      CollectionReference<Object?> users, String txt, String textLabel) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text('Document does not exsist');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.only(bottom: 35),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 3),
                labelText: textLabel,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: '${data[txt]}',
                hintStyle: TextStyle(
                    fontSize: 16,
                    //fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          );
        }
        return Text('');
      },
    );
  }
}
