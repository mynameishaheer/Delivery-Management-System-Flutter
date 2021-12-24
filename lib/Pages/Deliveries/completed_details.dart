import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_project/UI/widgets.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompletedDetails extends StatelessWidget {
  final String userID;
  final String orderID;

  CompletedDetails(this.userID, this.orderID);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('orders');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Delivery Details'),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 16, top: 40, right: 16),
          child: GestureDetector(
            child: ListView(
              children: [
                SizedBox(
                  height: 15,
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
    var _orderIDController;
    var _orderStatusController;
    var _senderAddressController;
    var _senderNameController;
    var _senderPhoneController;
    var _recieverAddressController;
    var _recieverNameController;
    var _recieverPhoneController;
    var _recieverCNICController;
    var _productController;

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(orderID).get(),
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

          _orderIDController =
              TextEditingController(text: '${data['orderID']}');
          _orderStatusController =
              TextEditingController(text: '${data['orderStatus']}');
          _senderAddressController =
              TextEditingController(text: '${data['senderAddress']}');
          _senderNameController =
              TextEditingController(text: '${data['senderName']}');
          _senderPhoneController =
              TextEditingController(text: '${data['senderPhone']}');
          _recieverAddressController =
              TextEditingController(text: '${data['recieverAddress']}');
          _recieverNameController =
              TextEditingController(text: '${data['recieverName']}');
          _recieverPhoneController =
              TextEditingController(text: '${data['recieverPhone']}');
          _recieverCNICController =
              TextEditingController(text: '${data['recieverCNIC']}');
          _productController =
              TextEditingController(text: '${data['product']}');

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: TextField(
                  controller: _orderIDController,
                  readOnly: true,
                  enabled: false,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'OrderID',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '${data['orderID']}',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: TextField(
                  controller: _orderStatusController,
                  readOnly: true,
                  enabled: false,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Order Status',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '${data['orderStatus']}',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: TextField(
                  controller: _senderAddressController,
                  readOnly: true,
                  enabled: false,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Pick-up Address',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '${data['senderAddress']}',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: TextField(
                  controller: _senderNameController,
                  readOnly: true,
                  enabled: false,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Sender's Name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '${data['senderName']}',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: TextField(
                  controller: _senderPhoneController,
                  readOnly: true,
                  enabled: false,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Sender's Phone Number",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '${data['senderPhone']}',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: TextField(
                  controller: _recieverAddressController,
                  readOnly: true,
                  enabled: false,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Reciever's Address",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '${data['recieverAddress']}',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: TextField(
                  controller: _recieverNameController,
                  readOnly: true,
                  enabled: false,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Reciever's Name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '${data['recieverName']}',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: TextField(
                  controller: _recieverPhoneController,
                  readOnly: true,
                  enabled: false,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Reciever's Phone Number",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '${data['recieverPhone']}',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: TextField(
                  controller: _recieverCNICController,
                  readOnly: true,
                  enabled: false,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Reciever's CNIC Number",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '${data['recieverCNIC']}',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: TextField(
                  controller: _productController,
                  readOnly: true,
                  enabled: false,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Product Description",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '${data['product']}',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ],
          );
        }
        return Text('');
      },
    );
  }
}
