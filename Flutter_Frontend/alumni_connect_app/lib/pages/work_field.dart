import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'index.dart';

class WorkInfo extends StatefulWidget {
  String email;
  WorkInfo({required this.email});

  @override
  State<WorkInfo> createState() => _WorkInfoState();
}

class _WorkInfoState extends State<WorkInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _company, _workExp;

  signup() async {
    if (_formKey != null &&
        _formKey.currentState != null &&
        _formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Map<String, dynamic> requestPayload = {
        "email": widget.email,
        "company": _company,
        "work": int.parse(_workExp!)
      };

      var url = Uri.parse('http://127.0.0.1:8001/api/user_work_info/');
      var response = await http.post(
        url,
        body: jsonEncode(requestPayload),
      );
      var body = jsonDecode(response.body);

      if (response.statusCode == 201) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Index(email: widget.email)),
            (route) => false);
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
                "Work Information",
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
                            return "Enter Company name";
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Company Name",
                          prefixIcon: Icon(Icons.cast_for_education),
                        ),
                        onSaved: (input) => _company = input!,
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
                            return "Enter experience";
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Experience",
                          prefixIcon: Icon(Icons.featured_play_list_outlined),
                        ),
                        onSaved: (input) => _workExp = input!,
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
                  onPressed: () {},
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
