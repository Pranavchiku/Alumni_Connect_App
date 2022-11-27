import 'package:flutter/material.dart';

class TopSuggestionCard extends StatefulWidget {
  String name;
  String imageLink;
  String designation;

  TopSuggestionCard({
    required this.name,
    required this.imageLink,
    required this.designation,
  });

  @override
  State<TopSuggestionCard> createState() => _TopSuggestionCardState();
}

class _TopSuggestionCardState extends State<TopSuggestionCard> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: size.height * 0.25,
        width: size.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.grey[600],
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.only(right: 25),
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.designation,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: size.height * 0.15,
              // width: size.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(
                    widget.imageLink,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
