import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/screens/forms/loadreturn.dart';
import 'package:e_commerce/screens/retrieve/Loadreturnretrieve.dart';

import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:flutter/material.dart';

class Loadreturnselect extends StatefulWidget {
  const Loadreturnselect({super.key});

  @override
  State<Loadreturnselect> createState() => _VehicleselectState();
}

class _VehicleselectState extends State<Loadreturnselect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Select'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextButton(
                title: 'Store',
                background: green,
                textColor: white,
                fontSize: 18,
                width: 200,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Loadreturn()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextButton(
                width: 200,
                title: 'View',
                background: orange,
                textColor: white,
                fontSize: 18,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Loadreturnretrieve()),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
