import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/retrieve/loadretrieve.dart';
import 'package:e_commerce/BharathBenz/Vehicle%202/screens/forms/retrieve/loadretrieve2.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/screens/forms/retrieve/loadretrieve.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombuttom%20outlined.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:e_commerce/widgets/customtextformwithicon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BLoadDetails2 extends StatefulWidget {
  const BLoadDetails2({super.key});

  @override
  State<BLoadDetails2> createState() => _LoadDetailsState();
}

class _LoadDetailsState extends State<BLoadDetails2> {
  final TextEditingController _datepickController = TextEditingController();

  var _startpointcontroller = TextEditingController();
  var _loadpointcontroller = TextEditingController();
  var _droppointcontroller = TextEditingController();
  var _nooftonscontroller = TextEditingController();
  var _loadamountcontroller = TextEditingController();
  var _deliveryamountcontroller = TextEditingController();
  var _customernamecontroller = TextEditingController();
  var _customernocontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void _saveData() {
      if (_datepickController.text.isEmpty||
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
          FirebaseFirestore.instance.collection('bharathbenzloaddetail2').add({
            'Date':_datepickController.text,
            'Start Point': _startpointcontroller.text,
            'Load Point': _loadpointcontroller.text,
            'Drop Point': _droppointcontroller.text,
            'No Of Tons / Units': _nooftonscontroller.text,
            'Load Amount': _loadamountcontroller.text,
            'Delivery Amount': _deliveryamountcontroller.text,
            'Customer Name': _customernamecontroller.text,
            'Customer Number': _customernocontroller.text
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
      appBar: CustomAppBar(title: 'Load Detail'),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: w * 0.041,
            ),
            Padding(
              padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        MaterialPageRoute(builder: (context) => BLoadretrieve2()),
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
