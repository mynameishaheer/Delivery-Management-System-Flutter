import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_project/Pages/Deliveries/edit_delivery.dart';
import 'package:db_project/UI/widgets.dart';
import 'package:flutter/material.dart';

class AllDeliveries extends StatelessWidget {
  final String userID;

  AllDeliveries(this.userID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("All Deliveries"),
      // ),
      body: Column(
        children: [
          const SizedBox(
            height: 72,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Header('All Deliveries'),
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
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(
                              Icons.delivery_dining_rounded,
                              color: Colors.red,
                              size: 30,
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
