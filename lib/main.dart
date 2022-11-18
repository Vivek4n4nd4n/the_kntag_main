import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:the_kntag/bottombar/bottombar.dart';
import 'package:the_kntag/creattag/creat_tagview.dart';
import 'package:the_kntag/massege/Chat/chat_login.dart';
import 'package:the_kntag/massege/Chat/provider.dart';
import 'package:the_kntag/views/loginview.dart/google_signin/provider.dart';
import 'package:the_kntag/views/loginview.dart/loginview.dart';
import 'package:the_kntag/views/loginview.dart/shared_pref.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:the_kntag/views/loginview.dart/signup_email_pwd/test_auth.dart';
import 'package:the_kntag/views/loginview.dart/test_signup.dart';
//import 'package:the_kntag/group/group_people/groupview/groupview.dart';


//import 'package:the_kntag/views/loginview.dart/loginview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSimplePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var username = UserSimplePreferences.getUserName() ?? '';
    var password = UserSimplePreferences.getPassword() ?? '';
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [      
ChangeNotifierProvider(
      create: (context) => GoogleSigninProvider(),),
     
          ChangeNotifierProvider.value(value: Authentication(),),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:
            //const TestSignUp()
            //ChatLogin()
          // username != null && password != null ?Bottombar()  : 
          const  LoginPage()
         
         
         
            //ProfilePage()
            // ProfSaveView()
            // ProfilePage()
      
            //   Bottombar()
            //GroupView()
            // Homeview()
            //
            //const MyHomePage(title: 'Flutter Demo Home Page'),
            ),
      );
    });
  }
}
