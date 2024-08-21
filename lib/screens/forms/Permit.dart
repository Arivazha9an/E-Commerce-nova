import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/retrieve/PermitRetrieve.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/screens/forms/retrieve/PermitRetrieve.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombuttom%20outlined.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:flutter/material.dart';

class Permit extends StatefulWidget {
  const Permit({super.key});

  @override
  State<Permit> createState() => _PermitState();
}

class _PermitState extends State<Permit> {
   var _permittypecontroller = TextEditingController();
  var _permitnocontroller = TextEditingController();
  var _expirycontroller = TextEditingController();
  var _issuecontroller = TextEditingController();
  var _permitcardcontroller = TextEditingController();

  void _saveData() {
    if (_permittypecontroller.text.isEmpty ||
        _permitnocontroller.text.isEmpty ||
        _expirycontroller.text.isEmpty ||
        _issuecontroller.text.isEmpty ||
        _permitcardcontroller.text.isEmpty) {
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
        FirebaseFirestore.instance.collection('tauruspermit').add({
          'Permit Type': _permittypecontroller.text,
          'Permit Number': _permitnocontroller.text,
          'Expiry': _expirycontroller.text,
          'Issue': _issuecontroller.text,
          'Permit Card': _permitcardcontroller.text
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
      appBar: const CustomAppBar(title: 'Permit Detail'),
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
                            child: Text('Permit Type')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _permittypecontroller,
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
                            child: Text('Permit No')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _permitnocontroller,
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
                            child: Text('Expiry')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _expirycontroller,
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
                            child: Text('Issue')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _issuecontroller,
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
                            child: Text('Permit Card')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: w * 0.044),
                        child: CustomTextFormField(
                          width: 320,
                          controller: _permitcardcontroller,
                          hintText: 'Type',
                          labeltext: '',
                          keyboardType: TextInputType.name,
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
                            builder: (context) => const Permitretrieve2()),
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
