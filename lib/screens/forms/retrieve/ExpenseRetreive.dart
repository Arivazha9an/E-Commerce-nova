import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Expenseretreieve2 extends StatelessWidget {
  const Expenseretreieve2({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('taurusexpensedetail')
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
            title: 'Expense Data',
            isGoBack: true,
          ),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              String tollno = data['Toll No 1'] ?? '';
              String tollprice = data['Toll Price'] ?? '';
              String loadman = data['Loadman'] ?? '';
              String others = data['Others'] ?? '';

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
                        const EdgeInsets.only(left: 80, right: 20, top: 30),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Toll  No  = '),
                            Text(tollno),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Total Price  = '),
                            Text(tollprice),
                          ],
                        ),
                        Row(
                          children: [
                            Text('LoadMan = '),
                            Text(loadman),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Others = '),
                            Text(others),
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
