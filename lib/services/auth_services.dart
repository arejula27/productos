import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = "identitytoolkit.googleapis.com";
  final String _fireBaseToken = "AIzaSyD2-o2X5FHFHq3svzSMpYq80qxGwnzHkm0";
  final _storage = const FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true,
    };
    final url =
        Uri.https(_baseUrl, "/v1/accounts:signUp", {"key": _fireBaseToken});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey("idToken")) {
      //guardar token
      await _storage.write(key: "idToken", value: decodedResp["idToken"]);
      return null;
    }
    return decodedResp["error"]["message"];
  }

  Future<String?> iniciarSesion(String email, String password) async {
    final Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true,
    };
    final url = Uri.https(
        _baseUrl, "/v1/accounts:signInWithPassword", {"key": _fireBaseToken});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey("idToken")) {
      //guardar token
      await _storage.write(key: "idToken", value: decodedResp["idToken"]);
      return null;
    }
    return decodedResp["error"]["message"];
  }

  Future logout() async {
    await _storage.deleteAll();
  }

  Future<String> readToken() async {
    //Si es nulo devuelve un string vacio
    return await _storage.read(key: "idToken") ?? "";
  }
}
