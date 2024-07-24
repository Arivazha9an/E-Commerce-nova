import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Insuranceretrive2 extends StatelessWidget {
  const Insuranceretrive2({super.key});



  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('taurusinsurance')
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
            title: 'insurance Data',
            isGoBack: true,
          ),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              String company = data['Company'] ?? '';
              String policytype = data['Policy Type'] ?? '';
              String policyNo = data['Policy Number'] ?? '';
              String issue = data['Issue'] ?? '';
              String expires = data['Expire'] ?? '';
              String insuranceAmount = data['Insurance Amount'] ?? '';
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
                            const Text('Company  = '),
                            Text(company),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Policy Type  = '),
                            Text(policytype),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Policy No  = '),
                            Text(policyNo),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Issue = '),
                            Text(issue),
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
