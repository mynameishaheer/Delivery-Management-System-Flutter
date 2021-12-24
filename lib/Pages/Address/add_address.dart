import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_project/UI/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget {
  final String documentId;
  AddAddress(this.documentId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Address'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Header('New Pick-up Address'),
          SizedBox(height: 8),
          addressForm(documentId, context),
        ],
      ),
    );
  }

  Form addressForm(documentId, BuildContext context) {
    final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
    final _addressController = TextEditingController();
    // DocumentReference ohno = FirebaseFirestore.instance
    //     .collection('/users/$documentId/pickup_addresses')
    //     .get() as DocumentReference<Object?>;

    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(hintText: 'Pick-up Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a pick-up address to continue';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 16, height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(fixedSize: Size(200, 40)),
                    onPressed: () {
                      String id = FirebaseFirestore.instance
                          .collection('usres')
                          .doc(documentId)
                          .collection('pickup_addresses')
                          .doc()
                          .id;
                      if (_formKey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(documentId)
                            .collection('pickup_addresses')
                            .doc(id)
                            .set({
                          'address': _addressController.text,
                          'timestamp': DateTime.now().millisecondsSinceEpoch,
                          'docID': id
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
        ));
  }
}


  // Center addData(documetId) {
  //   return Center(
  //     child: FloatingActionButton(
  //       child: Icon(Icons.add),
  //       onPressed: () {
  //         FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(documentId)
  //             .collection('add')
  //             .add({
  //           'text': 'ohbb through app 2',
  //           'timestamp': DateTime.now().millisecondsSinceEpoch
  //         });
  //       },
  //     ),
  //   );
  // }
  // }
