import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce/BharathBenz/Vehicle%202/screens/forms/retrieve/ExpenseRetreive2.dart';
import 'package:e_commerce/constants/colors.dart';

import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombuttom%20outlined.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BExpensedetail2 extends StatefulWidget {
  const BExpensedetail2({super.key});

  @override
  State<BExpensedetail2> createState() => _ExpensedetailState();
}

class _ExpensedetailState extends State<BExpensedetail2> {
  final TextEditingController _datepickController = TextEditingController();
DateTime? pickeddate;
  var _loadmancontroller = TextEditingController();
  var _otherscontroller = TextEditingController();
  var valuecontroller = TextEditingController();
  String? selectedItem; 
  List<String> items = ['Food', 'Lorry Service', 'Tyre', 'Fast tag/Toll'];
   Future<void> _selectDate() async {
  DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2099));
    if (picked != null) {
      setState(() {
        _datepickController.text = DateFormat('dd/MM/yyyy').format(picked);
        pickeddate =  picked;
      });
    }
  }
  void _saveData() {
    if (_datepickController.text.isEmpty ||
        valuecontroller.text.isEmpty ||
        _loadmancontroller.text.isEmpty ||
        _otherscontroller.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill all fields.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    } else {
      try {
        FirebaseFirestore.instance.collection('bharathbenzexpensedetail2').add({
          'Date01': Timestamp.fromDate(pickeddate!),
          'Date': _datepickController.text,
          'ExpenseType': valuecontroller.text,
          'Amount': _loadmancontroller.text,
          'Km': _otherscontroller.text
        });
      } on FirebaseException catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
    }
  }
   void _storeOrUpdateData(String date, String number) async {
    if (_datepickController.text.isEmpty ||
        valuecontroller.text.isEmpty ||
        _loadmancontroller.text.isEmpty ||
        _otherscontroller.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill all fields.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    } else {
      try {
        // Reference to the Firestore collection
        final collectionRef = FirebaseFirestore.instance
            .collection('CalendarAppointmentCollectionExpense');

        // Convert the number from String to int, ensuring no null or invalid conversion
        int parsedNumber = int.tryParse(number) ?? 0;

        // Query to check if a document with the same date exists
        final querySnapshot =
            await collectionRef.where('StartTime', isEqualTo: date).get();

        if (querySnapshot.docs.isNotEmpty) {
          // Document exists, update the number
          final docRef = querySnapshot.docs.first.reference;
          // Retrieve the existing number, ensuring it's treated as int
          final existingNumberString =
              (querySnapshot.docs.first.data()['Subject'] ?? 0) as String;
          int existingNumber = int.tryParse(existingNumberString) ?? 0;

          // Sum the existing number with the new number
          final newNumber = existingNumber + parsedNumber;

          // Update the document with the new summed number
          await docRef.update({'Subject': newNumber.toString()});
          print('Document updated: $date with new number: $newNumber');
        } else {
          // Document does not exist, create a new one
          await collectionRef
              .add({'StartTime': date, 'Subject': parsedNumber.toString()});
          print(
              'New document created: $date with number: ${parsedNumber.toString()}');
        }
      } catch (e) {
        // Handle errors
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update data: $e')),
        );
      }
    }
  }
  


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Expense Detail'),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: orange, width: w * 0.005)),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: w * 0.03,
                            right: w * 0.03,
                            left: w * 0.025,
                            bottom: w * 0.02),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Date')),
                      ),
                      Container(
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(-4, 4),
                              blurRadius: 18,
                              spreadRadius: 0,
                              color: Color(0x17000000),
                            )
                          ],
                        ),
                        child: TextFormField(
                          controller: _datepickController,
                          readOnly: true,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: orange),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              hintText: 'Choose Date',
                              prefixIcon: GestureDetector(
                                  onTap: _selectDate,
                                  child: Icon(Icons.calendar_month))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: w * 0.03,
                            right: w * 0.03,
                            left: w * 0.025,
                            bottom: w * 0.02),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Expense Type')),
                      ),
                      Container(
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(-4, 4),
                              blurRadius: 18,
                              spreadRadius: 0,
                              color: Color(0x17000000),
                            )
                          ],
                        ),
                        child: TextFormField(
                          controller: valuecontroller,
                          readOnly: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: orange),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            hintText: '',
                            suffixIcon: DropdownButton<String>(
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedItem = newValue;
                                  valuecontroller.text = newValue!;
                                });
                              },
                              items: items.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: w * 0.03,
                            right: w * 0.03,
                            left: w * 0.025,
                            bottom: w * 0.02),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Amount')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _loadmancontroller,
                        hintText: 'Type',
                        labeltext: '',
                        keyboardType: TextInputType.number,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: w * 0.03,
                            right: w * 0.03,
                            left: w * 0.025,
                            bottom: w * 0.02),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Km Reading')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: w * 0.04),
                        child: CustomTextFormField(
                          width: 320,
                          controller: _otherscontroller,
                          hintText: 'Type',
                          labeltext: '',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: w * 0.07,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: w * 0.1),
                  child: CustomTextButton(
                      title: 'Save',
                      width: w * 0.3,
                      background: orange,
                      textColor: white,
                      fontSize: 20,
                      onTap: () {
                        _saveData();
                       _storeOrUpdateData(
                            _datepickController.text, _loadmancontroller.text);
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.15),
                  child: CustomTextButtonOut(
                    title: 'Fetch',
                    width: w * 0.3,
                    background: Colors.transparent,
                    textColor: black,
                    fontSize: 20,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BExpenseretreieve2()),
                      );
                    },
                    color: black,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
