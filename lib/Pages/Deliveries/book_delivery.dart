import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_project/UserInterface/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookDelivery extends StatefulWidget {
  BookDelivery();

  @override
  State<BookDelivery> createState() => _BookDeliveryState();
}

class _BookDeliveryState extends State<BookDelivery> {
  String name = 'waiting';
  String phone = 'waiting';
  var selectedAddress = null;
  String id = FirebaseFirestore.instance.collection('orders').doc().id;

  Future<void> getData() async {
    DocumentSnapshot<Map<String, dynamic>> ds = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    final _name = ds.data()!['Name'];
    final _phone = ds.data()!['Phone Number'];

    if (this.mounted) {
      setState(() {
        name = _name;
        phone = _phone;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 50, left: 93),
            child: Header('Book New Delivery'),
          ),
          const SizedBox(
            height: 16,
          ),
          bookDeliveryForm(context, name.toString(), phone.toString()),
        ],
      ),
    );
  }

  void _show() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Booking Completed! Waiting for confirmation',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Form bookDeliveryForm(BuildContext context, String name, String phone) {
    final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
    final _reciverAddressController = TextEditingController();
    final _recieverNameController = TextEditingController();
    final _recieverPhoneController = TextEditingController();
    final _recieverCNICController = TextEditingController();
    final _productNameController = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 85, child: Dropdown()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: TextFormField(
              controller: _reciverAddressController,
              decoration: const InputDecoration(hintText: "Reciever's Address"),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a delivery address';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: TextFormField(
              controller: _recieverNameController,
              decoration: const InputDecoration(hintText: "Reciever's Name"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter reciever's name";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: TextFormField(
              controller: _recieverPhoneController,
              decoration:
                  const InputDecoration(hintText: "Reciever's Phone Number"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter reciever's phone number";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: TextFormField(
              controller: _recieverCNICController,
              decoration:
                  const InputDecoration(hintText: "Reciever's CNIC Number"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: TextFormField(
              controller: _productNameController,
              decoration:
                  const InputDecoration(hintText: "Product Description"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter the product description";
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
                    if (_formKey.currentState!.validate()) {
                      FirebaseFirestore.instance
                          .collection('orders')
                          .doc(id)
                          .set({
                        'userID': FirebaseAuth.instance.currentUser!.uid,
                        'orderID': id,
                        'senderName': name,
                        'senderPhone': phone,
                        'recieverAddress': _reciverAddressController.text,
                        'recieverName': _recieverNameController.text,
                        'recieverPhone': _recieverPhoneController.text,
                        'recieverCNIC': _recieverCNICController.text,
                        'product': _productNameController.text,
                        'riderAssigned': 'none',
                        'orderStatus': 'Pending',
                        'timestamp': DateTime.now().millisecondsSinceEpoch,
                      }, SetOptions(merge: true));
                      _show();
                    }
                  },
                  child: const Text('Book'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ListView Dropdown() {
    var _senderAddressController = TextEditingController();
    return ListView(
      padding: const EdgeInsets.only(top: 16.0, left: 25, right: 25),
      children: <Widget>[
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('pickup_addresses')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            else {
              List<DropdownMenuItem> addressItems = [];
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                DocumentSnapshot<Map<String, dynamic>> snap = snapshot
                    .data!.docs[i] as DocumentSnapshot<Map<String, dynamic>>;
                addressItems.add(
                  DropdownMenuItem(
                    child: Text(
                      snap.data()!['address'],
                    ),
                    value: "${snap.data()!['address']}",
                  ),
                );
              }
              return DropdownButtonFormField<dynamic>(
                validator: (value) =>
                    value == null ? 'Please choose a pick-up address' : null,
                isExpanded: true,
                items: addressItems,
                onChanged: (addressValue) {
                  setState(() {
                    selectedAddress = addressValue;
                  });
                  FirebaseFirestore.instance.collection('orders').doc(id).set({
                    'senderAddress': selectedAddress,
                  }, SetOptions(merge: true));
                },
                value: selectedAddress,
                hint: const Text(
                  "Choose saved address",
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class dataGet extends StatefulWidget {
  @override
  _dataGetState createState() => _dataGetState();
}

class _dataGetState extends State<dataGet> {
  String name = 'waiting';

  Future<void> getData() async {
    DocumentSnapshot<Map<String, dynamic>> ds = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final _name = ds.data()!['Name'];
    setState(() {
      name = _name;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
