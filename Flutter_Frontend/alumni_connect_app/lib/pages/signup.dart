import 'package:alumni_connect_app/main.dart';
import 'package:alumni_connect_app/pages/index.dart';
import 'package:alumni_connect_app/pages/signup_form.dart';
import 'package:alumni_connect_app/widget/image.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  PageController controller = PageController();
  int _curr = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = <Widget>[
      _list_Page(
        ImageLink: "assets/student-min.jpg",
        signAs: "Student",
        curr: _curr,
      ),
      _list_Page(
        ImageLink: "assets/alumni-min.jpg",
        signAs: "an Alumni",
        curr: _curr,
      ),
    ];
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
          bottom: size.height * 0.03,
          top: size.height * 0.1,
        ),
        child: PageView(
          children: _list,
          scrollDirection: Axis.horizontal,
          // reverse: true,
          // physics: BouncingScrollPhysics(),
          controller: controller,
          onPageChanged: (num) {
            setState(() {
              _curr = num;
            });
          },
        ),
      ),
    );
  }
}

class _list_Page extends StatefulWidget {
  String ImageLink;
  String signAs;
  int curr;

  _list_Page({
    required this.ImageLink,
    required this.signAs,
    required this.curr,
  });

  @override
  State<_list_Page> createState() => _list_PageState();
}

class _list_PageState extends State<_list_Page> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        print(widget.curr);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpForm(isAlum: widget.curr == 1 ? true : false)),
        );
      },
      child: Center(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Signup as " + widget.signAs,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomImage(ImageLink: widget.ImageLink),
                const SizedBox(
                  height: 30,
                ),
                new DotsIndicator(
                  dotsCount: 2,
                  position: widget.curr.toDouble(),
                  decorator: DotsDecorator(
                    color: Colors.black87, // Inactive color
                    activeColor: Colors.blue[900],
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 50,
                  color: Colors.blue[900],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
