import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWithIncomeExpense extends StatefulWidget {
  @override
  _CalendarWithIncomeExpenseState createState() =>
      _CalendarWithIncomeExpenseState();
}

class _CalendarWithIncomeExpenseState extends State<CalendarWithIncomeExpense> {
  Map<DateTime, Map<String, double>> _events = {};
  DateTime _focusedDay = DateTime.now();
  DateTime _firstDay = DateTime.utc(2020, 1, 1);
  DateTime _lastDay = DateTime.utc(2030, 12, 31);

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Fetch Expense data from multiple collections with different field names
    _fetchExpenses(
        firestore.collection('bharathbenzloaddetail'), 'Delivery Amount');
    _fetchExpenses(
        firestore.collection('bharathbenzloaddetail1'), 'Delivery Amount');
    _fetchExpenses(
        firestore.collection('taurusloaddetail'), 'Delivery Amount');
    _fetchExpenses(firestore.collection('taurusloaddetail'), 'Delivery Amount1');

    // Fetch Income data from multiple collections with the same field name
    _fetchIncome(firestore.collection('bharathbenzexpensedetail'), 'Amount');
    _fetchIncome(firestore.collection('bharathbenzexpensedetail1'), 'Amount');
    _fetchIncome(firestore.collection('taurusexpensedetail'), 'Amount');

    setState(() {});
    
  }

  void _fetchExpenses(
      CollectionReference collection, String amountFieldName) async {
    QuerySnapshot snapshot = await collection.get();
    snapshot.docs.forEach((doc) {
      DateTime date = DateTime.parse(doc['Date']);
      double amount = doc[amountFieldName];

      if (_events[date] == null) {
        _events[date] = {'expense': 0, 'income': 0};
      }

      _events[date]!['expense'] = _events[date]!['expense']! + amount;
    });

    setState(() {});
  }

  void _fetchIncome(
      CollectionReference collection, String amountFieldName) async {
    QuerySnapshot snapshot = await collection.get();
    snapshot.docs.forEach((doc) {
      DateTime date = DateTime.parse(doc['Date']);
      double amount = doc[amountFieldName];

      if (_events[date] == null) {
        _events[date] = {'expense': 0, 'income': 0};
      }

      _events[date]!['income'] = _events[date]!['income']! + amount;
    });

    setState(() {});
  }

  List<Map<String, double>> _getEventsForDay(DateTime day) {
    return _events[day] != null ? [_events[day]!] : [];
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Income & Expense Calendar')),
      body: TableCalendar(
        focusedDay: _focusedDay,
        firstDay: _firstDay,
        lastDay: _lastDay,
        eventLoader: _getEventsForDay,
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.deepOrange,
            shape: BoxShape.circle,
          ),
        ),
        onDaySelected: (date, events) {
          // Handle day selected logic
        },
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (events.isEmpty) return const SizedBox();

            final Map<String, double> eventData =
                events.first as Map<String, double>;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //expense wass income
                  if (eventData['expense']! > 0)
                  Text(
                    '-${eventData['expense']}',
                    style: const TextStyle(color: Colors.green),
                  ),
                  // ignore: avoid_print
                 
                  // income was expense
                if (eventData['income']! > 0)
                  Text(
                    '+${eventData['income']}',
                    style: const TextStyle(color: Colors.red),
                  ),
              
              ],
            );
          },
        ),
      ),
    );
  }
}
