import 'package:e_commerce/constants/colors.dart';

import 'package:e_commerce/screens/select/loaddispatch.dart';
import 'package:e_commerce/screens/select/loadreturn.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombuttom%20outlined.dart';
import 'package:flutter/material.dart';

class Loaddetailselect extends StatefulWidget {
  const Loaddetailselect({super.key});

  @override
  State<Loaddetailselect> createState() => _VehicleselectState();
}

class _VehicleselectState extends State<Loaddetailselect> {
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
              CustomTextButtonOut(
                width: 200,
                title: 'Load Dispatch',
                background: white,
                textColor: black,
                fontSize: 18,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Loaddispatchselect()),
                  );
                },
                color: orange,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextButtonOut(
                width: 200,
                title: 'Load Return',
                background: white,
                textColor: black,
                fontSize: 18,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Loadreturnselect()),
                  );
                },
                color: orange,
              ),
            ],
          )
        ],
      ),
    );
  }
}
