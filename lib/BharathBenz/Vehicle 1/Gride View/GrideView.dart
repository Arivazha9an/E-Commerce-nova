import 'package:e_commerce/Auth/login.dart';
import 'package:e_commerce/Auth/signup.dart';
import 'package:e_commerce/BharathBenz/Vehicle%202/Gride%20View/GrideView2.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';

import 'package:flutter/material.dart';

import '../screens/forms/DriverDetail.dart';
import '../screens/forms/ExpenseDetail.dart';
import '../screens/forms/LoadDetails.dart';
import '../screens/forms/PUCdetail.dart';
import '../screens/forms/Permit.dart';
import '../screens/forms/VehicleDetails.dart';
import '../screens/forms/insurancedetail.dart';
import '../screens/forms/refuel.dart';
import '../screens/forms/servics.dart';

class BGrideview extends StatefulWidget {
  const BGrideview({super.key});

  @override
  State<BGrideview> createState() => _BGrideviewState();
}

class _BGrideviewState extends State<BGrideview> {
  String _appBarTitle = 'Vehicle 1'; // Default AppBar title

  void _onDropdownChanged(String? newValue) {
    if (newValue == 'Vehicle 1') {
      setState(() {
        _appBarTitle = newValue!; // Change AppBar title to Option 1
      });
    } else if (newValue == 'Vehicle 2') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BGrideview2(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_appBarTitle),
            SizedBox(width: 8), // Space between title and dropdown
            PopupMenuButton<String>(
              icon: Icon(Icons.arrow_drop_down, color: black),
              onSelected: _onDropdownChanged,
              itemBuilder: (BuildContext context) {
                return {'Vehicle 1', 'Vehicle 2'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
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
                      MaterialPageRoute(builder: (context) => BFuel()),
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
                          builder: (context) => const BServices()),
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
                          builder: (context) => const BExpensedetail()),
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
                          builder: (context) => const BInsurancedetail()),
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
                      MaterialPageRoute(builder: (context) => const BPermit()),
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
                          builder: (context) => const BPUCDetail()),
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
                          builder: (context) => const BLoadDetails()),
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
                          builder: (context) => const BVehicleDetails()),
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
                          builder: (context) => const BDriverDetail()),
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
