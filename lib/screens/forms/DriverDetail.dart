import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombuttom%20outlined.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class DriverDetail extends StatefulWidget {
  const DriverDetail({super.key});
  @override
  State<DriverDetail> createState() => _driverDetailState();
}

class _driverDetailState extends State<DriverDetail> {
  
final _formKey = GlobalKey<FormState>();

  var _namecontroller = TextEditingController();
  var _imgnamecontroller = TextEditingController();
  var _placecontroller = TextEditingController();
  var _bloddgroupcontroller = TextEditingController();
  var _expirecontroller = TextEditingController();
  var _insuranceamountcontroller = TextEditingController();
  File imageFile = File('');
  final TextEditingController _dropController = TextEditingController();
  List<String> _items = []; 
  String? _selectedItemvehicle;  
  @override
  void initState() {
    super.initState();
    _fetchItems();  
  }

  void clear() {
    _namecontroller.clear();
    _imgnamecontroller.clear();
    _placecontroller.clear();
    _bloddgroupcontroller.clear();
    _expirecontroller.clear();
    _insuranceamountcontroller.clear();
    _dropController.clear();
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
        .child('taurus_driver')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

    firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);

    firebase_storage.TaskSnapshot snapshot =
        await uploadTask.whenComplete(() => null);
    return await snapshot.ref.getDownloadURL();
  }

  // Function to fetch data from Firestore
  Future<void> _fetchItems() async {
    try {
       QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('bharathbenzvehicledetail')
          .get();
      
      List<String> items =
          snapshot.docs.map((doc) => doc['vehicle Number'].toString()).toList();

      setState(() {
        _items = items;  
      });
    } catch (e) {
      print('Error fetching data from Firestore: $e'); 
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

  @override
  Widget build(BuildContext context) {
    void _saveData() async {
      if (_dropController.text.isEmpty &&
          _namecontroller.text.isEmpty &&
          _placecontroller.text.isEmpty &&
          _bloddgroupcontroller.text.isEmpty &&
          _expirecontroller.text.isEmpty &&
          _insuranceamountcontroller.text.isEmpty) {
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
      } else if (_formKey.currentState!.validate()) {
        try {
          String imageUrl = await uploadImage(imageFile);
          await FirebaseFirestore.instance
              .collection('tuarusdriverdetail')
              .add({
            'vehiclenumber': _dropController.text,
            'Name': _namecontroller.text,
            'Place': _placecontroller.text,
            'Blood Group': _bloddgroupcontroller.text,             
            'Expires': _expirecontroller.text,
            'Insurance Amount': _insuranceamountcontroller.text,
            'Image URL': imageUrl,
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
          
          Future.delayed(
              const Duration(seconds: 2), () => Navigator.pop(context));
        } on FirebaseException catch (e) {
           
          print('Failed with error code: ${e.code}');
          print(e.message);
          
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
           
          print('Unexpected error: $e');
           
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
      else{
        return;
      }
    }

    var w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Driver Detail'),
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
                              FocusScope.of(context).requestFocus(FocusNode());
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
                          hintText: ' ',
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
                          hintText: ' ',
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
                              _pickImage(); // Trigger pick image function
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
                                    borderSide: const BorderSide(color: orange),
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
                          hintText: ' ',
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
                            hintText: ' ',
                            labeltext: '',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
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
