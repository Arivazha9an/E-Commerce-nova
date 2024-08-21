import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/retrieve/fuelretrieve.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombuttom%20outlined.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextformwithicon.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BFuel extends StatefulWidget {
  const BFuel({super.key});

  @override
  State<BFuel> createState() => _FuelState();
}

class _FuelState extends State<BFuel> {
  final TextEditingController _datepickController = TextEditingController();
  var _startKmcontroller = TextEditingController();
  var _priceontroller = TextEditingController();
  var _literscontroller = TextEditingController();
  var _placecontroller = TextEditingController();
  var _endKMcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {

  void _fetchData(){
    
  }



    void _saveData() {
      if (_datepickController.text.isEmpty ||
          _startKmcontroller.text.isEmpty ||
          _priceontroller.text.isEmpty ||
          _literscontroller.text.isEmpty ||
          _placecontroller.text.isEmpty ||
          _endKMcontroller.text.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title:const  Text('Error'),
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
          FirebaseFirestore.instance.collection('bharthbenzrefuel').add({
            'date': _datepickController.text,
            'Start KM': _startKmcontroller.text,
            'Price': _priceontroller.text,
            'Liter': _literscontroller.text,
            'Place': _placecontroller.text,
            'End Km': _endKMcontroller.text
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
      appBar: CustomAppBar(title: 'Refuel Detail'),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
                            child: Text('Start Km')),
                      ),
                      CustomTextFormFieldIcon(
                        width: 320,
                        controller: _startKmcontroller,
                        hintText: 'Type',
                        labeltext: '',
                        keyboardType: TextInputType.number,
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
                            child: Text('Price')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _priceontroller,
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
                        controller: _literscontroller,
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
                        controller: _placecontroller,
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
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('End Km')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: w * 0.044),
                        child: CustomTextFormFieldIcon(
                          width: 320,
                          controller: _endKMcontroller,
                          hintText: 'Type',
                          labeltext: '',
                          keyboardType: TextInputType.number,
                          prefixicon: Icon(Icons.share_location_sharp),
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
                        MaterialPageRoute(
                            builder: (context) =>  Fuelretrieve()),
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
