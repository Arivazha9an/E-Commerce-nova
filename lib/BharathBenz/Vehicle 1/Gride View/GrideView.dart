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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bharath Benz'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 30),
            buildRow(
                context,
                const Fuelselect(),
                "Refuel",
                "assets/images/fuel.jpg",
                const Serviceselect(),
                "Service",
                "assets/images/service.jpg"),
            const SizedBox(height: 30),
            buildRow(
                context,
                const Expenseselect(),
                "Expense",
                "assets/images/expense.jpg",
                const Insuranceselect(),
                "Insurance",
                "assets/images/insurance.jpg"),
            const SizedBox(height: 30),
            buildRow(
                context,
                const Permitselect(),
                "Permit",
                "assets/images/permit.jpg",
                const Pucselect(),
                "PUC",
                "assets/images/PUC.jpg"),
            const SizedBox(height: 30),
            buildRow(
                context,
                const Loadselect(),
                "Load",
                "assets/images/load.jpg",
                const Vehicledetailselect(),
                "Vehicle Details",
                "assets/images/vehicledetails.jpg"),
            const SizedBox(height: 30),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Driverselect()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 21),
                    child: buildContainer("Driver", "assets/images/driver.jpg"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row buildRow(
      BuildContext context,
      Widget firstRoute,
      String firstText,
      String firstImage,
      Widget secondRoute,
      String secondText,
      String secondImage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildInkWell(context, firstRoute, firstText, firstImage),
        buildInkWell(context, secondRoute, secondText, secondImage),
      ],
    );
  }

  InkWell buildInkWell(
      BuildContext context, Widget route, String text, String image) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      },
      child: buildContainer(text, image),
    );
  }

  Container buildContainer(String text, String image) {
    return Container(
      height: 100,
      width: 155,
      decoration: BoxDecoration(
        color: black,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black
                  .withOpacity(0.5), // Add a semi-transparent overlay
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
          Center(
            child: Text(
              text,
              style: const TextStyle(
                color: white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
