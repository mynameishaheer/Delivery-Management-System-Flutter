import 'package:db_project/Pages/opening_page.dart';
import 'package:db_project/UI/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'UI/forms.dart';

enum ApplicationLoginState {
  loggedout,
  emailAddress,
  register,
  password,
  loggedin
}

class Authentication extends StatelessWidget {
  const Authentication(
      {required this.loginState,
      required this.email,
      required this.startLoginFlow,
      required this.verifyEmail,
      required this.signInWithEmailAndPassword,
      required this.cancelRegistration,
      required this.registerAccount,
      required this.signOut});

  final ApplicationLoginState loginState;
  final String? email;
  final void Function() startLoginFlow;
  final void Function(String email, void Function(Exception e) error)
      verifyEmail;
  final void Function(BuildContext context, String email, String password,
      void Function(Exception e) error) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
      BuildContext context,
      String email,
      String fullName,
      String phoneNo,
      String cnic,
      String address,
      String businessName,
      String password,
      void Function(Exception e) error) registerAccount;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedout:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Column(
                children: [
                  const Text(
                    'Welcome to the',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'DGX Delivery Portal',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 160,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(fixedSize: Size(250, 60)),
                    onPressed: () {
                      startLoginFlow();
                    },
                    child: const Text('LOGIN'),
                  ),
                ],
              ),
            ),
          ],
        );

      case ApplicationLoginState.emailAddress:
        return EmailForm(
            callback: (email) => verifyEmail(
                email, (e) => _showErrorDialog(context, 'Invalid Email', e)));

      case ApplicationLoginState.password:
        return LoginForm(
          email: email!,
          login: (email, password) {
            signInWithEmailAndPassword(context, email, password,
                (e) => _showErrorDialog(context, 'Invalid Email', e));
          },
        );

      case ApplicationLoginState.register:
        return RegisterForm(
          email: email!,
          cancel: () {
            cancelRegistration();
          },
          registerAccount: (email, fullName, phoneNo, cnic, address,
              businessName, password) {
            registerAccount(
                context,
                email,
                fullName,
                phoneNo,
                cnic,
                address,
                businessName,
                password,
                (e) =>
                    _showErrorDialog(context, 'Failed to create account', e));
          },
        );

      case ApplicationLoginState.loggedin:
        return Column(
          children: [
            SizedBox(
              height: 250,
            ),
            Text(
              'Welcome Back!',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text(
                'Return to Session',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondRoute()));
              },
              style: ElevatedButton.styleFrom(fixedSize: Size(220, 60)),
            ),
            SizedBox(
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: TextButton(
                // style: OutlinedButton.styleFrom(
                //     side: const BorderSide(color: Colors.deepOrange),
                //     fixedSize: Size(160, 40)),
                onPressed: () {
                  signOut();
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );

      default:
        return Row(
          children: const [
            Text("Internal error, this shouldn't happen..."),
          ],
        );
    }
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepOrange),
              ),
            )
          ],
        );
      },
    );
  }
}
