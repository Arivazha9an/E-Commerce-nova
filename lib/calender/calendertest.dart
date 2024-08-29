import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Map<DateTime, List> _events = {};
  late CalendarFormat _calendarFormat;
  DateTime _selectedDay = DateTime.now();
  List _selectedEvents = [];
    DateTime _focusedDay = DateTime.now();
  DateTime _firstDay = DateTime.utc(2020, 1, 1);
  DateTime _lastDay = DateTime.utc(2030, 12, 31);


  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _fetchEvents();
  }
  save(){
    FirebaseFirestore.instance.collection('events').add({
      'title': 'Independence Day',
      'date': Timestamp.fromDate(DateTime(2024, 8, 15)),
    });
  }

  Future<void> _fetchEvents() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('events').get();

    setState(() {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        DateTime date = DateTime.parse(data['date']);
        if (_events[date] == null) _events[date] = [];
        _events[date]?.add(data['title']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Calendar')),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: _firstDay,
            lastDay: _lastDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _selectedEvents = _events[selectedDay] ?? [];
              });
            },
            eventLoader: (day) {
              return _events[day] ?? [];
            },
            calendarStyle: CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          ..._selectedEvents.map((event) => ListTile(
                title: Text(event),
              )),
              TextButton(onPressed:(){ save();}, child: Text('Hi'))
        ],
       
      ),
    );
  }
}
