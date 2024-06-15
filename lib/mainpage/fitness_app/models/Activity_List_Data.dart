import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ActivityListData {
  ActivityListData({
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.Time = '',
    this.gram = 0,
    this.liter = 0,
    this.vaccine = 0,
    this.kandangID = 0,
    this.aktivitasID = 0,
  });

  String titleTxt;
  String startColor;
  String endColor;
  String Time;
  int gram;
  int liter;
  int vaccine;
  int kandangID;
  int aktivitasID;

  static List<ActivityListData> tabIconsList = [];

  static Future<List<ActivityListData>?> fetchActivities(int id) async {
    final url = Uri.parse('http://192.168.43.83:8000/api/aktivitas/${id}');
    print(url);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['list'];

        // Clear the existing list
        tabIconsList.clear();

        // Add new items to tabIconsList
        for (var activity in data) {
          int gram = activity['JumlahPakan'] ?? 0;
          int liter = activity['JumlahAir'] ?? 0;
          int vaccine = activity['JumlahVaksin'] ?? 0;

          String title = '';
          String startColor = '';
          String endColor = '';

          if (gram != 0) {
            title = 'Feeding';
            startColor = '#FA7D82';
            endColor = '#FFB295';
          } else if (liter != 0) {
            title = 'Watering';
            startColor = '#0000FF';
            endColor = '#1E90FF';
          } else if (vaccine != 0) {
            title = 'Vaccine';
            startColor = '#800080'; // Purple gradient start
            endColor = '#BA55D3'; // Purple gradient end
          }

          tabIconsList.add(ActivityListData(
            titleTxt: title,
            gram: gram,
            liter: liter,
            vaccine: vaccine,
            kandangID: activity['KandangID'] ?? 0,
            aktivitasID: activity['AktivitasID'] ?? 0,
            Time: activity['Waktu'] ?? '',
            startColor: startColor,
            endColor: endColor,
          ));
        }

        tabIconsList.sort((a, b) => DateTime.parse(b.Time).compareTo(DateTime.parse(a.Time)));
        return tabIconsList;
      } else {
        return null;
        print('Failed to fetch activities. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return null;
      print('Error fetching activities: $e');
    }
  }

  static Future<void> postFood(String namakandang,double totalFood) async {
    final url = Uri.parse('http://192.168.43.83:8000/api/addFood/${namakandang}');

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'totalPakan': totalFood
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Activity added successfully');
      } else {
        print('Failed to add activity. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding activity: $e');
    }
  }

  static Future<void> postWater(String namakandang,double totalAir) async {
    final url = Uri.parse('http://192.168.43.83:8000/api/addWater/${namakandang}');
    print(url);
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'totalAir': totalAir
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      print('response');
      if (response.statusCode == 200) {
        print('Activity added successfully');
      } else {
        print('Failed to add activity. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding activity: $e');
    }
  }
  static Future<void> subsWater(String namakandang,double totalAir) async {
    final url = Uri.parse('http://192.168.43.83:8000/api/subtractWater/${namakandang}');
    print(url);
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'jumlahAir': totalAir
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      print('response');
      if (response.statusCode == 200) {
        print('Activity added successfully');
      } else {
        print('Failed to add activity. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding activity: $e');
    }
  }

  static Future<void> subFood(String namakandang,double totalAir) async {
    final url = Uri.parse('http://192.168.43.83:8000/api/subtractFood/${namakandang}');
    print(url);
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'jumlahPakan': totalAir
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      print('response');
      if (response.statusCode == 200) {
        print('Activity added successfully');
      } else {
        print('Failed to add activity. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding activity: $e');
    }
  }

  static int getTotalGram(List<ActivityListData> activities) {
    int total = 0;
    for (var item in activities) {
      total += item.gram ?? 0;
    }
    return total;
  }

  static int getTotalLiter(List<ActivityListData> activities) {
    int total = 0;
    for (var item in activities) {
      total += item.liter ?? 0;
    }
    return total;
  }

  static int getTotalVaccine(List<ActivityListData> activities) {
    int total = 0;
    for (var item in activities) {
      total += item.vaccine ?? 0;
    }
    return total;
  }
}