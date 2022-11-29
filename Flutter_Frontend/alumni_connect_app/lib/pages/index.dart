import 'package:alumni_connect_app/main.dart';
import 'package:alumni_connect_app/pages/alums_page.dart';
import 'package:alumni_connect_app/pages/connection_page.dart';
import 'package:alumni_connect_app/pages/post_page.dart';
import 'package:alumni_connect_app/widget/image.dart';
import 'package:alumni_connect_app/widget/post_card.dart';
import 'package:alumni_connect_app/widget/top_suggestion_card.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Index extends StatefulWidget {
  String email;
  Index({required this.email});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  List<dynamic> _topSuggestionCard = <Widget>[];
  List<dynamic> _latestPosts = [];
  String? _sdeCount = "0";
  String? ml_dlCount = "0";
  String? _dsCount = "0";
  String? _mbaCount = "0";
  String to_email = "";

  fetchTopSuggestion() async {
    var url = Uri.parse('http://127.0.0.1:8001/api/top_suggestion/');
    Map<String, dynamic> requestPayload = {"email": widget.email};

    var response = await http.post(
      url,
      body: jsonEncode(requestPayload),
    );

    var body = jsonDecode(response.body);
    body = body["top_suggestion"] as List;
    if (response.statusCode == 200) {
      List<dynamic> tempCard = <Widget>[];
      for (var i = 0; i < body.length; i++) {
        tempCard.add(TopSuggestionCard(
            name: body[i]['name'],
            imageLink: "assets/student-min.jpg",
            designation: ""));
      }
      setState(() {
        _topSuggestionCard = tempCard;
      });
    }
  }

  fetchFieldCount() async {
    var url = Uri.parse("http://127.0.0.1:8001/api/field_count/");
    var response = await http.get(url);

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        _sdeCount = body["SDE"].toString();
        ml_dlCount = body["ML_DL"].toString();
        _dsCount = body["DS"].toString();
        _mbaCount = body["Management"].toString();
      });
    }
  }

  fetchLatestUpdates() async {
    var url = Uri.parse('http://127.0.0.1:8001/api/get_posts/');
    Map<String, dynamic> requestPayload = {"email": widget.email};

    var response = await http.post(
      url,
      body: jsonEncode(requestPayload),
    );

    var body = jsonDecode(response.body) as List;

    List<dynamic> temp = <Widget>[];
    // iterate over body and create a list of post cards
    if (response.statusCode == 200) {
      for (var i = 0; i < body.length; i++) {
        temp.add(PostCard(
          name: body[i]['name'],
          imageLink: "assets/student-min.jpg",
          email: widget.email,
          description: body[i]['description'],
        ));
      }
      setState(() {
        _latestPosts = temp;
      });
    } else {
      showError("Internal server Error");
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
  void initState() {
    super.initState();
    fetchTopSuggestion();
    fetchFieldCount();
    fetchLatestUpdates();
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
            children: [
              Text(
                "Explore people",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Best of Best",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchBar(size: size),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Top Suggestions",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TopSuggestionListView(
                size: size,
                topSuggestionCard: _topSuggestionCard,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Popular Fields",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FieldAlumni(
                                isSDE: true,
                                isML_DL: false,
                                isDS: false,
                                isMBA: false,
                                email: widget.email,
                              ),
                            ),
                          );
                        },
                        child: Category(
                          size: size,
                          alumniCount: _sdeCount!,
                          categoryName: "SDE",
                          imageLink: "assets/student-min.jpg",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FieldAlumni(
                                isSDE: false,
                                isML_DL: true,
                                isDS: false,
                                isMBA: false,
                                email: widget.email,
                              ),
                            ),
                          );
                        },
                        child: Category(
                          size: size,
                          alumniCount: ml_dlCount!,
                          categoryName: "ML_DL",
                          imageLink: "assets/student-min.jpg",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FieldAlumni(
                                isSDE: false,
                                isML_DL: false,
                                isDS: true,
                                isMBA: false,
                                email: widget.email,
                              ),
                            ),
                          );
                        },
                        child: Category(
                          size: size,
                          alumniCount: _dsCount!,
                          categoryName: "DS",
                          imageLink: "assets/student-min.jpg",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FieldAlumni(
                                isSDE: false,
                                isML_DL: false,
                                isDS: false,
                                isMBA: true,
                                email: widget.email,
                              ),
                            ),
                          );
                        },
                        child: Category(
                          size: size,
                          alumniCount: _mbaCount!,
                          categoryName: "MBA",
                          imageLink: "assets/student-min.jpg",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Latest Updates",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              for (var i = 0; i < _latestPosts.length; i++) _latestPosts[i]
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

class Category extends StatelessWidget {
  Category({
    required this.size,
    required this.imageLink,
    required this.categoryName,
    required this.alumniCount,
  });

  final Size size;
  String imageLink;
  String categoryName;
  String alumniCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.4,
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              imageLink,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryName,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                alumniCount + " Alumni",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TopSuggestionListView extends StatelessWidget {
  const TopSuggestionListView({
    Key? key,
    required this.size,
    required List topSuggestionCard,
  })  : _topSuggestionCard = topSuggestionCard,
        super(key: key);

  final Size size;
  final List _topSuggestionCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _topSuggestionCard.length,
        itemBuilder: (BuildContext context, int index) {
          return _topSuggestionCard[index];
        },
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: size.width * 0.75,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Color.fromRGBO(0, 0, 0, 0.1),
          )
        ],
      ),
      child: TextFormField(
        onChanged: (string) {},
        obscureText: false,
        validator: (input) {
          if (input != null && input.isEmpty) {
            return "Please enter some text";
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
          ),
          hintText: "Search",
          hintStyle: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
