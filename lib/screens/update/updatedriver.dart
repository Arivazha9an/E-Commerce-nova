import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateFormDriverT extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> data;

  const UpdateFormDriverT({super.key, required this.docId, required this.data});

  @override
  State<UpdateFormDriverT> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateFormDriverT> {
  // Define the controllers at the class level
  late TextEditingController _namecontroller;
    var _imgnamecontroller =  TextEditingController();
  late TextEditingController _placecontroller;
  late TextEditingController _bloddgroupcontroller;
  late TextEditingController _expirecontroller;
  late TextEditingController _insuranceamountcontroller;
  late TextEditingController _dropController;
  final ImagePicker _picker = ImagePicker();
  String imageUrl = '';
  File? imageFile;
  List<String> _items = []; // List to hold Firestore data
  String? _selectedItemvehicle; // Variable to hold the selected item

  @override
  void initState() {
    _fetchItems();
    super.initState();
    // Initialize controllers with data from Firestore
    _namecontroller = TextEditingController(text: widget.data['Name'] ?? '');   
    _placecontroller = TextEditingController(text: widget.data['Place'] ?? '');
    _bloddgroupcontroller =
        TextEditingController(text: widget.data['Blood Group'] ?? '');
    _expirecontroller =
        TextEditingController(text: widget.data['Expires'] ?? '');
    _insuranceamountcontroller =
        TextEditingController(text: widget.data['Insurance Amount'] ?? '');
    _dropController =
        TextEditingController(text: widget.data['vehiclenumber'] ?? '');
  }

  Future<void> _fetchItems() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('bharathbenzvehicledetail')
          .get();
      List<String> items =
          snapshot.docs.map((doc) => doc['vehicle Number'].toString()).toList();
      setState(() {
        _items = items; // Update the state with fetched items
      });
    } catch (e) {
      print('Error fetching data from Firestore: $e'); // Handle errors
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        _imgnamecontroller.text = imageFile!.path.split('/').last;
      });
    } else {
      print('No image selected.');
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('taurus_driver')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
      firebase_storage.TaskSnapshot snapshot =
          await uploadTask.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> updateFirestoreWithImageUrl(String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('tuarusdriverdetail')
          .doc(widget.docId)
          .update({
        'vehiclenumber': _dropController.text,
        'Name': _namecontroller.text,
        'Place': _placecontroller.text,
        'Blood Group': _bloddgroupcontroller.text,
        'Expires': _expirecontroller.text,
        'Insurance Amount': _insuranceamountcontroller.text,
        'Image URL': imageUrl, // Store the obtained imageUrl
      });
      print('Document updated successfully.');
      Navigator.pop(context); // Navigate back after successful update
    } catch (e) {
      print('Error updating Firestore: $e');
    }
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _namecontroller.dispose();
    _imgnamecontroller.dispose();
    _placecontroller.dispose();
    _bloddgroupcontroller.dispose();
    _expirecontroller.dispose();
    _insuranceamountcontroller.dispose();
    _dropController.dispose();
    super.dispose();
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
                          readOnly: true,
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
                                  _selectedItemvehicle = newValue;
                                  _dropController.text = newValue ?? '';
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
                          controller: _imgnamecontroller,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'No Image Selected',
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
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.image),
                              onPressed: pickImage, // Call pickImage function
                            ),
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
                            child: Text('Expires')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _expirecontroller,
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
                            child: Text('Insurance Amount')),
                      ),
                      CustomTextFormField(
                        width: 320,
                        controller: _insuranceamountcontroller,
                        hintText: '',
                        labeltext: '',
                        keyboardType: TextInputType.number,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: w * 0.05),
                        child: CustomTextButton(
                          width: 150,
                          title: 'Update',
                          background: orange,
                          textColor: white,
                          fontSize: 18,
                          onTap: () async {
                            if (imageFile != null) {
                              String? uploadedImageUrl =
                                  await uploadImage(imageFile!);
                              if (uploadedImageUrl != null) {
                                await updateFirestoreWithImageUrl(
                                    uploadedImageUrl);
                              } else {
                                print('Failed to upload image.');
                              }
                            } else {
                              print('No image selected.');
                              // If no image is selected, update other fields
                              await updateFirestoreWithImageUrl(
                                  widget.data['Image URL'] ?? '');
                            }
                          },
                        ),
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


