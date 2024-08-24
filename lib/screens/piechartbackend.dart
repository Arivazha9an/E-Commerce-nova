import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customcolorappbar.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

Future<double> getSumByExpenseType(String expenseType) async {
  double totalAmount = 0.0;

  // Define the three collections
  List<String> collections = [
    'bharathbenzexpensedetail',
    'bharathbenzexpensedetail2',
    'taurusexpensedetail'
  ];

  // Iterate over each collection
  for (String collection in collections) {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collection)
        .where('ExpenseType', isEqualTo: expenseType)
        .get();
    // Sum the amounts for the matching expense type
    for (var doc in querySnapshot.docs) {
      // Convert the amount from String to double
      String amountString = doc['Amount'];
      double amount = double.tryParse(amountString) ?? 0.0;
      totalAmount += amount;
    }
  }

  return totalAmount;
}

Future<Map<String, double>> fetchExpenseData() async {
  // Define the expense types
  List<String> expenseTypes = [
    'Food',
    'Lorry Service',
    'Tyre',
    'Fast tag/Tole'
  ];

  // Initialize the map
  Map<String, double> dataMap = {};

  // Retrieve the sum for each expense type
  for (String expenseType in expenseTypes) {
    double totalAmount = await getSumByExpenseType(expenseType);
    dataMap[expenseType] = totalAmount;
  }

  return dataMap;
}

class MyPieChart extends StatefulWidget {
  @override
  State<MyPieChart> createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {

  @override
  void initState() {
    super.initState();
  fetchExpenseData();
  }


  final Map<String, Color> expenseColors = {
    'Food': Colors.green,
    'Lorry Service': Colors.blue,
    'Tyre': Colors.red,
    'Fast tag/Tole': Colors.orange,
  };

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: fetchExpenseData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        Map<String, double> dataMap = snapshot.data!;

        return Scaffold(
            appBar: const CustomAppBarcolor(
              height: 185,
              title: '',
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.add_circle_outline_rounded,
                                color: white,
                              ),
                              Text(
                                'Income',
                                style: TextStyle(
                                    color: white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.currency_rupee,
                                color: white,
                              ),
                              Text(
                                '100',
                                style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.remove_circle_outline,
                                color: white,
                              ),
                              Text(
                                'Expense',
                                style: TextStyle(
                                    color: white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.currency_rupee,
                                color: white,
                              ),
                              Text(
                                '28,100',
                                style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              RotatedBox(
                                quarterTurns: 5,
                                child: Icon(
                                  Icons.pause_circle_outline_outlined,
                                  color: white,
                                ),
                              ),
                              Text(
                                'Balance',
                                style: TextStyle(
                                    color: white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.currency_rupee,
                                color: white,
                              ),
                              Text(
                                '-27,100',
                                style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                // Expanded Row to contain Pie Chart and Legend
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      // Pie Chart
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 40, right: 16.0, left: 16.0, bottom: 16.0),
                          child: PieChart(
                            PieChartData(
                              sections: dataMap.entries.map((entry) {
                                Color color =
                                    expenseColors[entry.key] ?? Colors.grey;
                                return PieChartSectionData(
                                  value: entry.value,
                                  title: "",
                                  color: color,
                                  radius: 60,
                                  titleStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                );
                              }).toList(),
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0,
                              centerSpaceRadius: 0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      // Legend on the Right
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 25, right: 16.0, left: 16.0, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: dataMap.entries.map((entry) {
                              Color color =
                                  expenseColors[entry.key] ?? Colors.grey;
                              return Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: color,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${entry.key}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 10,
                    )),
                const Padding(
                  padding: EdgeInsets.only(right: 120),
                  child: Text(
                    'Category wise Summary',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500, color: grey),
                  ),
                ),
                // List View with Details at the Bottom
                Expanded(
                  flex: 6,
                  child: ListView(
                    children: dataMap.entries.map((entry) {
                      Color color = expenseColors[entry.key] ?? Colors.grey;

                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: color.withOpacity(0.7),
                          ),
                          child: Container(
                            child: ListTile(
                              title: Text(entry.key,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: white)),
                              trailing: Text(
                                '₹${entry.value.toStringAsFixed(2)}',
                                style:
                                    const TextStyle(fontSize: 14, color: white),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
