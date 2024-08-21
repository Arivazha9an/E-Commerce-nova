import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:flutter/material.dart';

import '../models/customer.dart';

class CustomerDetail extends StatelessWidget {
  const CustomerDetail({super.key, required this.customerData});
  final Customer customerData;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: CustomAppBar(title: 'Customer Detail'),
      body: Center(
        child: Column(
          children: [Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: orange, width: w * 0.005)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Row(
                    children: [Text('Customer Name ='),
                      Text(customerData.Name),
                    ],
                  ),
                  Row(
                    children: [ Text('Place =')
                     , Text(customerData.Place),
                    ],
                  ),
                  Row(
                    children: [Text('Material ='),
                      Text(customerData.Material),
                    ],
                  ),
                  Row(
                    children: [Text('Paid  ='),
                      Text(customerData.Paid),
                    ],
                  ),
                  Row(
                    children: [Text('Not Paid  ='),
                      Text(customerData.Not_Paid),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Payment  ='),
                      Text(customerData.Payment),
                    ],
                  ),
            
              ],
            ),
          )
          
          ],
        ),
      ),
    );
  }
}
