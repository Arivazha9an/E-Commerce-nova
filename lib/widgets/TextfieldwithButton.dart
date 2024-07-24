import 'package:e_commerce/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomFieldButton extends StatelessWidget {
  final String name;

  const CustomFieldButton({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 330,
          height: 55,
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              hintText: name,
              hintStyle: TextStyle(color: black),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    bottomLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                    bottomRight: Radius.circular(17)),
                borderSide: BorderSide(color: black, style: BorderStyle.none),
              ),
            ),
          ),
        ),
        Positioned(
          left: 250,
          child: Container(
            width: 80,
            height: 55,
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 80,
                height: 46,
                decoration: BoxDecoration(
                    color: blue,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        topRight: Radius.circular(17),
                        bottomRight: Radius.circular(17)),
                    border: Border.all(color: blue)),
                child: const Center(
                  child: Text(
                    'Details',
                    style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
