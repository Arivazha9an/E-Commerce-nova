import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/screens/DriverPayment.dart';
import 'DateWiseExpense.dart';
import 'IncomeExpense.dart';
import 'VehicleList.dart';

import 'package:e_commerce/widgets/TextfieldwithButton.dart';
import 'package:e_commerce/widgets/customcolorappbar.dart';
import 'package:flutter/material.dart';

void main() => runApp(const BottomNavigationBarExampleApp());

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
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[

    // index 0 home
    const VehicleList(),

    // index 1 
    const IncomeExpense(),

    // index 2    
    const Datewiseexpense(),

    // index 3
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
