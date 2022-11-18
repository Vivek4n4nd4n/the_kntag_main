import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_kntag/views/loginview.dart/signup_email_pwd/test_http_exception.dart';


class Authentication with ChangeNotifier {
  Future<void> signUp(String email, String password ) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAI78WscCY9Tf97z0dylL8hcrIFCGwFxQs';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
//AIzaSyAI78WscCY9Tf97z0dylL8hcrIFCGwFxQs

  }

  // Future<void> login(String email, String password) async {
  //   const url =
  //       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?Key=AIzaSyAI78WscCY9Tf97z0dylL8hcrIFCGwFxQs';
  //   try {
  //     final response = await http.post(Uri.parse(url),
  //     body:
  //     json.encode({
  //       'email': email,
  //       'password': password,
  //       'returnSecureToken': true,
  //     }));
  //      final responseData = json.decode(response.body);
  //     print(responseData);
  //     if (responseData['error'] != null) {
  //       throw HttpException(responseData['error']['message']);
  //     }
  //   } catch (error) {
  //     throw error;
  //   }
   
  // }
}
