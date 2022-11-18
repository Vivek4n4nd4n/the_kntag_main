import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:kn_tag/views/login/createaccount.dart';

//import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_kntag/bottombar/bottombar.dart';
import 'package:the_kntag/massege/Chat/provider.dart';
import 'package:the_kntag/views/loginview.dart/google_signin/provider.dart';
//import 'package:the_kntag/main.dart';
//import 'package:the_kntag/views/home/homeview.dart';
import 'package:the_kntag/views/loginview.dart/test_signup.dart';

import 'creataccount.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  final user = FirebaseAuth.instance.currentUser;
  late bool _passwordVisible;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  // String username = '';
  // String password = '';
  void _showErrorDialog(message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("From The Kntag"),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('ok'))
              ],
            ));
  }

  // @override
  // void initState() {
  //   super.initState();

  //   username = UserSimplePreferences.getUserName() ?? '';
  //   password = UserSimplePreferences.getPassword() ?? '';
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    //Device heightqqq
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 206, 221, 234),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.10,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => TestSignUp())));
                      },
                      icon: const Icon(Icons.logout))),
              const Center(
                child: Text(
                  ' Creat \n Connect \n Celebrate',
                  style: TextStyle(
                      fontSize: 40, color: Color.fromRGBO(253, 85, 101, 1)),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 70,
                  width: width * 0.9,
                  child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(08),
                        ),
                        hintText: 'Email / Username',
                      ),
                      // onChanged: (username) => setState(() {
                      //   this.username = emailController.text;
                      // }),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Enter valid Email';
                        }
                        return null;
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 70,
                  width: width * 0.9,
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _pwdController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(08),
                        ),
                        hintText: 'Enter Password',
                        suffixIcon: IconButton(
                            icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            }),
                      ),
                      // onChanged: (password) => setState(() {
                      //   this.password = pwdController.text;
                      // }),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Enter valid password';
                        }
                        return null;
                      }),
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forget Password',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        decoration: TextDecoration.underline),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: width * 0.89,
                    height: height * 0.07,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 9, 76, 203)),
                      onPressed: () async {
                        if (!_formkey.currentState!.validate()) {
                          return;
                        }

                        _formkey.currentState!.save();

                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _pwdController.text);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Bottombar()));
                        } catch (error) {
                          var errorMessage =
                              'Authentication Failed Please Try Again later';
                          _showErrorDialog(error.toString());
                        }

                        // // print("USERRRR: ${user?.email}");

                        // await UserSimplePreferences.setUsername(username);
                        // await UserSimplePreferences.setPassword(password);
                        // // print("User name: $username");
                        // // print("Password: $password");

                        // var snackBar = const SnackBar(
                        //   content:
                        //       Text('please enter valid email 0r password'),
                        //   duration: Duration(seconds: 2),
                        // );

                        // username == '' || password == ''
                        //     ?
                        //     // ignore: use_build_context_synchronously
                        //     ScaffoldMessenger.of(context)
                        //         .showSnackBar(snackBar)

                        //     // ignore: use_build_context_synchronously
                        //     : Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: ((context) => ChatPage(
                        //                   uid: user!.uid,
                        //                 ))));
                      },
                      child: const Text('Login'),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: width * 0.4,
                      height: height * 0.07,
                      child: ElevatedButton.icon(
                        onPressed: () {
final provider =
                    Provider.of<GoogleSigninProvider>(context, listen: false);
                provider.googleLogin();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Bottombar()));


                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.google,
                          color: Color.fromARGB(255, 251, 125, 7),
                        ),
                        label: const Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white70, onPrimary: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: width * 0.4,
                      height: height * 0.07,
                      child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const FaIcon(FontAwesomeIcons.facebook,
                              color: Color.fromARGB(255, 115, 183, 239)),
                          label: const Text(
                            'login',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white70,
                              onPrimary: Colors.white)),
                    ),
                  ),
                ],
              ),
              Center(
                  child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const CreatAccountPage())));
                },
                child: const Text(
                  'Register with email',
                  style: TextStyle(color: Colors.black),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
