import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/screens/retrieve/loadretrieve.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombuttom%20outlined.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:e_commerce/widgets/customtextformwithicon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoadDetails extends StatefulWidget {
  const LoadDetails({super.key});

  @override
  State<LoadDetails> createState() => _LoadDetailsState();
}

class _LoadDetailsState extends State<LoadDetails> {
  DateTime? pickeddate;
  DateTime? pickeddate1;
  final TextEditingController _datepickController = TextEditingController();
  final TextEditingController _datepickController1 = TextEditingController();
  var _startpointcontroller = TextEditingController();
  var _loadpointcontroller = TextEditingController();
  var _droppointcontroller = TextEditingController();
  var _nooftonscontroller = TextEditingController();
  var _loadamountcontroller = TextEditingController();
  var _deliveryamountcontroller = TextEditingController();
  var _customernamecontroller = TextEditingController();
  var _customernocontroller = TextEditingController();
  var _startpointcontroller1 = TextEditingController();
  var _loadpointcontroller1 = TextEditingController();
  var _droppointcontroller1 = TextEditingController();
  var _nooftonscontroller1 = TextEditingController();
  var _loadamountcontroller1 = TextEditingController();
  var _deliveryamountcontroller1 = TextEditingController();
  var _customernamecontroller1 = TextEditingController();
  var _customernocontroller1 = TextEditingController();


