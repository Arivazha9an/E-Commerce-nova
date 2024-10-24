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
  final _formKey = GlobalKey<FormState>();

  // Define the controllers at the class level
  late TextEditingController _namecontroller;
  var _imgnamecontroller = TextEditingController();
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
  bool _isLoading = false; // Flag to track loading state

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
    void showDropdownMenu() {
    FocusScope.of(context).requestFocus(FocusNode());
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: _items.map((String item) {
        return PopupMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    ).then((newValue) {
      if (newValue != null) {
        setState(() {
          _selectedItemvehicle = newValue;
          _dropController.text = newValue;
        });
      }
    });
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
        'delDate': Timestamp.now(),
      });
      print('Document updated successfully.');
      Navigator.pop(context); // Navigate back after successful update
    } catch (e) {
      print('Error updating Firestore: $e');
    }
  }

  Future<void> _handleUpdate() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });
    if (_formKey.currentState!.validate()) {
      if (imageFile != null) {
        String? uploadedImageUrl = await uploadImage(imageFile!);
        if (uploadedImageUrl != null) {
          await updateFirestoreWithImageUrl(uploadedImageUrl);
        } else {
          print('Failed to upload image.');
        }
      } else {
        print('No image selected.');
        // If no image is selected, update other fields
        await updateFirestoreWithImageUrl(widget.data['Image URL'] ?? '');
      }

      setState(() {
        _isLoading = false; // Set loading state to false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Update Driver Data', isGoBack: true),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                      child: Form(
                        key: _formKey,
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
                            SizedBox(
                              width: 320,
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  showDropdownMenu();
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: _dropController,
                                    readOnly: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select a Value';
                                      }
                                      return null;
                                    },
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
                                            _dropController.text =
                                                newValue ?? '';
                                          });
                                        },
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: orange),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: black),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      border: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: orange)),
                                    ),
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
                              child: GestureDetector(
                                onTap: () {
                                  pickImage(); // Trigger pick image function
                                },
                                child: AbsorbPointer(
                                  // Prevents text input and focuses on triggering the image picker
                                  child: TextFormField(
                                    controller: _imgnamecontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Add Image';
                                      }
                                      return null;
                                    },
                                    readOnly:
                                        true, // Ensures text cannot be directly edited
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: orange),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      hintText: 'Pick An Image',
                                      suffixIcon: const Icon(
                                          Icons.image), // Display image icon
                                    ),
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
                              hintText: 'MM/YYYY',
                              labeltext: '',
                              keyboardType: TextInputType.datetime,
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
                            SizedBox(
                              height: w * 0.03,
                            ),
                            SizedBox(height: w * 0.02),
                            CustomTextButton(
                              width: w * 0.9,
                              onTap: _handleUpdate,
                              title: 'Update',
                              background: orange,
                              textColor: white,
                              fontSize: 18,
                            ),
                            SizedBox(height: w * 0.02),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Center(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: orange,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
