import 'package:e_commerce/models/customer.dart';
import 'package:e_commerce/screens/forms/Supplierdetails.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';

import 'package:e_commerce/widgets/TextfieldwithButton.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Supplierretrievehover extends StatefulWidget {
  const Supplierretrievehover({super.key});

  @override
  State<Supplierretrievehover> createState() => _SupplierretrievehoverState();
}

class _SupplierretrievehoverState extends State<Supplierretrievehover> {
  bool _isLoading = true;
   List<Map<String, dynamic>> dataList = [];
    @override
  void initState() {
    super.initState();
     _fetchData();
    _simulateLoading();
    expenseSum();
    incomeSum();
  }

  Future<void> _fetchData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('supplierdetails').get();

    setState(() {
      dataList = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    });
  }

 

  Future<void> _simulateLoading() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Simulate a 2-second loading time
    setState(() {
      _isLoading = false; // Update state to show the main UI
    });
  }

  double combinedexpense = 0.0;
  double combineincome = 0.0;

 Future incomeSum() async {
    try {
      // Initialize a combined sum variable
      double combinedIncome = 0.0;

      // List of collection names
      List<String> collections = [
        'bharathbenzloaddetail',
        'bharathbenzloaddetail2',
        'taurusloaddetail',
      ];

      // Field names to sum
      String field1 = 'Delivery Amount';
      String field2 = 'Delivery Amount1';

      // Iterate through each collection
      for (String collection in collections) {
        // Fetch all documents from the current collection
        QuerySnapshot querySnapshot =
            await FirebaseFirestore.instance.collection(collection).get();

        // Iterate through documents in the current collection
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          // Access document data
          final data = doc.data() as Map<String, dynamic>;

          // Get the values of field1, field2, and field3
          final fieldValue1 = data[field1];
          final fieldValue2 = data[field2];

          // Convert to double and add to combined sum
          if (fieldValue1 != null) {
            if (fieldValue1 is String) {
              combinedIncome += double.tryParse(fieldValue1) ?? 0.0;
            } else if (fieldValue1 is num) {
              combinedIncome += fieldValue1.toInt();
            }
          }
          if (fieldValue2 != null) {
            if (fieldValue2 is String) {
              combinedIncome += double.tryParse(fieldValue2) ?? 0.0;
            } else if (fieldValue2 is num) {
              combinedIncome += fieldValue2.toInt();
            }
          }
        }
      }
      setState(() {
        combineincome = combinedIncome;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching documents: $e');
      }
    }
  }

  Future expenseSum() async {
    try {
      // Initialize a combined sum variable
      double combinedExpense = 0.0;

      // List of collection names
      List<String> collections = [
        'bharathbenzexpensedetail',
        'bharathbenzexpensedetail2',
        'taurusexpensedetail',
      ];

      // Field names to sum
      String field1 = 'Amount';

      // Iterate through each collection
      for (String collection in collections) {
        // Fetch all documents from the current collection
        QuerySnapshot querySnapshot =
            await FirebaseFirestore.instance.collection(collection).get();

        // Iterate through documents in the current collection
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          // Access document data
          final data = doc.data() as Map<String, dynamic>;

          // Get the values of field1, field2, and field3
          final fieldValue1 = data[field1];

          // Convert to double and add to combined sum
          if (fieldValue1 != null) {
            if (fieldValue1 is String) {
              combinedExpense += double.tryParse(fieldValue1) ?? 0.0;
            } else if (fieldValue1 is num) {
              combinedExpense += fieldValue1.toInt();
            }
          }
        }
      }

      setState(() {
        combinedexpense = combinedExpense;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching documents: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('supplierdetails').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingAnimationWidget.discreteCircle(color: orange, size: 60);
        }

        ;
        return Scaffold(
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              Column(
                                children: [
                                  const Text(
                                    '   Income',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.currency_rupee),
                                      const Text(
                                        '+',
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        combineincome.toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Center(
                                child: SizedBox(
                                  height: 62,
                                  child: VerticalDivider(
                                    width: 2,
                                    color: Color.fromARGB(101, 87, 86, 84),
                                    thickness: 2,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  const Text(
                                    '   Expense',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.currency_rupee),
                                      const Text(
                                        '-',
                                        style: const TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                      Text(
                                        combinedexpense.toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                          Container(
                            color: lightBrown,
                            height: 70,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                       Expanded(
                      child: ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomFieldButton(
                                name: dataList[index]['Name'],
                                ontap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPage1(data: dataList[index]),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            FloatingActionButton.small(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Supplierdetails()),
                                );
                              },
                              backgroundColor: orange,
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.add,
                                color: white,
                              ),
                            ),
                            const Text('Add Supllier'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}


class DetailPage1 extends StatelessWidget {
  final Map<String, dynamic> data;

  DetailPage1({required this.data});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Supplier Information'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: orange, width: w * 0.005)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text('Customer Name ='),
                      Text('${data['Name']}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Place ='),
                      Text('${data['Place']}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Material ='),
                      Text('${data['Material']}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Paid  ='),
                      Text('${data['Paid']}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Not Paid  ='),
                      Text('${data['Not_Paid']}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Payment  ='),
                      Text('${data['Payment']}'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