  void _storeOrUpdateData1(String date, String number) async {
    if (_startpointcontroller.text.isEmpty ||
        _loadpointcontroller.text.isEmpty ||
        _droppointcontroller.text.isEmpty ||
        _nooftonscontroller.text.isEmpty ||
        _loadamountcontroller.text.isEmpty ||
        _deliveryamountcontroller.text.isEmpty ||
        _customernamecontroller.text.isEmpty ||
        _datepickController.text.isEmpty ||
        _customernocontroller.text.isEmpty) {
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
            .collection('CalendarAppointmentCollectionIncome');

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

  void _storeOrUpdateData2(String date, String number) async {
    if (_startpointcontroller.text.isEmpty ||
        _loadpointcontroller.text.isEmpty ||
        _droppointcontroller.text.isEmpty ||
        _nooftonscontroller.text.isEmpty ||
        _loadamountcontroller.text.isEmpty ||
        _deliveryamountcontroller.text.isEmpty ||
        _customernamecontroller.text.isEmpty ||
        _datepickController.text.isEmpty ||
        _customernocontroller.text.isEmpty) {
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
            .collection('CalendarAppointmentCollectionIncome');

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
    Future<void> _selectDate() async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2099));
      if (picked != null) {
        setState(() {
          _datepickController.text = DateFormat('dd/MM/yyy').format(picked);
          pickeddate = picked;
        });
      }
    }

    Future<void> _selectDate1() async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2099));
      if (picked != null) {
        setState(() {
          _datepickController1.text = DateFormat('dd/MM/yyy').format(picked);
          pickeddate1 = picked;
        });
      }
    }

    void _saveData() {
      if (_startpointcontroller.text.isEmpty ||
          _loadpointcontroller.text.isEmpty ||
          _droppointcontroller.text.isEmpty ||
          _nooftonscontroller.text.isEmpty ||
          _loadamountcontroller.text.isEmpty ||
          _deliveryamountcontroller.text.isEmpty ||
          _customernamecontroller.text.isEmpty ||
          _datepickController.text.isEmpty ||
          _customernocontroller.text.isEmpty ||
          _startpointcontroller1.text.isEmpty ||
          _loadpointcontroller1.text.isEmpty ||
          _droppointcontroller1.text.isEmpty ||
          _nooftonscontroller1.text.isEmpty ||
          _loadamountcontroller1.text.isEmpty ||
          _deliveryamountcontroller1.text.isEmpty ||
          _customernamecontroller1.text.isEmpty ||
          _datepickController1.text.isEmpty ||
          _customernocontroller1.text.isEmpty) {
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
          FirebaseFirestore.instance.collection('taurusloaddetail').add({
            'Date01': Timestamp.fromDate(pickeddate!),
            'Start Point': _startpointcontroller.text,
            'Load Point': _loadpointcontroller.text,
            'Drop Point': _droppointcontroller.text,
            'No Of Tons / Units': _nooftonscontroller.text,
            'Load Amount': _loadamountcontroller.text,
            'Delivery Amount': _deliveryamountcontroller.text,
            'Customer Name': _customernamecontroller.text,
            'Customer Number': _customernocontroller.text,
            'Date02': Timestamp.fromDate(pickeddate1!),
            'Start Point1': _startpointcontroller1.text,
            'Load Point1': _loadpointcontroller1.text,
            'Drop Point1': _droppointcontroller1.text,
            'No Of Tons / Units1': _nooftonscontroller1.text,
            'Load Amount1': _loadamountcontroller1.text,
            'Delivery Amount1': _deliveryamountcontroller1.text,
            'Customer Name1': _customernamecontroller1.text,
            'Customer Number1': _customernocontroller1.text,
          });
        } on FirebaseException catch (e) {
          print('Failed with error code: ${e.code}');
          print(e.message);
        }
      }
    }

    var w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Load Detail'),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: w * 0.041,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  border: Border.all(color: grey, width: w * 0.0025)),
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: Text('Load Dispatch Details'),
              ),
            ),
            SizedBox(
              height: w * 0.041,
            ),
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
                                borderSide: const BorderSide(color: orange),
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
                                  child: const Icon(Icons.calendar_month))),
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
                            child: Text('Start Point')),
                      ),
                      CustomTextFormFieldIcon(
                        controller: _startpointcontroller,
                        hintText: 'City/Location',
                        labeltext: '',
                        keyboardType: TextInputType.name,
                        prefixicon: const Icon(Icons.share_location_sharp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: w * 0.03,
                            right: w * 0.03,
                            left: w * 0.025,
                            bottom: w * 0.02),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Load Point')),
                      ),
                      CustomTextFormFieldIcon(
                        width: 320,
                        controller: _loadpointcontroller,
                        hintText: 'Type',
                        labeltext: '',
                        keyboardType: TextInputType.name,
                        prefixicon: const Icon(Icons.share_location_sharp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: w * 0.03,
                            right: w * 0.03,
                            left: w * 0.025,
                            bottom: w * 0.02),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Drop Point')),
                      ),
                      CustomTextFormFieldIcon(
                        width: 320,
                        controller: _droppointcontroller,
                        hintText: 'Type',
                        labeltext: 'Type',
                        keyboardType: TextInputType.name,
                        prefixicon: const Icon(Icons.share_location_sharp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: w * 0.03,
                            right: w * 0.03,
                            left: w * 0.025,
                            bottom: w * 0.02),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('No of Tons / Units')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _nooftonscontroller,
                        hintText: 'ItemWeight in Tons',
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
                            child: Text('Load Amount')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _loadamountcontroller,
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
                            child: Text('Delivery Amount')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _deliveryamountcontroller,
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
                            child: Text('Customer Name')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _customernamecontroller,
                        hintText: 'Type',
                        labeltext: '',
                        keyboardType: TextInputType.name,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: w * 0.03,
                            right: w * 0.03,
                            left: w * 0.025,
                            bottom: w * 0.02),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Customer No')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: w * 0.044),
                        child: CustomTextFormField(
                          width: 320,
                          controller: _customernocontroller,
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
              height: w * 0.11,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  border: Border.all(color: grey, width: w * 0.0025)),
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: Text('Load Return Details'),
              ),
            ),
            SizedBox(
              height: w * 0.081,
            ),
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
                          controller: _datepickController1,
                          readOnly: true,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: orange),
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
                                  onTap: _selectDate1,
                                  child: const Icon(Icons.calendar_month))),
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
                            child: Text('Start Point')),
                      ),
                      CustomTextFormFieldIcon(
                        controller: _startpointcontroller1,
                        hintText: 'City/Location',
                        labeltext: '',
                        keyboardType: TextInputType.name,
                        prefixicon: const Icon(Icons.share_location_sharp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: w * 0.03,
                            right: w * 0.03,
                            left: w * 0.025,
                            bottom: w * 0.02),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Load Point')),
                      ),
                      CustomTextFormFieldIcon(
                        width: 320,
                        controller: _loadpointcontroller1,
                        hintText: 'Type',
                        labeltext: '',
                        keyboardType: TextInputType.name,
                        prefixicon: const Icon(Icons.share_location_sharp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: w * 0.03,
                            right: w * 0.03,
                            left: w * 0.025,
                            bottom: w * 0.02),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Drop Point')),
                      ),
                      CustomTextFormFieldIcon(
                        width: 320,
                        controller: _droppointcontroller1,
                        hintText: 'Type',
                        labeltext: 'Type',
                        keyboardType: TextInputType.name,
                        prefixicon: const Icon(Icons.share_location_sharp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: w * 0.03,
                            right: w * 0.03,
                            left: w * 0.025,
                            bottom: w * 0.02),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('No of Tons / Units')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _nooftonscontroller1,
                        hintText: 'ItemWeight in Tons',
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
                            child: Text('Load Amount')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _loadamountcontroller1,
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
                            child: Text('Delivery Amount')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _deliveryamountcontroller1,
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
                            child: Text('Customer Name')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _customernamecontroller1,
                        hintText: 'Type',
                        labeltext: '',
                        keyboardType: TextInputType.name,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: w * 0.03,
                            right: w * 0.03,
                            left: w * 0.025,
                            bottom: w * 0.02),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Customer No')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: w * 0.044),
                        child: CustomTextFormField(
                          width: 320,
                          controller: _customernocontroller1,
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
                         _storeOrUpdateData1(_datepickController.text,
                            _deliveryamountcontroller.text);
                             _storeOrUpdateData2(_datepickController1.text,
                            _deliveryamountcontroller1.text);
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
                            builder: (context) => const Loadretrieve2()),
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
