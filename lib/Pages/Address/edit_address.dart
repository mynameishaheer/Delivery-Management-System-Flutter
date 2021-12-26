import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_project/UserInterface/widgets.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditAddress extends StatelessWidget {
  final String documentId;
  final String docID;

  EditAddress(this.documentId, this.docID);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .collection('pickup_addresses');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Edit Address'),
          actions: [
            IconButton(
                onPressed: () {
                  users.doc(docID).delete().then((value) => null);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.delete))
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 16, top: 40, right: 16),
          child: GestureDetector(
            child: ListView(
              children: [
                Text(
                  'Edit this pick-up address',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
                ),
                SizedBox(
                  height: 30,
                ),
                getUserDetail(users),
              ],
            ),
          ),
        ));
  }

  FutureBuilder<DocumentSnapshot<Object?>> getUserDetail(
      CollectionReference<Object?> users) {
    final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
    var _addressController;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(docID).get(),
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
          _addressController =
              TextEditingController(text: '${data['address']}');
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    //initialValue: 'i am smart',
                    controller: _addressController,
                    readOnly: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'Pick-up Address',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: '${data['address']}',
                      hintStyle:
                          TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a pick-up address to continue';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 90, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 16, height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(fixedSize: Size(200, 40)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(documentId)
                              .collection('pickup_addresses')
                              .doc(docID)
                              .update({
                            'address': _addressController.text,
                            'timestamp': DateTime.now().millisecondsSinceEpoch,
                            'docID': docID
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('SAVE'),
                    ),
                  ],
                ),
              )
            ],
          );
        }
        return Text('');
      },
    );
  }
}
