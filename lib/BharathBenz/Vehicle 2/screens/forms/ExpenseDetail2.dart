import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/retrieve/ExpenseRetreive.dart';
import 'package:e_commerce/BharathBenz/Vehicle%202/screens/forms/retrieve/ExpenseRetreive2.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/screens/forms/retrieve/ExpenseRetreive.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombuttom%20outlined.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:flutter/material.dart';

class BExpensedetail2 extends StatefulWidget {
  const BExpensedetail2({super.key});

  @override
  State<BExpensedetail2> createState() => _ExpensedetailState();
}

class _ExpensedetailState extends State<BExpensedetail2> {
  var _toleno1controller = TextEditingController();
  var _tollpricecontroller = TextEditingController();
  var _loadmancontroller = TextEditingController();
  var _otherscontroller = TextEditingController();

  void _saveData() {
    if (_toleno1controller.text.isEmpty ||
        _tollpricecontroller.text.isEmpty ||
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
          'Toll No 1': _toleno1controller.text,
          'Toll Price': _tollpricecontroller.text,
          'Loadman': _loadmancontroller.text,
          'Others': _otherscontroller.text
        });
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
                            child: Text('Toll No 1')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _toleno1controller,
                        hintText: 'type',
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
                            child: Text('Toll Price')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _tollpricecontroller,
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
                            child: Text('Loadman')),
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
                            child: Text('Others')),
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
