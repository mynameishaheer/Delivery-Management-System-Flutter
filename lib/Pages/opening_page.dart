import 'package:db_project/Pages/Deliveries/all_delivery.dart';
import 'package:db_project/Pages/Deliveries/book_delivery.dart';
import 'package:db_project/Pages/Deliveries/completed_delivery.dart';
import 'package:db_project/Pages/Deliveries/pending_delivery.dart';
import 'package:db_project/Pages/your_account.dart';
import 'package:db_project/Pages/Address/your_addresses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SecondRoute extends StatefulWidget {
  SecondRoute();

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  String userID = FirebaseAuth.instance.currentUser!.uid;
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("DGX Delivery Portal"),
          leadingWidth: 55,
          leading: ElevatedButton(
            style: ElevatedButton.styleFrom(elevation: 0),
            onPressed: () {
              Navigator.pop(context);
              FirebaseAuth.instance.signOut();
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14159),
              child: Icon(
                Icons.logout,
                size: 22,
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 0),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetails(
                                  FirebaseAuth.instance.currentUser!.uid),
                            ))
                      },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(Icons.account_circle),
                  )),
            ),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            Container(
              child: AllDeliveries(userID),
            ),
            Container(
              child: AddData(userID),
            ),
            Container(
              child: BookDelivery(),
            ),
            Container(
              child: PendingDeliveries(userID),
            ),
            Container(
              child: CompletedDeliveries(userID),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.book,
                ),
                label: 'Deliveries'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_work_rounded,
                ),
                label: 'Addresses'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  color: Colors.red,
                ),
                label: 'Book'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.pending_rounded,
                ),
                label: 'Pending'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                ),
                label: 'History'),
          ],
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: onTapped,
        ),
      ),
    );
  }
}


// Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 140),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 75, vertical: 30),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           fixedSize: const Size(240, 80)),
//                       onPressed: () => {
//                         WidgetsFlutterBinding.ensureInitialized(),
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => AddData(
//                                     FirebaseAuth.instance.currentUser!.uid)))
//                       },
//                       child: const Text(
//                         'Your Addresses',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 40,
//                     ),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           fixedSize: const Size(240, 80)),
//                       onPressed: () => {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => AllDeliveries(
//                                     FirebaseAuth.instance.currentUser!.uid)))
//                       },
//                       child: const Text(
//                         'All Deliveries',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 30),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           fixedSize: const Size(240, 80)),
//                       onPressed: () => {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => PendingDeliveries(
//                                     FirebaseAuth.instance.currentUser!.uid)))
//                       },
//                       child: const Text(
//                         'Pending Deliveries',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           fixedSize: const Size(240, 80)),
//                       onPressed: () => {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => BookDelivery()))
//                       },
//                       child: const Text(
//                         'Book New Delivery',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),