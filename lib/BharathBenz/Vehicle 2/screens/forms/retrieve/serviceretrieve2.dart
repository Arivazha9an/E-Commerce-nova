import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BServiceretrieve2 extends StatelessWidget {
  const BServiceretrieve2({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('bharathbenzservices2').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingAnimationWidget.discreteCircle(color: orange, size: 60);
        }

        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Service Data',
            isGoBack: true,
          ),
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100,
                  height: 160,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: orange, width: w * 0.005)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 70, right: 20, top: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Date  = '),
                            Text(date),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Service type  = '),
                            Text(serviceType),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Service Place  = '),
                            Text(servicePlace),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Contact = '),
                            Text(contactNo),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Amount = '),
                            Text(Amount),
                          ],
                        ),
                        Row(
                          children: [
                            Text('KM Riding = '),
                            Text(kmRiding),
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
