import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/screens/forms/servics.dart';
import 'package:e_commerce/screens/retrieve/serviceretrieve.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:flutter/material.dart';

class TServiceselect extends StatefulWidget {
  const TServiceselect({super.key});

  @override
  State<TServiceselect> createState() => _VehicleselectState();
}

class _VehicleselectState extends State<TServiceselect> {
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
                    MaterialPageRoute(builder: (context) => const Services()),
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
                    MaterialPageRoute(
                        builder: (context) => const Serviceretrieve2()),
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
