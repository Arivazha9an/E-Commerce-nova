import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombuttom%20outlined.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextformwithicon.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Supplierdetails extends StatefulWidget {
  const Supplierdetails({super.key});

  @override
  State<Supplierdetails> createState() => _SupplierdetailsState();
}

class _SupplierdetailsState extends State<Supplierdetails> {
  final _namecontroller = TextEditingController();
  final _placecontroller = TextEditingController();
  final _materialcontroller = TextEditingController();
  final _paymentcontroller = TextEditingController();
  final _paidcontroller = TextEditingController();
  final _notpaidcontroller = TextEditingController();

  void _saveData() {
    if (_namecontroller.text.isEmpty ||
        _placecontroller.text.isEmpty ||
        _materialcontroller.text.isEmpty ||
        _paymentcontroller.text.isEmpty ||
        _paidcontroller.text.isEmpty ||
        _notpaidcontroller.text.isEmpty) {
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
        FirebaseFirestore.instance.collection('supplierdetails').add({
          'Name': _namecontroller.text,
          'Place': _placecontroller.text,
          'Material': _materialcontroller.text,
          'Payment': _paymentcontroller.text,
          'Paid': _paidcontroller.text,
          'Not_Paid': _notpaidcontroller.text,
          'delDate': Timestamp.now(),
        });
         Fluttertoast.showToast(
          msg: "Successfully Stored.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Navigate back to the previous page after a delay
        Future.delayed(
            const Duration(seconds: 2), () => Navigator.pop(context));
      } on FirebaseException catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Supplier Details'),
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
                            child: Text('Name')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _namecontroller,
                        hintText: '',
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
                            child: Text('place')),
                      ),
                      CustomTextFormFieldIcon(
                        width: 320,
                        controller: _placecontroller,
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
                            child: Text('Material')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _materialcontroller,
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
                            child: Text('Payment')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _paymentcontroller,
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
                            child: Text('Paid')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _paidcontroller,
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
                            child: Text('Not Paid')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: w * 0.044),
                        child: CustomTextFormFieldIcon(
                          width: 320,
                          controller: _notpaidcontroller,
                          hintText: 'Type',
                          labeltext: '',
                          keyboardType: TextInputType.number,
                          prefixicon: const Icon(Icons.share_location_sharp),
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
                    title: 'fetch',
                    width: w * 0.3,
                    background: Colors.transparent,
                    textColor: black,
                    fontSize: 20,
                    onTap: () {},
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
