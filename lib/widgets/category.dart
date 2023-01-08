import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onPress;
  final Color color;
  final double width;
  final double height;

  const Category(
      {super.key,
      required this.height,
      required this.width,
      required this.color,
      required this.name,
      required this.image,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onPress,
          child: Container(
            margin: const EdgeInsets.all(10.0),
            width: width,
            height: height,
            decoration: BoxDecoration(
                border: Border.all(width: 4.0, color: Colors.white),
                color: color,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 3),
                    blurRadius: 6.0,
                    color: Colors.black12,
                  ),
                  BoxShadow(
                    offset: Offset(3, 0),
                    blurRadius: 6.0,
                    color: Colors.black12,
                  ),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          name.toUpperCase(),
          style: const TextStyle(
              fontSize: 18.0, fontFamily: 'DIN', fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
