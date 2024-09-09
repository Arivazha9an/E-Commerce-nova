import 'dart:developer';

import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/ExpenseDetail.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/PUCdetail.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/Permit.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/addvehicle.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/insurancedetail.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/refuel.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/retrieve/ExpenseRetreive.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/retrieve/PUCretrieve.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/retrieve/PermitRetrieve.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/retrieve/fuelretrieve.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/retrieve/insuranceretrive.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/retrieve/serviceretrieve.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/servics.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:flutter/material.dart';

class Pucselect extends StatefulWidget {
  const Pucselect({super.key});

  @override
  State<Pucselect> createState() => _VehicleselectState();
}

class _VehicleselectState extends State<Pucselect> {
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
                    MaterialPageRoute(builder: (context) => const BPUCDetail()),
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
                        builder: (context) =>  Pucretrieve()),
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
