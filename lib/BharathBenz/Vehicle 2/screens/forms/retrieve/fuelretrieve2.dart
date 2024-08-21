import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BFuelretrieve2 extends StatelessWidget {
  const BFuelretrieve2({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('bharthbenzrefuel2').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingAnimationWidget.discreteCircle(color: orange, size: 60);
        }

        return Scaffold(
          appBar: CustomAppBar(title: 'Refuel Data1',isGoBack: true,),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              String date = data['date'] ?? '';
              String startKm = data['Start KM'] ?? '';
              String Price = data['Price'] ?? '';
              String Liter = data['Liter'] ?? '';
              String Place = data['Place'] ?? '';
              String End_Km = data['End Km'] ?? '';
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
                            Text('Start Km  = '),
                            Text(startKm),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Price  = '),
                            Text(Price),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Liters  = '),
                            Text(Liter),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Place  = '),
                            Text(Place),
                          ],
                        ),
                        Row(
                          children: [
                            Text('End KM  = '),
                            Text(End_Km),
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
