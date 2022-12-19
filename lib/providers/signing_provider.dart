import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/clients.dart';

class SigningProvider extends ChangeNotifier {
  String? username; //cause we only want this

  Future<bool> signup({
    required String username,
    required String password,
  }) async {
    try {
      var response = await Client.dio.post("/api/signup", data: {
        'username': username,
        'password': password,
      });

      var token = response.data['token'];
      Client.dio.options.headers['Authorization'] = 'Bearer $token';

      this.username = username;

      var preferences = await SharedPreferences.getInstance();
      await preferences.setString("token", token);

      return true;
    } on DioError catch (exception) {
      print(exception.response!.data);
    } catch (exception) {
      print("Unknown Error");
    }
    return false;
  }

  Future<bool> hasToken() async {
    var preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token");

    if (token != null && JwtDecoder.isExpired(token)) {
      var tokenMap = JwtDecoder.decode(token); //decoding same as jwt.io
      username = tokenMap['username'];
      return true;
    }
    return false;
  }
}
