import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/screens/DriverPayment.dart';
import 'package:e_commerce/screens/calender.dart';
import 'DateWiseExpense.dart';
import 'IncomeExpense.dart';
import 'VehicleList.dart';
import 'package:flutter/material.dart';



class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const VehicleList(),
    const IncomeExpense(),
    CalendarWithNumbers(),
    const Driverpayment(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                // color: grey,
              ),
              label: '',
              backgroundColor: lightorange),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                // color: grey,
              ),
              label: '',
              backgroundColor: lightorange),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month,
                //color: grey,
              ),
              label: '',
              backgroundColor: lightorange),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.wallet,
                // color: grey,
              ),
              label: '',
              backgroundColor: lightorange),
        ],
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}





