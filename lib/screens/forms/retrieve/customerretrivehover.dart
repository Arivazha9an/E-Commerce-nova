import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/screens/forms/CustomerDetails.dart';
import 'package:e_commerce/widgets/TextfieldwithButton.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomerRetriveHover extends StatefulWidget {
  const CustomerRetriveHover({super.key});

  @override
  State<CustomerRetriveHover> createState() => _CustomerRetriveHoverState();
}

class _CustomerRetriveHoverState extends State<CustomerRetriveHover> {
  bool _isLoading = true;

  List<Map<String, dynamic>> _allDataList = [];
  List<Map<String, dynamic>> _filteredDataList = [];
  TextEditingController _searchController = TextEditingController();
  double combinedexpense = 0.0;
  double combineincome = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _simulateLoading();
    expenseSum();
    incomeSum();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('customerdetails').get();

      setState(() {
        _allDataList = querySnapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
        _filteredDataList = _allDataList; // Initialize with all data
        _isLoading = false; // Stop loading once data is fetched
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching customer details: $e');
      }
      setState(() {
        _isLoading = false; // Stop loading on error as well
      });
    }
  }

  void _onSearchChanged() {
    setState(() {
      _filteredDataList = _allDataList
          .where((data) => data['Name']
              .toString()
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }

  double combinedExpense = 0.0;
  double combinedIncome = 0.0;
  Future incomeSum() async {
    try {
      // Initialize a combined sum variable
      double combinedIncome = 0.0;

      // List of collection names
      List<String> collections = [
        'bharathbenzloaddetail',
        'bharathbenzloaddetail2',
        'taurusloaddetail',
      ];

      // Field names to sum
      String field1 = 'Delivery Amount';
      String field2 = 'Delivery Amount1';

      // Iterate through each collection
      for (String collection in collections) {
        // Fetch all documents from the current collection
        QuerySnapshot querySnapshot =
            await FirebaseFirestore.instance.collection(collection).get();

        // Iterate through documents in the current collection
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          // Access document data
          final data = doc.data() as Map<String, dynamic>;

          // Get the values of field1, field2, and field3
          final fieldValue1 = data[field1];
          final fieldValue2 = data[field2];

          // Convert to double and add to combined sum
          if (fieldValue1 != null) {
            if (fieldValue1 is String) {
              combinedIncome += double.tryParse(fieldValue1) ?? 0.0;
            } else if (fieldValue1 is num) {
              combinedIncome += fieldValue1.toInt();
            }
          }
          if (fieldValue2 != null) {
            if (fieldValue2 is String) {
              combinedIncome += double.tryParse(fieldValue2) ?? 0.0;
            } else if (fieldValue2 is num) {
              combinedIncome += fieldValue2.toInt();
            }
          }
        }
      }
      setState(() {
        combineincome = combinedIncome;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching documents: $e');
      }
    }
  }

  Future expenseSum() async {
    try {
      // Initialize a combined sum variable
      double combinedExpense = 0.0;

      // List of collection names
      List<String> collections = [
        'bharathbenzexpensedetail',
        'bharathbenzexpensedetail2',
        'taurusexpensedetail',
      ];

      // Field names to sum
      String field1 = 'Amount';

      // Iterate through each collection
      for (String collection in collections) {
        // Fetch all documents from the current collection
        QuerySnapshot querySnapshot =
            await FirebaseFirestore.instance.collection(collection).get();

        // Iterate through documents in the current collection
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          // Access document data
          final data = doc.data() as Map<String, dynamic>;

          // Get the values of field1, field2, and field3
          final fieldValue1 = data[field1];

          // Convert to double and add to combined sum
          if (fieldValue1 != null) {
            if (fieldValue1 is String) {
              combinedExpense += double.tryParse(fieldValue1) ?? 0.0;
            } else if (fieldValue1 is num) {
              combinedExpense += fieldValue1.toInt();
            }
          }
        }
      }

      setState(() {
        combinedexpense = combinedExpense;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching documents: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: orange, size: 60),
            )
          : Column(
              children: [
                _buildSummaryRow(),
                const Divider(color: Color.fromARGB(101, 87, 86, 84)),
                _buildSearchBar(),
                _buildCustomerList(),
                _buildAddCustomerButton(),
              ],
            ),
    );
  }

  Widget _buildSummaryRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('Income', combineincome),
          Container(
            height: 70,
            child: const VerticalDivider(
              color: Colors.grey, // Adjust the color as needed
              thickness: 1, // Adjust the thickness as needed
              width: 20, // Space around the divider
            ),
          ),
          _buildSummaryItem('Expense', combinedexpense),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, double amount) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 18)),
        Row(
          children: [
            const Icon(Icons.currency_rupee),
            Text(
              amount.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(color: grey),
          suffixIcon: const Icon(Icons.search, color: black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(color: black),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerList() {
    if (_filteredDataList.isEmpty) {
      return const Center(child: Text('No Customer found'));
    }
    return Expanded(
      child: ListView.builder(
        itemCount: _filteredDataList.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomFieldButton(
                name: _filteredDataList[index]['Name'],
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(data: _filteredDataList[index]),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddCustomerButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CustomerDetails()),
              );
            },
            backgroundColor: orange,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: white),
          ),
          const Text('Add Customer'),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  DetailPage({required this.data});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Information'),
      ),
      body: Center(
        child: Container(
          height: 150,
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: orange, width: w * 0.005),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Customer Name:', data['Name']),
              _buildDetailRow('Place:', data['Place']),
              _buildDetailRow('Material:', data['Material']),
              _buildDetailRow('Paid:', data['Paid']),
              _buildDetailRow('Not Paid:', data['Not_Paid']),
              _buildDetailRow('Payment:', data['Payment']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Row(
      children: [
        Text('$label ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('$value'),
      ],
    );
  }
}
