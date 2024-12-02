import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF79F21E),
            ),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("We will add it soon 🔜"),
                  ),
                );
              },
              icon: FaIcon(FontAwesomeIcons.facebookF),
              color: Colors.black,
              iconSize: 20,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF79F21E),
            ),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("We will add it soon 🔜"),
                  ),
                );
              },
              icon: FaIcon(FontAwesomeIcons.twitter),
              color: Colors.black,
              iconSize: 20,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF79F21E),
            ),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("We will add it soon 🔜"),
                  ),
                );
              },
              icon: FaIcon(FontAwesomeIcons.linkedin),
              color: Colors.black,
              iconSize: 20,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF79F21E),
            ),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("We will add it soon 🔜"),
                  ),
                );
              },
              icon: FaIcon(FontAwesomeIcons.instagram),
              color: Colors.black,
              iconSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
