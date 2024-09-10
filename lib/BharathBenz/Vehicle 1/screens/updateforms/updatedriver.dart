import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:e_commerce/widgets/customtextformwithicon.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateFormDriver extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> data;

  const UpdateFormDriver({super.key, required this.docId, required this.data});

  @override
  State<UpdateFormDriver> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateFormDriver> {
  // Define the controllers at the class level

  late TextEditingController _namecontroller;
 // late TextEditingController _imgnamecontroller;
   var _imgnamecontroller = TextEditingController();
  late TextEditingController _placecontroller;
  late TextEditingController _bloddgroupcontroller;
  late TextEditingController _expirecontroller;
  late TextEditingController _insuranceamountcontroller;
  late TextEditingController _dropController;
   File imageFile = File('');
  List<String> _items = []; // List to hold Firestore data
  String? _selectedItemvehicle; // Variable to hold the selected item
  @override
  @override
  void initState() {
    _fetchItems();
    super.initState();
    // Initialize controllers with data from Firestore

    _namecontroller =
        TextEditingController(text: widget.data['Name'] ?? '');

   // _imgnamecontroller =
     //   TextEditingController(text: widget.data['vehicle Number']);

    _placecontroller = TextEditingController(text: widget.data['Place'] ?? '');
    _bloddgroupcontroller = TextEditingController(text: widget.data['Blooad Group'] ?? '');
    _expirecontroller = TextEditingController(text: widget.data['Expires'] ?? '');
    _insuranceamountcontroller =
        TextEditingController(text: widget.data['Insurance Amount'] ?? '');
        _dropController =
        TextEditingController(text: widget.data['vehiclenumber'] ?? '');
  }
  Future<void> _fetchItems() async {
    try {
      // Fetch data from Firestore (replace 'collectionName' and 'fieldName' with your actual Firestore collection and field)
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('bharathbenzvehicledetail')
          .get();

      // Extract data from documents and convert to a list of strings
      List<String> items =
          snapshot.docs.map((doc) => doc['vehicle Number'].toString()).toList();

      setState(() {
        _items = items; // Update the state with fetched items
      });
    } catch (e) {
      print('Error fetching data from Firestore: $e'); // Handle errors
    }
  }
  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    
    _namecontroller.dispose();
   //_imgnamecontroller.dispose();
   _placecontroller.dispose();
   _bloddgroupcontroller.dispose();
   _expirecontroller.dispose();
   _insuranceamountcontroller.dispose();
   _dropController.dispose();
    super.dispose();
  }
   
  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        _imgnamecontroller.text = imageFile.path.split('/').last;
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> uploadImage(File imageFile) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('bharathbenz_driver')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

    firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);

    firebase_storage.TaskSnapshot snapshot =
        await uploadTask.whenComplete(() => null);
    return await snapshot.ref.getDownloadURL();
  }

  DateTime? _parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Update Driver Data', isGoBack: true),
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
                            child: Text('Name')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _namecontroller,
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
                            child: Text('Place')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _placecontroller,
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
                            child: Text('Blood Group')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _bloddgroupcontroller,
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
                            child: Text('Photo')),
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
                          // initialValue: _imageName ?? '',
                          controller: _imgnamecontroller,

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
                              hintText: 'Pick An Image',
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    _pickImage();
                                  },
                                  child: const Icon(Icons.image))),
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
                            child: Text('Expires')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _expirecontroller,
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
                            child: Text('Insurance Amount')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: w * 0.044),
                        child: CustomTextFormField(
                          width: 320,
                          controller: _insuranceamountcontroller,
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
            // Other fields with similar padding and input
            const SizedBox(height: 20),
            CustomTextButton(
              width: 150,
              title: 'Update',
              background: orange,
              textColor: white,
              fontSize: 18,
              onTap: ()async {
                String imageUrl = await uploadImage(imageFile);
                // Update Firestore document with new values
                FirebaseFirestore.instance
                    .collection('bharathbenzdriverdetail')
                    .doc(widget.docId)
                    .update({
                   'vehiclenumber': _dropController.text,
                  'Name': _namecontroller.text,
                  'Place': _placecontroller.text,
                  'Blooad Group': _bloddgroupcontroller.text,
                  //'Lorry': _.text,
                  'Expires': _expirecontroller.text,
                  'Insurance Amount': _insuranceamountcontroller.text,
                  'Image URL': imageUrl,
                }).then((_) {
                  Navigator.pop(context); // Go back after updating
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
