import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
class PoultryForm extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  late DatabaseReference ref;

  PoultryForm({required this.user}) {
    ref = FirebaseDatabase.instance.ref(user?.uid);
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
            Expanded(
              child: Container(
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
                              buildTextField("Full Name", "Ex: Rudi Setiawan"),
                              buildTextField("Poultry Name", "Ex: Best Poultry"),
                              buildTextField("Maximum Water (Ml)", "Ex: 4000"),
                              buildTextField("Maximum Food (Mg)", "Ex: 2000"),
                              buildTextField("Poultry Count", "Ex: 10"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40),


                      FadeInUp(
                        duration: Duration(milliseconds: 1600),
                        child: MaterialButton(
                          onPressed: () {
                            submitForm();
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
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hintText) {
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
            obscureText: true,
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
  TextEditingController fullNameController = TextEditingController();
  TextEditingController poultryNameController = TextEditingController();
  TextEditingController maxWaterController = TextEditingController();
  TextEditingController maxFoodController = TextEditingController();
  TextEditingController poultryCountController = TextEditingController();
  void submitForm() {
    String fullName = fullNameController.text;
    String poultryName = poultryNameController.text;
    String maxWater = maxWaterController.text;
    String maxFood = maxFoodController.text;
    String poultryCount = poultryCountController.text;

    Map<String, dynamic> poultryData = {
      'FullName': fullName,
      'PoultryName': poultryName,
      'MaxWater': maxWater,
      'MaxFood': maxFood,
      'PoultryCount': poultryCount,
    };
    ref.push().set(poultryData).then((_) {
      print("Data submitted successfully!");
    }).catchError((error) {
      print("Error submitting data: $error");

    });
  }
}



