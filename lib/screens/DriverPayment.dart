import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/BharathBenz/screens/forms/retrieve/driverpaymentretreive.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombuttom%20outlined.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Driverpayment extends StatefulWidget {
  const Driverpayment({super.key});

  @override
  State<Driverpayment> createState() => _DriverpaymentState();
}

class _DriverpaymentState extends State<Driverpayment> {
  final TextEditingController _datepickController = TextEditingController();

  var _drivernamecontroller = TextEditingController();
  var _vehiclenamecontroller = TextEditingController();
  var _salarycontroller = TextEditingController();
  var _paymentcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _saveData() {
      if (_datepickController.text.isEmpty ||
          _drivernamecontroller.text.isEmpty ||
          _vehiclenamecontroller.text.isEmpty ||
         _salarycontroller.text.isEmpty ||
           _paymentcontroller.text.isEmpty 
         ) {
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
          FirebaseFirestore.instance.collection('driverpayment').add({
          
            'Driver Name': _drivernamecontroller.text,
            'Vehicle Name': _vehiclenamecontroller.text,
            'Salary': _salarycontroller.text,
            'Payment': _paymentcontroller.text,
            'date': _datepickController.text
          });
        } on FirebaseException catch (e) {
          print('Failed with error code: ${e.code}');
          print(e.message);
        }
      }
    }

    Future<void> _selectDate() async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2099));
      if (picked != null) {
        setState(() {
          _datepickController.text = DateFormat('yyyy-MM-dd').format(picked);
        });
      }
    }

    var w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Driver Payment'),
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
                            child: Text('Driver Name')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _drivernamecontroller,
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
                            child: Text('Vehicle Name')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _vehiclenamecontroller,
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
                            child: Text('Salary')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _salarycontroller,
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
                            child: Text('Payment')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _paymentcontroller,
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
                            child: Text('Date')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: w * 0.044),
                        child: Container(
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
                                child: Icon(Icons.calendar_month),
                              ),
                            ),
                          ),
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
                      onTap: () {_saveData();}),
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
                            builder: (context) =>Driverpaymentretreive()),
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
