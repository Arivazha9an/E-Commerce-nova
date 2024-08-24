import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customcolorappbar.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPieChartUI extends StatefulWidget {

  @override
  State<MyPieChartUI> createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChartUI> {
  Map<String, double> dataMap = {};
  FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<List<ExpenseData>> fetchData() async {
    List<ExpenseData> expenseDataList = [];

    // Retrieve data from the first collection
    QuerySnapshot querySnapshot1 =
        await firestore.collection('bharathbenzexpensedetail').get();
    expenseDataList.addAll(querySnapshot1.docs
        .map((doc) => ExpenseData.fromJson(doc.data() as Map<String, dynamic>))
        .toList());

    // Retrieve data from the second collection
    QuerySnapshot querySnapshot2 =
        await firestore.collection('bharathbenzexpensedetail2').get();
    expenseDataList.addAll(querySnapshot2.docs
        .map((doc) => ExpenseData.fromJson(doc.data() as Map<String, dynamic>))
        .toList());

    // Retrieve data from the third collection
    QuerySnapshot querySnapshot3 =
        await firestore.collection('taurusexpensedetail').get();
    expenseDataList.addAll(querySnapshot3.docs
        .map((doc) => ExpenseData.fromJson(doc.data()as Map<String,dynamic>))
        .toList());

    return expenseDataList;
  }

  Map<String, double> groupDataByExpenseType(
      List<ExpenseData> expenseDataList) {
    Map<String, double> groupedData = {
      "Food": 0,
      "Family": 0,
      "Shopping": 0,
      "Transportation": 0
    };

    for (ExpenseData expenseData in expenseDataList) {
      String expenseType = expenseData.expenseType;
      double amount = expenseData.amount;

      if (groupedData.containsKey(expenseType)) {
        groupedData[expenseType] = groupedData[expenseType]! + amount;
      }
    }

    return groupedData;
  }
  Future<void> displayPieChart() async {
    List<ExpenseData> expenseDataList = await fetchData();
    Map<String, double> groupedData = groupDataByExpenseType(expenseDataList);

    setState(() {
      dataMap = groupedData;
    });
  }

  @override
  void initState() {
    super.initState();
    displayPieChart();
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, double> dataMap = {
    //   "Food & Drink": 100,
    //   "Family": 3700,
    //   "Shopping": 24000,
    //   "Transportation": 200,
    //   "Donation": 50,
    // };

    List<Color> colorList = [
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.blue,
      Colors.red
    ];

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PieChart(
                
                dataMap: dataMap,
                chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: false, showChartValues: false),
                chartType: ChartType.disc,
                legendOptions: const LegendOptions(showLegends: true),
                //centerText: "₹28,200",
                chartRadius: 150,
                animationDuration: const Duration(milliseconds: 2500),
                colorList: colorList,
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 22,
                  ),
                  Text(
                    'Category wise Summary',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500, color: grey),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dataMap.length,
                itemBuilder: (context, index) {
                  String category = dataMap.keys.elementAt(index);
                  double value = dataMap[category]!;
                  Color color =
                      colorList[index]; // Assign color from the colorList
        
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: color.withOpacity(0.7),
                      ),
                      child: Container(
                        child: ListTile(
                          title: Text(category,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: white)),
                          trailing: Text(
                            '₹${value.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 14, color: white),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ExpenseData {
  String expenseType;
  double amount;

  ExpenseData({required this.expenseType, required this.amount});

  factory ExpenseData.fromJson(Map<String, dynamic> json) {
    return ExpenseData(
      expenseType: json['ExpenseType'],
      amount: json['Amount'].toDouble(),
    );
  }
}

