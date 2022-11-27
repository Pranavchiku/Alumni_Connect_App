import 'package:alumni_connect_app/pages/education_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'index.dart';

class FieldsOfInterest extends StatefulWidget {
  String email;
  bool isAlum;
  FieldsOfInterest({required this.email, required this.isAlum});

  @override
  State<FieldsOfInterest> createState() => _FieldsOfInterestState();
}

class _FieldsOfInterestState extends State<FieldsOfInterest> {
  bool SDE = false;
  bool ML = false;
  bool DS = false;
  bool MBA = false;
  bool Others = false;

  signup() async {
    Map<String, dynamic> requestPayload = {
      "email": widget.email,
      "SDE": SDE,
      "ML_DL": ML,
      "DS": DS,
      "Management": MBA,
      "Others": Others
    };

    var url = Uri.parse('http://127.0.0.1:8001/api/user_work_fields/');
    var response = await http.post(
      url,
      body: jsonEncode(requestPayload),
    );

    var body = jsonDecode(response.body);
    if (response.statusCode == 201) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EducationInfo(email: widget.email, isAlum: widget.isAlum)),
          (route) => false);
    } else {
      showError("Internal Server Error");
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
                "Fields of Interest",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: size.width * 0.1,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: const Icon(Icons.computer_rounded),
                title: const Text('Software Development'),
                value: SDE,
                onChanged: (bool) {
                  setState(() {
                    SDE = true;
                  });
                },
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: const Icon(Icons.data_exploration_outlined),
                title:
                    const Text('Machine Learning and Artifical Intelligence'),
                value: ML,
                onChanged: (bool) {
                  setState(() {
                    ML = true;
                  });
                },
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: const Icon(Icons.data_exploration_outlined),
                title: const Text('Data science'),
                value: DS,
                onChanged: (bool) {
                  setState(() {
                    DS = true;
                  });
                },
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: const Icon(Icons.manage_accounts),
                title: const Text('Management'),
                value: MBA,
                onChanged: (bool) {
                  setState(() {
                    MBA = true;
                  });
                },
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: const Icon(Icons.work_outline_sharp),
                title: const Text('Others'),
                value: Others,
                onChanged: (bool) {
                  setState(() {
                    Others = true;
                  });
                },
              ),
              SizedBox(height: 20),
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
