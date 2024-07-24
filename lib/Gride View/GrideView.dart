import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/screens/forms/DriverDetail.dart';
import 'package:e_commerce/screens/forms/ExpenseDetail.dart';
import 'package:e_commerce/screens/forms/LoadDetails.dart';
import 'package:e_commerce/screens/forms/PUCdetail.dart';
import 'package:e_commerce/screens/forms/Permit.dart';
import 'package:e_commerce/screens/forms/VehicleDetails.dart';
import 'package:e_commerce/screens/forms/insurancedetail.dart';
import 'package:e_commerce/screens/forms/refuel.dart';
import 'package:e_commerce/screens/forms/servics.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:flutter/material.dart';

class Grideview extends StatelessWidget {
  const Grideview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Taurus',),
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
                      MaterialPageRoute(builder: (context) => Fuel()),
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
                      MaterialPageRoute(builder: (context) => const Services()),
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
                      MaterialPageRoute(builder: (context) => const Expensedetail()),
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
                      MaterialPageRoute(builder: (context) => const Insurancedetail()),
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
                      MaterialPageRoute(builder: (context) =>const  Permit()),
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
                      ),),),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>const PUCDetail()),
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
                      MaterialPageRoute(builder: (context) => const LoadDetails()),
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
                      MaterialPageRoute(builder: (context) => const  VehicleDetails()),
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
                      MaterialPageRoute(builder: (context) => const DriverDetail()),
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
