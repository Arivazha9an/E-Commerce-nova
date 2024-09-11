
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/select/Insuranceselect.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/select/Loadselect.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/select/PUCSelect.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/select/Permitselect.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/select/Refuelselect.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/select/driverselect.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/select/expenseSelect.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/select/serviceselect.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/select/vehicledetailselect.dart';


import 'package:e_commerce/constants/colors.dart';

import 'package:flutter/material.dart';

class BGrideview extends StatefulWidget {
  const BGrideview({super.key});

  @override
  State<BGrideview> createState() => _BGrideviewState();
}

class _BGrideviewState extends State<BGrideview> {
  // Default AppBar title

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bharath Benz'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Fuelselect()),
                    );
                  },
                  child: Container(
                      height: 100,
                      width: 155,
                      decoration: const BoxDecoration(
                        color: black,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/fuel.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        'Refuel',
                        style: TextStyle(
                            color: white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ))),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Serviceselect()),
                    );
                  },
                  child: Container(
                      height: 100,
                      width: 155,
                      decoration: const BoxDecoration(
                        color: black,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/service.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        'Service',
                        style: TextStyle(
                            color: white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ))),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Expenseselect()),
                    );
                  },
                  child: Container(
                      height: 100,
                      width: 155,
                      decoration: const BoxDecoration(
                        color: black,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/expense.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        'Expense',
                        style: TextStyle(
                            color: white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ))),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Insuranceselect()),
                    );
                  },
                  child: Container(
                      height: 100,
                      width: 155,
                      decoration: const BoxDecoration(
                        color: black,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/insurance.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        'Insurance',
                        style: TextStyle(
                            color: white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ))),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Permitselect()),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 155,
                    decoration: const BoxDecoration(
                      color: black,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: AssetImage("assets/images/permit.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Permit',
                        style: TextStyle(
                            color: white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Pucselect()),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 155,
                    decoration: const BoxDecoration(
                      color: black,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: AssetImage("assets/images/PUC.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'PUC',
                        style: TextStyle(
                            color: white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Loadselect()),
                    );
                  },
                  child: Container(
                      height: 100,
                      width: 155,
                      decoration: const BoxDecoration(
                        color: black,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/load.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        'Load',
                        style: TextStyle(
                            color: white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ))),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Vehicledetailselect()),
                    );
                  },
                  child: Container(
                      height: 100,
                      width: 155,
                      decoration: const BoxDecoration(
                        color: black,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/vehicledetails.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        'Vehicle Details',
                        style: TextStyle(
                            color: white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ))),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Driverselect()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 21),
                    child: Container(
                        height: 100,
                        width: 155,
                        decoration: const BoxDecoration(
                          color: black,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: AssetImage("assets/images/driver.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(
                            child: Text(
                          'Driver',
                          style: TextStyle(
                              color: white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ))),
                  ),
                ),
             
              ],
            )
          ],
        ),
      ),
    );
  }
}
