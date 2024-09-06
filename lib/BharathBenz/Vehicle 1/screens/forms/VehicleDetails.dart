import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/retrieve/vehicleretrieve.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombuttom%20outlined.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class BVehicleDetails extends StatefulWidget {
  const BVehicleDetails({super.key});

  @override
  State<BVehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<BVehicleDetails> {
  
  var _vehiclecondition = TextEditingController();
  var _regnocontroller = TextEditingController();
  var _brandcontroller = TextEditingController();
  var _lorrycontroller = TextEditingController();
  var _modelcontroller = TextEditingController();
  var _buildyearcontroller = TextEditingController();
  final TextEditingController _dropController = TextEditingController();
  List<String> _items = []; // List to hold Firestore data
  String? _selectedItemvehicle; // Variable to hold the selected item
  @override
  void initState() {
    super.initState();
    _fetchItems(); // Fetch items when the widget is initialized
  }

  void clear() {
    
   _vehiclecondition.clear();
    _regnocontroller.clear();
    _brandcontroller.clear();
    _lorrycontroller.clear();
    _modelcontroller.clear();
   _buildyearcontroller.clear();
    _dropController.clear();
  }

  // Function to fetch data from Firestore
  Future<void> _fetchItems() async {
    try {
      // Fetch data from Firestore (replace 'collectionName' and 'fieldName' with your actual Firestore collection and field)
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('AddVehicles').get();

      // Extract data from documents and convert to a list of strings
      List<String> items =
          snapshot.docs.map((doc) => doc['Vehicle Number'].toString()).toList();

      setState(() {
        _items = items; // Update the state with fetched items
      });
    } catch (e) {
      print('Error fetching data from Firestore: $e'); // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    void _saveData() async {
      if (_dropController.text.isEmpty ||
         _vehiclecondition.text.isEmpty ||
          _regnocontroller.text.isEmpty ||
          _brandcontroller.text.isEmpty ||
          _lorrycontroller.text.isEmpty ||
          _modelcontroller.text.isEmpty ||
          _buildyearcontroller.text.isEmpty) {
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
          await FirebaseFirestore.instance.collection('bharathbenzvehicledetail').add({
            'vehiclenumber': _dropController.text,
              'Vehicle Condition': _vehiclecondition.text,
            'Registration Number': _regnocontroller.text,
            'Brand': _brandcontroller.text,
            'Lorry': _lorrycontroller.text,
            'Model': _modelcontroller.text,
            'Build Year': _buildyearcontroller.text
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
    }

 
    var w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Refuel Detail'),
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
                            child: Text('Vehicle Condition')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _vehiclecondition,
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
                            child: Text('Registration No')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _regnocontroller,
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
                            child: Text('Brand')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _brandcontroller,
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
                            child: Text('lorry')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _lorrycontroller,
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
                            child: Text('Model')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _modelcontroller,
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
                            child: Text('Build Year')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: w * 0.044),
                        child: CustomTextFormField(
                          width: 320,
                          controller: _buildyearcontroller,
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
