import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:e_commerce/widgets/customtextformwithicon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateFormService extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> data;

  const UpdateFormService({super.key, required this.docId, required this.data});

  @override
  State<UpdateFormService> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateFormService> {
  // Define the controllers at the class level
  late TextEditingController dateController;
  late TextEditingController serviceTypeController;
  late TextEditingController servicePlaceController;
  late TextEditingController contactController;
  late TextEditingController amountController;
  late TextEditingController KmridingController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with data from Firestore
    dateController = TextEditingController(text: widget.data['date'] ?? '');
    serviceTypeController =
        TextEditingController(text: widget.data['Service'] ?? '');
    servicePlaceController = TextEditingController(text: widget.data['Service Place'] ?? '');
    contactController = TextEditingController(text: widget.data['Contact'] ?? '');
    amountController = TextEditingController(text: widget.data['Amount'] ?? '');
    KmridingController = TextEditingController(text: widget.data['KM Riding'] ?? '');
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    dateController.dispose();
    serviceTypeController.dispose();
    servicePlaceController.dispose();
    contactController.dispose();
    amountController.dispose();
    KmridingController.dispose();
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
                          child: Text('Service Type'),
                        ),
                      ),
                      CustomTextFormFieldIcon(
                        width: 320,
                        controller: serviceTypeController,
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
                            child: Text('Service Place')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: servicePlaceController,
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
                            child: Text('Contact')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller:contactController,
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
                            child: Text('Amount')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: amountController,
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
                            child: Text('Km Riding')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: w * 0.044),
                        child: CustomTextFormFieldIcon(
                          width: 320,
                          controller:KmridingController,
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
                        onTap: () {
                          // Update Firestore document with new values
                          FirebaseFirestore.instance
                              .collection('bharathbenzservices')
                              .doc(widget.docId)
                              .update({
                            'date': dateController.text,
                            'Service': serviceTypeController.text,
                            'Service Place': servicePlaceController.text,
                            'Contact':contactController.text,
                            'Amount': amountController.text,
                            'KM Riding': KmridingController.text,
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
