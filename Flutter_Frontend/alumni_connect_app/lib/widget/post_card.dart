import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostCard extends StatefulWidget {
  String email;
  String imageLink;
  String name;
  String description;
  PostCard({
    required this.email,
    required this.imageLink,
    required this.name,
    required this.description,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String to_email = "";

  bool requestProcessing = false;
  bool tick = false;

  sendRequest() async {
    setState(() {
      requestProcessing = true;
    });

    Map<String, dynamic> requestPayload = {
      "email_from": widget.email,
      "email_to": to_email
    };

    var url = Uri.parse('http://127.0.0.1:8001/api/connect_user/');
    var response = await http.post(
      url,
      body: jsonEncode(requestPayload),
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        requestProcessing = false;
        tick = true;
      });
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
    return Container(
      height: 500,
      width: size.width * 0.9,
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        // color: Colors.blue[900],
        border: Border.all(
          color: Colors.grey[600]!,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
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
                  "assets/student-min.jpg",
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    to_email = widget.email;
                  });
                  sendRequest();
                },
                child: requestProcessing
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      )
                    : tick
                        ? Icon(
                            Icons.check,
                          )
                        : Icon(
                            Icons.person_add,
                          ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 200,
            width: size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(widget.imageLink),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ReadMoreText(
                  widget.description,
                  trimLines: 2,
                  colorClickableText: Colors.blue[600],
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Read more',
                  trimExpandedText: ' Read less',
                  moreStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  lessStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
