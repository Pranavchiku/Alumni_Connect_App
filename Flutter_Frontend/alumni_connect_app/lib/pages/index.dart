import 'package:alumni_connect_app/widget/image.dart';
import 'package:alumni_connect_app/widget/top_suggestion_card.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  List<dynamic> _topSuggestionCard = <Widget>[
    TopSuggestionCard(
      name: "Todd Cook",
      imageLink: "assets/student-min.jpg",
      designation: "CEO at Apple",
    ),
    TopSuggestionCard(
      name: "Todd Cook",
      imageLink: "assets/student-min.jpg",
      designation: "CEO at Apple",
    ),
    TopSuggestionCard(
      name: "Todd Cook",
      imageLink: "assets/student-min.jpg",
      designation: "CEO at Apple",
    ),
    TopSuggestionCard(
      name: "Todd Cook",
      imageLink: "assets/student-min.jpg",
      designation: "CEO at Apple",
    ),
    TopSuggestionCard(
      name: "Todd Cook",
      imageLink: "assets/student-min.jpg",
      designation: "CEO at Apple",
    ),
    TopSuggestionCard(
      name: "Todd Cook",
      imageLink: "assets/student-min.jpg",
      designation: "CEO at Apple",
    ),
  ];
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
          top: size.height * 0.06,
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
                      Category(
                        size: size,
                        alumniCount: "10",
                        categoryName: "SDE",
                        imageLink: "assets/student-min.jpg",
                      ),
                      Category(
                        size: size,
                        alumniCount: "10",
                        categoryName: "SDE",
                        imageLink: "assets/student-min.jpg",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Category(
                        size: size,
                        alumniCount: "10",
                        categoryName: "SDE",
                        imageLink: "assets/student-min.jpg",
                      ),
                      Category(
                        size: size,
                        alumniCount: "10",
                        categoryName: "SDE",
                        imageLink: "assets/student-min.jpg",
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
            ],
          ),
        ),
      ),
    );
  }
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
