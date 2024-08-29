import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';



class LoadDataFromFireStore1 extends StatefulWidget {
  @override
  LoadDataFromFireStoreState createState() => LoadDataFromFireStoreState();
}

class LoadDataFromFireStoreState extends State<LoadDataFromFireStore1> {
  MeetingDataSource? events;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isInitialLoaded = false;

  @override
  void initState() {
    super.initState();
    getDataFromFireStore().then((_) {
      setState(() {});
    });

    _firestore.collection("bharathbenzloaddetail").snapshots().listen((event) {
      _updateEvents(event, Colors.green);
    });

    _firestore.collection("bharathbenzexpensedetail").snapshots().listen((event) {
      _updateEvents(event, Colors.red);
    });
  }
    Future<void> getDataFromFireStore() async {
    try {
       final incomeSnapshots =
          await _firestore.collection("bharathbenzloaddetail").get();
      final expenseSnapshots =
          await _firestore.collection("bharathbenzexpensedetail").get();

      List<Meeting> list = [];

      // Process Income Data
      for (var doc in incomeSnapshots.docs) {
        final data =
            doc.data() as Map<String, dynamic>; // Cast to Map<String, dynamic>
        list.add(Meeting(
          eventName: data['Delivery Amount'].toString(),
          from: DateFormat('dd/MM/yyyy').parse(data['Date01']),
          to: DateFormat('dd/MM/yyyy').parse(data['Date01']),
          background: Colors.green,
          isAllDay: true,
          key: doc.id,
        ));
      }

      // Process Expense Data
      // Process Expense Data
      for (var doc in expenseSnapshots.docs) {
        final data =
            doc.data() as Map<String, dynamic>; // Cast to Map<String, dynamic>
        list.add(Meeting(
          eventName: data['Amount'].toString(),
          from: DateFormat('dd/MM/yyyy').parse(data['Date01']),
          to: DateFormat('dd/MM/yyyy').parse(data['Date01']),
          background: Colors.red,
          isAllDay: true,
          key: doc.id,
        ));
      }
      setState(() {
        events = MeetingDataSource(list);
      });
    } catch (e) {
      print('Error getting data from Firestore: $e'); // Debugging line
    }
  }


  void _updateEvents(QuerySnapshot snapshot, Color color) {
    if (!isInitialLoaded) return;

    List<Meeting> updatedEvents = [];

    snapshot.docs.forEach((doc) {
      final data =
          doc.data() as Map<String, dynamic>; // Cast to Map<String, dynamic>
      updatedEvents.add(Meeting(
        eventName: data['Amount'].toString(),
        from: DateFormat('dd/MM/yyyy').parse(data['Date01']),
        to: DateFormat('dd/MM/yyyy').parse(data['Date01']),
        background: color,
        isAllDay: true,
        key: doc.id,
      ));
    });

    setState(() {
      if (events != null) {
        events!.appointments!.addAll(updatedEvents);
        events!.notifyListeners(CalendarDataSourceAction.add, updatedEvents);
      } else {
        events = MeetingDataSource(updatedEvents);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    isInitialLoaded = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income and Expense Calendar'),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: events,
        monthViewSettings: const MonthViewSettings(
          showAgenda: true,
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from!;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to!;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay!;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName!;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background!;
  }
}

class Meeting {
  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;
  String? key;

  Meeting({
    this.eventName,
    this.from,
    this.to,
    this.background,
    this.isAllDay,
    this.key,
  });
}
