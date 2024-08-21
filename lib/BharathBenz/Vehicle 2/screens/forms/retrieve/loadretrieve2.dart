import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BLoadretrieve2 extends StatelessWidget {
  const BLoadretrieve2({super.key});



  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bharathbenzloaddetail2')
          .snapshots(),
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

              String startPoint = data['Start Point'] ?? '';
              String loadPoint = data['Load Point'] ?? '';
              String dropPoint = data['Drop Point'] ?? '';
              String tons = data['No Of Tons / Units'] ?? '';
              String loadAmount = data['Load Amount'] ?? '';
              String deliveryAmount = data['Delivery Amount'] ?? '';
              String customerName = data['Customer Name'] ?? '';
              String customerNo = data['Customer Number'] ?? '';
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
                      children: [
                        Row(
                          children: [
                            Text('Start Point  = '),
                            Text(startPoint),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Load Point  = '),
                            Text(loadPoint),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Drop Point = '),
                            Text(dropPoint),
                          ],
                        ),
                        Row(
                          children: [
                            Text('No os Tons= '),
                            Text(tons),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Load Amount = '),
                            Text(loadAmount),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Delivery Amount = '),
                            Text(deliveryAmount),
                          ],
                        ),
                         Row(
                          children: [
                            Text('Customer Name = '),
                            Text(customerName),
                          ],
                        ),
                         Row(
                          children: [
                            Text('Customer No= '),
                            Text(customerNo),
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
