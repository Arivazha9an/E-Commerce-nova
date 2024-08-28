import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customcolorappbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarWithNumbers extends StatefulWidget {
  @override
  _CalendarWithNumbersState createState() => _CalendarWithNumbersState();
}

class _CalendarWithNumbersState extends State<CalendarWithNumbers> {
  Map<DateTime, Map<String, int>> _events = {};
  DateTime selectedDate = DateTime.now();
  final TextEditingController _datepickController = TextEditingController();
    double combinedexpense = 0.0;
  double combineincome = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchDataFromFirebase();
     incomeSum();
    expenseSum();
  }
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

  void _fetchDataFromFirebase() async {
    final QuerySnapshot minusSnapshot = await FirebaseFirestore.instance
        .collection('bharathbenzexpensedetail')
        .get();
    final QuerySnapshot plusSnapshot = await FirebaseFirestore.instance
        .collection('bharthbenzloaddetails')
        .get();

    final Map<DateTime, Map<String, int>> events = {};

    for (var doc in minusSnapshot.docs) {
      DateTime date = (doc['Date01'] as Timestamp).toDate();
      int expense = doc['Amount'];
      events[date] = {'Amount': expense, 'Delivery Amount': 0};
    }

    for (var doc in plusSnapshot.docs) {
      DateTime date = (doc['Date01'] as Timestamp).toDate();
      int Delivery = doc['Delivery Amount'];
      if (events.containsKey(date)) {
        events[date]!['Delivery Amount'] = Delivery;
      } else {
        events[date] = {'Amount': 0, 'Delivery Amount': Delivery};
      }
    }
    setState(() {
      _events = events;
    });
  }
    Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _datepickController.text = DateFormat('dd MMMM yyyy').format(picked);
        print('selected$selectedDate');
        
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarcolor(
        height: 185,
        title: '',
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextField(
              readOnly: true,
              style: const TextStyle(color: white),
              controller: _datepickController,
              decoration: InputDecoration(
                prefixIcon: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: const Icon(
                      Icons.calendar_today,
                      color: white,
                    )),
                hintText: 'Pick A Date',
                hintStyle: const TextStyle(color: white),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Row(
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
                        const Icon(
                          Icons.currency_rupee,
                          color: white,
                        ),
                        Text(
                          combineincome.toString(),
                          style: const TextStyle(
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
                    const Row(
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
                        const Icon(
                          Icons.currency_rupee,
                          color: white,
                        ),
                        Text(
                          combinedexpense.toString(),
                          style: const TextStyle(
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
                    const Row(
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
                        const Icon(
                          Icons.currency_rupee,
                          color: white,
                        ),
                        Text(
                          (combineincome-combinedexpense).toString(),
                          style: const TextStyle(
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
      body: TableCalendar(
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (_events.containsKey(date)) {
              return Positioned(
                bottom: 1,
                child: Column(
                  children: [
                    Text(
                      _events[date]?['Amount']?.toString() ?? '-',
                      style: const TextStyle(color: Colors.red),
                    ),
                    Text(
                      _events[date]?['Delivery Amount']?.toString() ?? '-',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              );
            }
            return null;
          },
        ),
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: DateTime.now(),
      ),
    );
  }
}
