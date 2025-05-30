import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore_for_file: avoid_print


class Auth with ChangeNotifier {
  // static const _url =
  //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDTYRL4dIjTj32Q9S5IgSG6yoZTCO9lwtA';

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDTYRL4dIjTj32Q9S5IgSG6yoZTCO9lwtA';

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    print(json.decode(response.body));
  }

  Future<void> signup(String email, String password) async {
    _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    _authenticate(email, password, 'signInWithPassword');
  }
}
