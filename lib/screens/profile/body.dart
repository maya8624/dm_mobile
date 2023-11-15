import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircleAvatar(),
              SizedBox(
                height: 46,
                width: 46,
                child: IconButton(
                  color: Color(0xFFF5F6F9),
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt_outlined),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
