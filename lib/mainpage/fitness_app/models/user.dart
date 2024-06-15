import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserData {
  UserData({
    this.userID = 0,
    this.profilePicture,
    this.name = '',
    this.username = '',
    this.email = '',
    this.biodata = '',
    this.latitude,
    this.longitude,
    this.jumlahPakan = 0,
    this.jumlahAir = 0,
  });

  int userID;
  String? profilePicture;
  String name;
  String username;
  String email;
  String biodata;
  double? latitude;
  double? longitude;
  int jumlahPakan;
  int jumlahAir;

  static List<UserData> fromApiList(List<Map<String, dynamic>> apiList) {
    List<UserData> users = [];
    apiList.forEach((user) {
      users.add(UserData(
        userID: user['UserID'] ?? 0,
        profilePicture: user['ProfilePicture'],
        name: user['Name'] ?? '',
        username: user['Username'] ?? '',
        email: user['Email'] ?? '',
        biodata: user['Biodata'] ?? '',
        latitude: user['Latitude'],
        longitude: user['Longitude'],
        jumlahPakan: user['JumlahPakan'] ?? 0,
        jumlahAir: user['JumlahAir'] ?? 0,
      ));
    });
    return users;
  }
}

class AuthApi {
  static const String baseUrl = 'http://192.168.43.83:8000/api/';

  // Register API
  static Future<bool> register(String email, String password) async {
    var url = Uri.parse(baseUrl + 'register');
    var response = await http.post(url, body: {'email': email,'password' : password});

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      if (!responseData['error']) {
        return true; // Registration successful
      }
    }
    return false; // Registration failed
  }

  // Login API
  static Future<UserData?> login(String email, String password) async {
    var url = Uri.parse(baseUrl + 'login');
    var response = await http.post(url, body: {'email': email,'password':password});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      var userList = responseData['userID'] ;
        return getUserById(userList);
      }
    return null;
  }

  // Get User by ID API
  static Future<UserData?> getUserById(int userId) async {
    var url = Uri.parse(baseUrl + 'user/$userId');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      var userList = responseData['list'] as List;
      if (userList.isNotEmpty) {
        return UserData.fromApiList(userList.cast<Map<String, dynamic>>())[0];
      }
    }
    return null; // User fetch failed
  }
}