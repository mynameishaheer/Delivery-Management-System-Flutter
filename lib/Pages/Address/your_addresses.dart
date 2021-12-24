import 'package:db_project/Pages/Address/edit_address.dart';
import 'package:db_project/UI/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'add_address.dart';

class AddData extends StatelessWidget {
  final String userID;

  AddData(this.userID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text("Your Addresses"),
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => AddAddress(userID)));
        //         },
        //         icon: Icon(Icons.add))
        //   ],
        // ),
        body: Column(
      children: [
        const SizedBox(
          height: 72,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Header('Saved Pick-up Addresses'),
          ),
        ),
        SizedBox(height: 550, child: showData()),
        const SizedBox(
          height: 35,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(150, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddAddress(userID)));
          },
          child: Icon(
            Icons.add_business_rounded,
          ),
          //iconSize: 40,
        )
      ],
    ));
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> showData() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('pickup_addresses')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map(
            (document) {
              return Container(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Text(document['address']),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            leading: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.red,
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  String id = document['docID'];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditAddress(userID, id)));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  //Text(document['text'])
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
