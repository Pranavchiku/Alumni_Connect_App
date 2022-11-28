import 'package:alumni_connect_app/main.dart';
import 'package:alumni_connect_app/pages/index.dart';
import 'package:alumni_connect_app/pages/post_page.dart';
import 'package:alumni_connect_app/widget/alumni_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'connection_page.dart';

class FieldAlumni extends StatefulWidget {
  bool isSDE;
  bool isML_DL;
  bool isDS;
  bool isMBA;
  String email;

  FieldAlumni(
      {required this.isSDE,
      required this.isML_DL,
      required this.isDS,
      required this.isMBA,
      required this.email});

  @override
  State<FieldAlumni> createState() => FieldAlumniState();
}

class FieldAlumniState extends State<FieldAlumni> {
  List alumniList = [];

  fetchAlumni() async {
    if (widget.isSDE) {
      var url = Uri.parse("http://127.0.0.1:8001/api/get_sde/");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var items = json.decode(response.body) as List;
        setState(() {
          alumniList = items;
        });
      }
    } else if (widget.isML_DL) {
      var url = Uri.parse("http://127.0.0.1:8001/api/get_ml_dl/");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var items = json.decode(response.body) as List;
        setState(() {
          alumniList = items;
        });
      }
    } else if (widget.isDS) {
      var url = Uri.parse("http://127.0.0.1:8001/api/get_ds/");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var items = json.decode(response.body) as List;
        setState(() {
          alumniList = items;
        });
      }
    } else if (widget.isMBA) {
      var url = Uri.parse("http://127.0.0.1:8001/api/get_management/");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var items = json.decode(response.body) as List;
        setState(() {
          alumniList = items;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAlumni();
  }

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
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Field Alumni",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              for (var i = 0; i < alumniList.length; i++)
                AlumniCard(
                  name: alumniList[i]["name"],
                  email_to: alumniList[i]["email"],
                  imageLink: "assets/student-min.jpg",
                  email_from: widget.email,
                ),
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
