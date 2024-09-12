import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:e_commerce/widgets/customtextformwithicon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateFormDispatch extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> data;

  const UpdateFormDispatch({super.key, required this.docId, required this.data});

  @override
  State<UpdateFormDispatch> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateFormDispatch> {
  // Define the controllers at the class level
  late TextEditingController dateController;
  late TextEditingController _startpointcontroller;
  late TextEditingController _loadpointcontroller;
  late TextEditingController _droppointcontroller;
  late TextEditingController _nooftonscontroller;
  late TextEditingController _loadamountcontroller;
  late TextEditingController _deliveryamountcontroller;
  late TextEditingController _customernamecontroller;
  late TextEditingController _customernocontroller;
  late TextEditingController _dropController;
  late String date;
  late String amount;

  List<String> _items = []; // List to hold Firestore data
  String? _selectedItemvehicle; // Variable to hold the selected item
  @override
  @override
  void initState() {
    _fetchItems();
    super.initState();
    date = widget.data['date'] ?? '';
    amount = widget.data['Delivery Amount'] ?? '';
    // Initialize controllers with data from Firestore
    _dropController = TextEditingController(text: widget.data['vehiclenumber']);
    dateController = TextEditingController(text: widget.data['date'] ?? '');
    _startpointcontroller =
        TextEditingController(text: widget.data['Start Point'] ?? '');
    _loadpointcontroller =
        TextEditingController(text: widget.data['Load Point'] ?? '');
    _droppointcontroller =
        TextEditingController(text: widget.data['Drop Point'] ?? '');
    _nooftonscontroller =
        TextEditingController(text: widget.data['No Of Tons / Units'] ?? '');
    _loadamountcontroller =
        TextEditingController(text: widget.data['Load Amount'] ?? '');
    _deliveryamountcontroller =
        TextEditingController(text: widget.data['Delivery Amount'] ?? '');
    _customernamecontroller =
        TextEditingController(text: widget.data['Customer Name'] ?? '');
    _customernocontroller =
        TextEditingController(text: widget.data['Customer Number'] ?? '');
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _dropController.dispose();
    dateController.dispose();
    _startpointcontroller.dispose();
    _loadpointcontroller.dispose();
    _droppointcontroller.dispose();
    _nooftonscontroller.dispose();
    _loadamountcontroller.dispose();
    _deliveryamountcontroller.dispose();
    _customernamecontroller.dispose();
    _customernocontroller.dispose();
    super.dispose();
  }

  DateTime? _parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  Future<void> _fetchItems() async {
    try {
      // Fetch data from Firestore (replace 'collectionName' and 'fieldName' with your actual Firestore collection and field)
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('bharathbenzvehicledetail')
          .get();

      // Extract data from documents and convert to a list of strings
      List<String> items =
          snapshot.docs.map((doc) => doc['vehicle Number'].toString()).toList();

      setState(() {
        _items = items; // Update the state with fetched items
      });
    } catch (e) {
      print('Error fetching data from Firestore: $e'); // Handle errors
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _parseDate(dateController.text) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _storeOrUpdateData(String date, String number) async {
    if (_dropController.text.isEmpty ||
        dateController.text.isEmpty ||
        _startpointcontroller.text.isEmpty ||
        _loadpointcontroller.text.isEmpty ||
        _droppointcontroller.text.isEmpty ||
        _nooftonscontroller.text.isEmpty ||
        _loadamountcontroller.text.isEmpty ||
        _deliveryamountcontroller.text.isEmpty ||
        _customernamecontroller.text.isEmpty ||
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

  // expense logic for calender
  Future<void> updateOrDeleteByDate(String date, String value) async {
    // Reference to Firestore collection
    CollectionReference collection = FirebaseFirestore.instance
        .collection('CalendarAppointmentCollectionIncome');

    try {
      // Query Firestore for a document with the matching date
      QuerySnapshot querySnapshot =
          await collection.where('StartTime', isEqualTo: date).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Document exists, get the first matching document
        DocumentSnapshot doc = querySnapshot.docs.first;
        int currentBalance = int.tryParse(doc['Subject'] ?? '0') ?? 0;
        int subtractionValue = int.tryParse(value) ?? 0;

        // Calculate the new balance
        int newBalance = currentBalance - subtractionValue;

        if (newBalance <= 0) {
          // If the new balance is zero or less, delete the document
          await doc.reference.delete();
          print('Document deleted as balance reached zero.');
        } else {
          // Otherwise, update the document with the new balance
          await doc.reference.update({'Subject': newBalance.toString()});
          print('Document updated with new balance: $newBalance');
        }
      }
    } catch (e) {
      // Handle errors (e.g., network issues, permission errors)
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Update Load Data', isGoBack: true),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: orange, width: w * 0.005),
                ),
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
                              borderSide: const BorderSide(color: orange),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: black),
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
                          controller: dateController,
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
                        width: 320,
                        controller: _startpointcontroller,
                        hintText: 'City/Location',
                        labeltext: '',
                        keyboardType: TextInputType.name,
                        prefixicon: Icon(Icons.share_location_sharp),
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
                        prefixicon: Icon(Icons.share_location_sharp),
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
                        prefixicon: Icon(Icons.share_location_sharp),
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

            // Other fields with similar padding and input
            const SizedBox(height: 20),
            CustomTextButton(
              width: 150,
              title: 'Update',
              background: orange,
              textColor: white,
              fontSize: 18,
              onTap: () async {
                if (date.isNotEmpty && amount.isNotEmpty) {
                  // Correctly call the function
                  await _storeOrUpdateData(
                      dateController.text, _deliveryamountcontroller.text);
                } else {
                  print('Error: Date or Amount is missing or not a string.');
                  // Handle the missing or incorrect type data
                }
                if (date.isNotEmpty && amount.isNotEmpty) {
                  // Correctly call the function
                  await updateOrDeleteByDate(date, amount);
                } else {
                  print('Error: Date or Amount is missing or not a string.');
                  // Handle the missing or incorrect type data
                }
                // Update Firestore document with new values
                FirebaseFirestore.instance
                    .collection('taurusdispatch')
                    .doc(widget.docId)
                    .update({
                  'vehiclenumber': _dropController.text,
                  'date': dateController.text,
                  'Start Point': _startpointcontroller.text,
                  'Load Point': _loadpointcontroller.text,
                  'Drop Point': _droppointcontroller.text,
                  'No Of Tons / Units': _nooftonscontroller.text,
                  'Load Amount': _loadamountcontroller.text,
                  'Delivery Amount': _deliveryamountcontroller.text,
                  'Customer Name': _customernamecontroller.text,
                  'Customer Number': _customernocontroller.text
                }).then((_) {
                  Navigator.pop(context); // Go back after updating
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
