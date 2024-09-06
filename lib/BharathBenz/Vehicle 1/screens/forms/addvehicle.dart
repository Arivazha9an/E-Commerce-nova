import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/retrieve/PUCretrieve.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/select/vehicleselect.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/screens/forms/VehicleDetails.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombuttom%20outlined.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Addvehicle extends StatefulWidget {
  const Addvehicle({super.key});

  @override
  State<Addvehicle> createState() => _AddvehicleState();
}

class _AddvehicleState extends State<Addvehicle> {
  var _vehiclenamecontroller = TextEditingController();
  var _vehiclenumbercontroller = TextEditingController();
  clear(){
    _vehiclenamecontroller.clear();
    _vehiclenumbercontroller.clear();
  }

  void _saveData() async {
    if (_vehiclenamecontroller.text.isEmpty ||
        _vehiclenumbercontroller.text.isEmpty) {
      // Show error dialog if fields are empty
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
    }

    try {
      // Check if the vehicle number already exists
      var querySnapshot = await FirebaseFirestore.instance
          .collection('AddVehicles')
          .where('Vehicle Number', isEqualTo: _vehiclenumbercontroller.text)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Show error dialog if vehicle number already exists
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('This vehicle number already exists.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      // Save data to Firestore
      await FirebaseFirestore.instance.collection('AddVehicles').add({
        'Vehicle Name': _vehiclenamecontroller.text,
        'Vehicle Number': _vehiclenumbercontroller.text,
      });

      // Show success toast
      Fluttertoast.showToast(
        msg: "Vehicle added successfully.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Navigate back to the previous page after a delay
      Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context));
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


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Vehicle'),
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
                            child: Text('Vehicle Name')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _vehiclenamecontroller,
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
                            child: Text('Vehicle Number')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _vehiclenumbercontroller,
                        hintText: 'Type',
                        labeltext: '',
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: w * 0.05,
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
