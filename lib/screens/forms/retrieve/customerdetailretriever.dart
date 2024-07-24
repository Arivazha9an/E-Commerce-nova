import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomerDetailRetreieve extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CustomerDetailRetreieve> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getDocumentByField(String fieldValue) async {
    return await _firestore
        .collection('your_collection')
        .where('name', isEqualTo: fieldValue)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Document by Field'),
      ),
      body: Center(
        child: FutureBuilder<QuerySnapshot>(
          future: getDocumentByField('your_field_value'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text('No document found');
            }

            // Assuming only one document is returned
            var document = snapshot.data!.docs.first;
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Text('Document Data: ${data.toString()}');
          },
        ),
      ),
    );
  }
}
 