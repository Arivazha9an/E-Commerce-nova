import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/LoadDetails.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/PUCdetail.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/VehicleDetails.dart';

import 'package:e_commerce/BharathBenz/Vehicle%201/screens/retrieve/PUCretrieve.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/retrieve/loadretrieve.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/retrieve/vehicleretrieve.dart';
import 'package:e_commerce/constants/colors.dart';

import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:flutter/material.dart';

class Vehicledetailselect extends StatefulWidget {
  const Vehicledetailselect({super.key});

  @override
  State<Vehicledetailselect> createState() => _VehicleselectState();
}

class _VehicleselectState extends State<Vehicledetailselect> {
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
                        builder: (context) => const BVehicleDetails()),
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
                    MaterialPageRoute(builder: (context) => Vehicleretrieve()),
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
