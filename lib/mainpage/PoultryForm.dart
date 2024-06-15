import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PoultryForm extends StatelessWidget {
  final int userID;

  PoultryForm({required this.userID});

  final TextEditingController poultryNameController = TextEditingController();
  final TextEditingController maxWaterController = TextEditingController();
  final TextEditingController maxFoodController = TextEditingController();
  final TextEditingController poultryCountController = TextEditingController();

  Future<void> apiAddPoultry(int id, String namaKandang) async {
    final uri = Uri.parse('http://192.168.43.83:8000/api/addKandang/$id');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'namaKandang': namaKandang}),
    );

    if (response.statusCode == 201) {
      print('Kandang added successfully');
      String data = response.body;
      var allData = jsonDecode(data);
      print(allData);
    } else {
      print('Failed to add kandang');
      print(response.statusCode);
    }
  }

  Future<int> newKandangID(List<dynamic> kandangList) async {
    int newID = 1;
    List existingIDs = kandangList.map((kandang) => kandang['KandangID']).toList();

    while (existingIDs.contains(newID)) {
      newID++;
    }

    return newID;
  }

  void submitForm(BuildContext context) async {
    String poultryName = poultryNameController.text;
    try {
      await apiAddPoultry(userID, poultryName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kandang added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add kandang')),
      );
    }

    // Add the new poultry data logic if needed, here's a placeholder for newData:
    // var newData = {...};
    // PoultryData.addPoultryData(context, newData).then((_) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Data added successfully!')),
    //   );
    // }).catchError((error) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Failed to add data: $error')),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 80),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Image.asset("assets/images/LogoHackfest.png"),
                    ),
                    SizedBox(height: 10),
                    FadeInUp(
                      duration: Duration(milliseconds: 1300),
                      child: Text(
                        "Welcome To Automafarm",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                      children: <Widget>[
                      SizedBox(height: 60),
                  FadeInUp(
                    duration: Duration(milliseconds: 1400),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(225, 95, 27, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          buildTextField("Poultry Name", "Ex: Best Poultry", poultryNameController),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  FadeInUp(
                    duration: Duration(milliseconds: 1600),
                    child: MaterialButton(
                      onPressed: () async {
                        submitForm(context);
                      },
                      height: 50,
                      color: Colors.orange[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),

                        ),
                      ),
                    ),),
                    SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hintText, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}

