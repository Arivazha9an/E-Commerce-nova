import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loadretrieve2 extends StatelessWidget {
  const Loadretrieve2({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('taurusloaddetail').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingAnimationWidget.discreteCircle(color: orange, size: 60);
        }

        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Load  Data',
            isGoBack: true,
          ),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              var dateField = data['Date01'];
              var dateField2 = data['Date02'];
              DateTime dateTime;

              if (dateField is Timestamp) {
                dateTime = dateField.toDate();
              } else if (dateField is String) {
                dateTime = DateTime.parse(dateField);
              } else {
                return Center(child: Text(''));
              }
              DateTime dateTime1;
              if (dateField2 is Timestamp) {
                dateTime1 = dateField2.toDate();
              } else if (dateField2 is String) {
                dateTime1 = DateTime.parse(dateField2);
              } else {
                return Center(child: Text(''));
              }
              String formattedDate =
                  DateFormat('dd / MM / yyyy').format(dateTime);
              String formattedDate1 =
                  DateFormat('dd / MM / yyyy').format(dateTime1);
              // String date = data['Date'] ?? '';
              String startPoint = data['Start Point'] ?? '';
              String loadPoint = data['Load Point'] ?? '';
              String dropPoint = data['Drop Point'] ?? '';
              String tons = data['No Of Tons / Units'] ?? '';
              String loadAmount = data['Load Amount'] ?? '';
              String deliveryAmount = data['Delivery Amount'] ?? '';
              String customerName = data['Customer Name'] ?? '';
              String customerNo = data['Customer Number'] ?? '';              
              
              String loadPoint1 = data['Load Point1'] ?? '';
              String dropPoint1 = data['Drop Point1'] ?? '';
              String tons1 = data['No Of Tons / Units1'] ?? '';
              String loadAmount1 = data['Load Amount1'] ?? '';
              String deliveryAmount1 = data['Delivery Amount1'] ?? '';
              String customerName1 = data['Customer Name1'] ?? '';
              String customerNo1 = data['Customer Number1'] ?? '';
              String startPoint1 = data['Start Point1'] ?? '';
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: orange, width: w * 0.005)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 70, right: 20, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(6)),
                                  border:
                                      Border.all(color: grey, width: w * 0.0025)),
                              child: const Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text('Load Dispatch Details'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const Text('Date  = '),
                            Text(formattedDate),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Start Point  = '),
                            Text(startPoint),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Load Point  = '),
                            Text(loadPoint),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Drop Point = '),
                            Text(dropPoint),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('No os Tons= '),
                            Text(tons),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Load Amount = '),
                            Text(loadAmount),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Delivery Amount = '),
                            Text(deliveryAmount),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Customer Name = '),
                            Text(customerName),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Customer No= '),
                            Text(customerNo),
                          ],
                        ),
                        
                        SizedBox(height: 30,),
                        Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(6)),
                                    border:
                                        Border.all(color: grey, width: w * 0.0025)),
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text('Load Return Details'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            const Text('Date  = '),
                            Text(formattedDate1),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Start Point  = '),
                            Text(startPoint1),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Load Point  = '),
                            Text(loadPoint1),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Drop Point = '),
                            Text(dropPoint1),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('No os Tons= '),
                            Text(tons1),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Load Amount = '),
                            Text(loadAmount1),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Delivery Amount = '),
                            Text(deliveryAmount1),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Customer Name = '),
                            Text(customerName1),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Customer No= '),
                            Text(customerNo1),
                          ],
                        ),
                        SizedBox(
                          height: 30,
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
