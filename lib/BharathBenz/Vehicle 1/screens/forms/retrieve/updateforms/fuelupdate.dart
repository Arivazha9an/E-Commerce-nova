import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:e_commerce/widgets/customtextformwithicon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateForm extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> data;

  const UpdateForm({super.key, required this.docId, required this.data});

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  // Define the controllers at the class level
  late TextEditingController dateController;
  late TextEditingController startKmController;
  late TextEditingController priceController;
  late TextEditingController literController;
  late TextEditingController placeController;
  late TextEditingController endKmController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with data from Firestore
    dateController = TextEditingController(text: widget.data['date'] ?? '');
    startKmController =
        TextEditingController(text: widget.data['Start KM'] ?? '');
    priceController = TextEditingController(text: widget.data['Price'] ?? '');
    literController = TextEditingController(text: widget.data['Liter'] ?? '');
    placeController = TextEditingController(text: widget.data['Place'] ?? '');
    endKmController = TextEditingController(text: widget.data['End Km'] ?? '');
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    dateController.dispose();
    startKmController.dispose();
    priceController.dispose();
    literController.dispose();
    placeController.dispose();
    endKmController.dispose();
    super.dispose();
  }

  DateTime? _parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
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
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: CustomAppBar(title: 'Update Refuel Data', isGoBack: true),
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
                          bottom: w * 0.02,
                        ),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Date'),
                        ),
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
                            ),
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
                              child: const Icon(Icons.calendar_month),
                            ),
                          ),
                        ),
                      ),
                      // Other input fields go here
                      Padding(
                        padding: EdgeInsets.only(
                          top: w * 0.03,
                          right: w * 0.03,
                          left: w * 0.025,
                          bottom: w * 0.02,
                        ),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Start Km'),
                        ),
                      ),
                      CustomTextFormFieldIcon(
                        width: 320,
                        controller: startKmController,
                        hintText: 'Type',
                        labeltext: '',
                        keyboardType: TextInputType.number,
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
                            child: Text('Price')),
                      ),
                        CustomTextFormField(
                        width: 320,
                        controller: priceController,
                        hintText: 'Type',
                        labeltext: 'Type',
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
                            child: Text('Liters')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: literController,
                        hintText: 'Type',
                        labeltext: 'Type',
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
                            child: Text('Place')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: placeController,
                        hintText: 'Type',
                        labeltext: 'Type',
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
                            child: Text('End Km')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: w * 0.044),
                        child: CustomTextFormFieldIcon(
                          width: 320,
                          controller: endKmController,
                          hintText: 'Type',
                          labeltext: '',
                          keyboardType: TextInputType.number,
                          prefixicon: const Icon(Icons.share_location_sharp),
                        ),
                      ),
                      
                      // Other fields with similar padding and input
                      const SizedBox(height: 20),
                      CustomTextButton(
                        width: 150,
                        title: 'Save Changes',
                        background: orange,
                        textColor: white,
                        fontSize: 18,
                        onTap:                        
                         () {
                          // Update Firestore document with new values
                          FirebaseFirestore.instance
                              .collection('bharthbenzrefuel')
                              .doc(widget.docId)
                              .update({
                            'date': dateController.text,
                            'Start KM': startKmController.text,
                            'Price': priceController.text,
                            'Liter': literController.text,
                            'Place': placeController.text,
                            'End Km': endKmController.text,
                          }).then((_) {
                            Navigator.pop(context); // Go back after updating
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
