import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customcolorappbar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarWithNumbers extends StatefulWidget {
  @override
  _CalendarWithNumbersState createState() => _CalendarWithNumbersState();
}

class _CalendarWithNumbersState extends State<CalendarWithNumbers> {
  Map<DateTime, Map<String, int>> _events = {};

  @override
  void initState() {
    super.initState();
    _fetchDataFromFirebase();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarcolor(
        height: 185,
        title: '',
        child: Column(
          children: [
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              
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
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      _events[date]?['Delivery Amount']?.toString() ?? '-',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: DateTime.now(),
      ),
    );
  }
}
