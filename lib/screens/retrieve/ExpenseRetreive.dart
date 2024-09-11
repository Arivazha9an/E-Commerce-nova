import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

           
              String Expenstype = data['ExpenseType'] ?? '';
              String Amount = data['Amount'] ?? '';
              String km = data['Km'] ?? '';
               var dateField = data['Date01'];
              DateTime dateTime;

              if (dateField is Timestamp) {
                dateTime = dateField.toDate();
              } else if (dateField is String) {
                dateTime = DateTime.parse(dateField);
              } else {
                return Center(child: Text(''));
              }
              String formattedDate =
                  DateFormat('dd / MM / yyyy').format(dateTime);
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
                            Text('Date  = '),
                            Text(formattedDate),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Expense Type  = '),
                            Text(Expenstype),
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
                            Text('Km Reading = '),
                            Text(km),
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
