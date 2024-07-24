import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/screens/forms/CustomerDetails.dart';
import 'package:e_commerce/widgets/TextfieldwithButton.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/customcolorappbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class IncomeExpense extends StatelessWidget {
  const IncomeExpense({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('customerdetails').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingAnimationWidget.discreteCircle(color: orange, size: 60);
        }

        return Scaffold(
          appBar: CustomAppBarcolor(
            height: 185,
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: white),
                        hintText: 'Search',
                        suffixIcon: const Icon(
                          Icons.search,
                          color: white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                          borderSide: const BorderSide(
                              color: white, style: BorderStyle.solid),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                          borderSide: const BorderSide(
                              color: white, style: BorderStyle.solid),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                          borderSide: const BorderSide(
                              color: white, style: BorderStyle.solid),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20, left: 70),
                  child: Row(
                    children: [
                      Text(
                        'Customer',
                        style: TextStyle(
                            fontSize: 22,
                            color: white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        'Supplier',
                        style: TextStyle(
                            fontSize: 22,
                            color: white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
              
                  String name = data['Name'] ?? '';
              
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add_sharp)),
                            ),
                            const Column(
                              children: [
                                Text(
                                  '   Income',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.currency_rupee),
                                    Text(
                                      '1000',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 45),
                              child: SizedBox(
                                height: 55,
                                child: VerticalDivider(
                                  width: 2,
                                  color: black,
                                  thickness: 2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.minimize)),
                            ),
                            const Column(
                              children: [
                                Text(
                                  '   Expense',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.currency_rupee),
                                    Text(
                                      '1000',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          color: lightBrown,
                          height: 70,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CustomFieldButton(name: name),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
