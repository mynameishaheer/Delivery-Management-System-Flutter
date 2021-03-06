import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_project/Pages/Deliveries/edit_delivery.dart';
import 'package:db_project/UI/widgets.dart';
import 'package:flutter/material.dart';

class PendingDeliveries extends StatelessWidget {
  final String userID;

  PendingDeliveries(this.userID);

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
              child: Header('Pending Deliveries'),
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
          .where('orderStatus', isEqualTo: 'Pending')
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
                            padding: EdgeInsets.only(top: 3, left: 2),
                            child: Icon(
                              Icons.watch_later_outlined,
                              color: Colors.red,
                              size: 28,
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                String orderID = document['orderID'];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditDelivery(userID, orderID)));
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
          }).toList(),
        );
      },
    );
  }
}
