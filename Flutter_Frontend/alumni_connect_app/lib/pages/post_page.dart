import 'package:alumni_connect_app/main.dart';
import 'package:alumni_connect_app/pages/connection_page.dart';
import 'package:alumni_connect_app/pages/index.dart';
import 'package:alumni_connect_app/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlumniPost extends StatefulWidget {
  String email;
  AlumniPost({required this.email});

  @override
  State<AlumniPost> createState() => _AlumniPostState();
}

class _AlumniPostState extends State<AlumniPost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _description, _image;

  postHandler() async {
    if (_formKey != null &&
        _formKey.currentState != null &&
        _formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Map<String, dynamic> requestPayload = {
        "email": widget.email,
        "description": _description,
        "image_link": _image
      };

      var url = Uri.parse('http://127.0.0.1:8001/api/create_post/');
      var response = await http.post(
        url,
        body: jsonEncode(requestPayload),
      );

      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
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
      body: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: size.height * 0.05,
          // top: size.height * 0.06,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Write Post",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: size.width * 0.1,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 100),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextFormField(
                            validator: (input) {
                              if (input != null && input.isEmpty)
                                return "Enter Description";
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Description",
                              prefixIcon: Icon(Icons.description),
                            ),
                            onSaved: (input) => _description = input!,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextFormField(
                            validator: (input) {
                              if (input != null && input.isEmpty)
                                return "Enter image link";
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Image link",
                              prefixIcon: Icon(Icons.image),
                            ),
                            obscureText: false,
                            onSaved: (input) => _image = input!,
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    height: size.height * 0.07,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                      onPressed: postHandler,
                      child: Text(
                        "Post",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 55.0,
        child: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Index(email: widget.email)));
                },
              ),
              IconButton(
                icon: Icon(Icons.person_add, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ConnectionPage(email: widget.email)),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.add_box_outlined, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AlumniPost(email: widget.email)),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.logout, color: Colors.black),
                onPressed: () {
                  showAlertDialog(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  // Widget logOutButton = SalomonBottomBarItem(
  //   icon: Icon(Icons.logout),
  //   title: Text("LogOut"),
  //   selectedColor: Colors.redAccent,
  // );
  Widget okButton = TextButton(
    child: Text("Logout"),
    onPressed: () {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => HomePage()));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LandingPage()),
          (route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Logout Alert!!"),
    content: Text("Are you sure you want to logout?"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
