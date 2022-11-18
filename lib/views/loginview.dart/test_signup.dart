import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_kntag/views/loginview.dart/loginview.dart';
import 'package:the_kntag/views/loginview.dart/signup_email_pwd/test_auth.dart';

class TestSignUp extends StatefulWidget {
  const TestSignUp({Key? key}) : super(key: key);

  @override
  State<TestSignUp> createState() => _TestSignUpState();
}

class _TestSignUpState extends State<TestSignUp> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  void _showSucessFullMessage(message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("From The Kntag"),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text('ok'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
            title: const Text("Test SignUp")),
        body: Form(
          key: _formkey,
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your Email...';
                  }
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(08),
                    ),
                    hintText: 'Email Id',
                    hintStyle: const TextStyle(color: Colors.red),
                    labelText: 'Enter Email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (String? value) {},
                controller: _emailController,
                autofocus: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(08),
                      ),
                      hintText: 'Enter password',
                      hintStyle: const TextStyle(color: Colors.red),
                      labelText: 'Enter password'),
                  controller: _passController,
                  validator: (val) {
                    if (val != null && val.isEmpty) {
                      return 'Please Enter password';
                    }
                    return null;
                  }),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (!_formkey.currentState!.validate()) {
                    return;
                  }
                  _formkey.currentState!.save();
                  var message = "you are Sucessfully signed Up";
                  try {
                    await Provider.of<Authentication>(context, listen: false)
                        .signUp(_emailController.text, _passController.text);
                    _showSucessFullMessage(message);
                  } catch (error) {
                    // ignore: use_rethrow_when_possible
                    throw error;
                  }
                },
                child: const Text('Sign up'))
          ]),
        ));
  }
}
