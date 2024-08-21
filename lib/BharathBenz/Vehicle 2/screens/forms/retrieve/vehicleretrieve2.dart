import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BVehicleretrieve2 extends StatelessWidget {
  const BVehicleretrieve2({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bharathbenzvehicledetail2')
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

              String vehicleCondition = data['Vehicle Condition'] ?? '';
              String registrationNo = data['Registration Number'] ?? '';
              String brand = data['Brand'] ?? '';
              String lorry = data['Lorry'] ?? '';
              String model = data['Model'] ?? '';
              String buildYear = data['Build Year'] ?? '';
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
                            const Text('vehicle Condition = '),
                            Text(vehicleCondition),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Registration No  = '),
                            Text(registrationNo),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Brand = '),
                            Text(brand),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Lorry= '),
                            Text(lorry),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Model = '),
                            Text(model),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('build Year = '),
                            Text(buildYear),
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
