import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/BharathBenz/Vehicle%201/screens/forms/retrieve/updateforms/updateservice.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Serviceretrieve extends StatelessWidget {
  const Serviceretrieve({super.key});

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, String docId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this record?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                try {
                  await FirebaseFirestore.instance
                      .collection('bharathbenzservices')
                      .doc(docId)
                      .delete();
                } catch (e) {
                  // Handle error (optional)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Failed to delete the record.')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('bharathbenzservices').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingAnimationWidget.discreteCircle(color: orange, size: 60);
        }

        return Scaffold(
          appBar: CustomAppBar(title: 'Service Data', isGoBack: true),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

             String date = data['date'] ?? '';
              String serviceType = data['Service'] ?? '';
              String servicePlace = data['Service Place'] ?? '';
              String contactNo = data['Contact'] ?? '';
              String Amount = data['Amount'] ?? '';
              String kmRiding = data['KM Riding'] ?? '';

              String docId = document.id;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100,
                  height: 200, // Increased height to accommodate buttons
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: orange, width: w * 0.005)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Date: '),
                            Text(date),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Service Type: '),
                            Text(serviceType),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Service Place: '),
                            Text(servicePlace),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Contact No: '),
                            Text(contactNo),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Amount: '),
                            Text(Amount),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('KM Riding: '),
                            Text(kmRiding),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextButton(
                              width: 120,
                              title: 'Update',
                              background: orange,
                              textColor: white,
                              fontSize: 18,
                              onTap: () {
                                // Navigate to the update form with current details
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateFormService(
                                      docId: docId,
                                      data: data,
                                    ),
                                  ),
                                );
                              },
                            ),
                            CustomTextButton(
                              width: 120,
                              title: 'Delete',
                              background: Colors.red,
                              textColor: white,
                              fontSize: 18,
                              onTap: () {
                                _showDeleteConfirmationDialog(context, docId);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}


