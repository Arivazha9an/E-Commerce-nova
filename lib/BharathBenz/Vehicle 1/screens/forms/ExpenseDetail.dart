import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/retrieve/ExpenseRetreive.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombuttom%20outlined.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class BExpensedetail extends StatefulWidget {
  const BExpensedetail({super.key});

  @override
  State<BExpensedetail> createState() => _ExpensedetailState();
}

class _ExpensedetailState extends State<BExpensedetail> {
  final TextEditingController _datepickController = TextEditingController();
  DateTime? pickeddate;

  var _loadmancontroller = TextEditingController();
  var _otherscontroller = TextEditingController();
  var valuecontroller = TextEditingController();
  String? selectedItem;
  final TextEditingController _dropController = TextEditingController();
  List<String> _items = []; // List to hold Firestore data
  String? _selectedItemvehicle; // Variable to hold the selected item
  @override
  void initState() {
    super.initState();
    _fetchItems(); // Fetch items when the widget is initialized
  }
void clear(){
  valuecontroller.clear();
  _datepickController.clear();
  _otherscontroller.clear();
  _dropController.clear();
  _loadmancontroller.clear();
  

}
  // Function to fetch data from Firestore
  Future<void> _fetchItems() async {
    try {
      // Fetch data from Firestore (replace 'collectionName' and 'fieldName' with your actual Firestore collection and field)
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('AddVehicles').get();

      // Extract data from documents and convert to a list of strings
      List<String> items =
          snapshot.docs.map((doc) => doc['Vehicle Number'].toString()).toList();

      setState(() {
        _items = items; // Update the state with fetched items
      });
    } catch (e) {
      print('Error fetching data from Firestore: $e'); // Handle errors
    }
  }

  List<String> vehicleitems = [
    'Food',
    'Lorry Service',
    'Tyre',
    'Fast tag/Toll',
    'Others'
  ];
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2099));
    if (picked != null) {
      setState(() {
        _datepickController.text = DateFormat('dd/MM/yyyy').format(picked);
        pickeddate = picked;
      });
    }
  }

  void _saveData() {
    if (_dropController.text.isEmpty ||
        _datepickController.text.isEmpty ||
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
        FirebaseFirestore.instance.collection('bharathbenzexpensedetail').add({
          'vehiclenumber': _dropController.text,
          'Date01': Timestamp.fromDate(pickeddate!),
          'Date': _datepickController.text,
          'ExpenseType': valuecontroller.text,
          'Amount': _loadmancontroller.text,
          'Km': _otherscontroller.text
        });
         Fluttertoast.showToast(
          msg: "Successfully Stored.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
          Future.delayed(
            const Duration(seconds: 2), () => Navigator.pop(context));
      } on FirebaseException catch (e) {
        // Handle Firebase errors
        print('Failed with error code: ${e.code}');
        print(e.message);
        // Optionally show an error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to Store Data. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        // Handle any other errors
        print('Unexpected error: $e');
        // Optionally show an error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content:
                const Text('An unexpected error occurred. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _storeOrUpdateData(String date, String number) async {
    if (_dropController.text.isEmpty ||
        _datepickController.text.isEmpty ||
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
                            child: Text('Vehicle Number')),
                      ),
                      Container(
                        width: 320,
                        child: TextField(
                          controller: _dropController,
                          readOnly: true, // Make the text field read-only
                          decoration: InputDecoration(
                            labelText: 'Select Vehicle No',
                            suffixIcon: DropdownButton<String>(
                              value: _selectedItemvehicle,
                              hint: const Text('Select'),
                              icon: const Icon(Icons.arrow_drop_down),
                              items: _items.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedItemvehicle =
                                      newValue; // Update the selected item
                                  _dropController.text =
                                      newValue ?? ''; // Update the text field
                                });
                              },
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: orange),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: orange)),
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
                              items: vehicleitems.map((String vehicleitems) {
                                return DropdownMenuItem<String>(
                                  value: vehicleitems,
                                  child: Text(vehicleitems),
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
                    title: 'Clear',
                    width: w * 0.3,
                    background: Colors.transparent,
                    textColor: black,
                    fontSize: 20,
                    onTap: () {
                      clear();
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
