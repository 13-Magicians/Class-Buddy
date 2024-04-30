import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String body;
  final Function() onMoreTap;

  final String subInfoTitle;
  final String subInfoText;
  final Widget subIcon;

  const InfoCard(
      {required this.title,
        this.body =
        """Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudi conseqr!""",
        required this.onMoreTap,
        this.subIcon = const CircleAvatar(
          backgroundColor: Colors.orange,
          radius: 25,
          child: Icon(
            Icons.directions,
            color: Colors.white,
          ),
        ),
        this.subInfoText = "3 Credits",
        this.subInfoTitle = "Total Credits",
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: const Offset(0, 10),
              blurRadius: 0,
              spreadRadius: 0,
            )
          ],
          gradient: const RadialGradient(
            colors: [Colors.deepOrange, Colors.deepOrangeAccent],
            focal: Alignment.topCenter,
            radius: .85,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: 75,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: GestureDetector(
                  onTap: onMoreTap,
                  child: const Center(
                      child: Text(
                        "More",
                        style: TextStyle(color: Colors.orange),
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style:
            TextStyle(color: Colors.white.withOpacity(.75), fontSize: 14),
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  subIcon,
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subInfoTitle),
                      Text(
                        subInfoText,
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}