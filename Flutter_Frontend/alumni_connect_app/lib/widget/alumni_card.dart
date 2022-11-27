import 'package:flutter/material.dart';

class AlumniCard extends StatefulWidget {
  String name;
  String email;
  String imageLink;
  AlumniCard(
      {required this.name, required this.email, required this.imageLink});

  @override
  State<AlumniCard> createState() => _AlumniCardState();
}

class _AlumniCardState extends State<AlumniCard> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      height: 80,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 33,
            color: Color(0xFFD3D3D3).withOpacity(.84),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: AssetImage(widget.imageLink),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.person_add,
            ),
          )
        ],
      ),
    );
  }
}
