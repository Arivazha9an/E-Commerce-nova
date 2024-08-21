import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BDriverretrieve2 extends StatelessWidget {
  const BDriverretrieve2({super.key});



  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bharathbenzdriverdetail2')
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
            title: 'Driver Data',
            isGoBack: true,
          ),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              String name = data['Name'] ?? ''; 
              String place = data['Place'] ?? '';
              String bloodGroup = data['Blooad Group'] ?? '';
              String photo= data['Image URL'] ?? '';
              String expires = data['Expires'] ?? '';
              String insuranceAmount= data['Insurance Amount'] ?? '';
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
                        Center(
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(photo),
                          ),
                        ),
                        Row(
                          children: [
                            Text('Name  = '),
                            Text(name),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Place  = '),
                            Text(place),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Blood Group  = '),
                            Text(bloodGroup),
                          ],
                        ),
                       
                        Row(
                          children: [
                            Text('Expires = '),
                            Text(expires),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Insurance Amount = '),
                            Text(insuranceAmount),
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
