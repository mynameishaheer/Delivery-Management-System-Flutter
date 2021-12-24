import 'package:db_project/UI/widgets.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({required this.callback});
  final void Function(String email) callback;

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 230),
      child: Column(
        children: [
          const Header('Sign in with email'),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: TextFormField(
                      controller: _controller,
                      decoration:
                          const InputDecoration(hintText: 'Enter your email'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your email address to continue';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 30),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(200, 40)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                widget.callback(_controller.text);
                              }
                            },
                            child: const Text('NEXT'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

class PasswordForm extends StatefulWidget {
  const PasswordForm({required this.login, required this.email});

  final String email;
  final void Function(String email, String password) login;

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 230),
      child: Column(
        children: [
          const Header('Sign in'),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: TextFormField(
                        controller: _emailController,
                        decoration:
                            const InputDecoration(hintText: 'Email Address'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your email address to continue';
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(hintText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your password';
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 16),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(200, 40)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                widget.login(_emailController.text,
                                    _passwordController.text);
                              }
                            },
                            child: const Text('SIGN IN'),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

class RegisterForm extends StatefulWidget {
  const RegisterForm(
      {required this.registerAccount,
      required this.cancel,
      required this.email});

  final String email;
  final void Function(
      String email,
      String fullName,
      String phoneNo,
      String cnic,
      String address,
      String businessName,
      String password) registerAccount;
  final void Function() cancel;

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _cnicController = TextEditingController();
  final _addressController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45),
      child: Column(
        children: [
          const Header('Create Account'),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: TextFormField(
                      controller: _emailController,
                      decoration:
                          const InputDecoration(hintText: 'Email Address'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your email address to continue';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(hintText: 'Full Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your full name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: TextFormField(
                      controller: _phoneNoController,
                      decoration:
                          const InputDecoration(hintText: 'Phone Number'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number (03xx xxxxxxx)';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: TextFormField(
                      controller: _cnicController,
                      decoration:
                          const InputDecoration(hintText: 'CNIC Number'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your CNIC number (xxxxx-xxxxxxx-x)';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: TextFormField(
                      controller: _addressController,
                      decoration:
                          const InputDecoration(hintText: 'Permanent Address'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your permanent address';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: TextFormField(
                      controller: _businessNameController,
                      decoration:
                          const InputDecoration(hintText: 'Business Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the name of your business';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(hintText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 90, vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 16, height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(200, 40)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.registerAccount(
                                  _emailController.text,
                                  _fullNameController.text,
                                  _phoneNoController.text,
                                  _cnicController.text,
                                  _addressController.text,
                                  _businessNameController.text,
                                  _passwordController.text);
                            }
                          },
                          child: const Text('SAVE'),
                        ),
                        const SizedBox(width: 30),
                        TextButton(
                            onPressed: widget.cancel,
                            child: const Text('CANCEL')),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

