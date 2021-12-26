import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_project/UserInterface/widgets.dart';
import 'package:flutter/material.dart';

import 'completed_details.dart';

class CompletedDeliveries extends StatelessWidget {
  final String userID;

  CompletedDeliveries(this.userID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("Pending Deliveries"),
      // ),
      body: Column(
        children: [
          const SizedBox(
            height: 72,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 13),
              child: Header('Delivery History'),
            ),
          ),
          SizedBox(height: 653, child: showData()),
        ],
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> showData() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('userID', isEqualTo: userID)
          .where('orderStatus', isEqualTo: 'Completed')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((document) {
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
                          title: Text(document['product']),
                          subtitle: Text(
                              'To: ${document['recieverAddress']} \nStatus: ${document['orderStatus']}'),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          leading: const Padding(
                            padding: EdgeInsets.only(top: 6, left: 4.5),
                            child: Icon(
                              Icons.check_box,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                String orderID = document['orderID'];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CompletedDetails(userID, orderID)));
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.red,
                                size: 30,
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
          }).toList(),
        );
      },
    );
  }
}
