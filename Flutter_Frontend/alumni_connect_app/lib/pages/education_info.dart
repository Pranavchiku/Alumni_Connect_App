import 'package:alumni_connect_app/pages/work_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'index.dart';

class EducationInfo extends StatefulWidget {
  String email;
  bool isAlum;

  EducationInfo({required this.email, required this.isAlum});

  @override
  State<EducationInfo> createState() => _EducationInfoState();
}

class _EducationInfoState extends State<EducationInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _degree, _yearJoined, _yearGraduated, _branch;

  signup() async {
    if (_formKey != null &&
        _formKey.currentState != null &&
        _formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Map<String, dynamic> requestPayload = {
        "email": widget.email,
        "degree": _degree,
        "year_joined": _yearJoined,
        "year_passed": _yearGraduated,
        "branch": _branch
      };

      var url = Uri.parse('http://127.0.0.1:8001/api/user_education_info/');
      var response = await http.post(
        url,
        body: jsonEncode(requestPayload),
      );

      var body = jsonDecode(response.body);

      if (response.statusCode == 201) {
        if (widget.isAlum) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => WorkInfo(email: widget.email)),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => Index(email: widget.email)),
              (route) => false);
        }
      } else {
        showError("Internal Server Error");
      }
    }
  }

  showError(String errormessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ERROR'),
          content: Text(errormessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: size.height * 0.2,
            top: size.height * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Education Information",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: size.width * 0.1,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextFormField(
                        validator: (input) {
                          if (input != null && input.isEmpty)
                            return "Enter Degree";
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Degree",
                          prefixIcon: Icon(Icons.cast_for_education),
                        ),
                        onSaved: (input) => _degree = input!,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextFormField(
                        validator: (input) {
                          if (input != null && input.isEmpty)
                            return "Enter Branch";
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Branch",
                          prefixIcon: Icon(Icons.featured_play_list_outlined),
                        ),
                        onSaved: (input) => _branch = input!,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextFormField(
                        validator: (input) {
                          if (input != null && input.isEmpty)
                            return "Enter year of joining";
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Year of Joining",
                          prefixIcon: Icon(Icons.arrow_right_alt_sharp),
                        ),
                        onSaved: (input) => _yearJoined = input!,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextFormField(
                        validator: (input) {
                          if (input != null && input.isEmpty)
                            return "Enter year of graduation";
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Year of graduation",
                          prefixIcon: Icon(Icons.grade_outlined),
                        ),
                        onSaved: (input) => _yearGraduated = input!,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: size.height * 0.07,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  onPressed: signup,
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
