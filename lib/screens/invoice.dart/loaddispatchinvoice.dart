import 'dart:typed_data';

import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:signature/signature.dart';
import 'package:pdf/widgets.dart' as pw;

class Loaddispatchinvoice extends StatefulWidget {
  final Map<String, dynamic> data;
  const Loaddispatchinvoice({super.key, required this.data});

  @override
  State<Loaddispatchinvoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Loaddispatchinvoice> {
  late String date;
  late String vehicleNumber;
  late String startPoint;
  late String loadPoint;
  late String dropPoint;
  late String noofTons;
  late String loadAmount;
  late String deliveryAmount;
  late String customerName;
  late String customerNo;
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    date = widget.data['date'] ?? '';
    deliveryAmount = widget.data['Delivery Amount'] ?? '';
    // Initialize controllers with data from Firestore
    vehicleNumber = widget.data['vehiclenumber'];

    startPoint = widget.data['Start Point'] ?? '';
    loadPoint = widget.data['Load Point'] ?? '';
    dropPoint = widget.data['Drop Point'] ?? '';
    noofTons = widget.data['No Of Tons / Units'] ?? '';
    loadAmount = widget.data['Load Amount'] ?? '';
    deliveryAmount = widget.data['Delivery Amount'] ?? '';
    customerName = widget.data['Customer Name'] ?? '';
    customerNo = widget.data['Customer Number'] ?? '';
  }

  // Variable to hold the captured signature
  Uint8List? _signatureImage;

  Future<void> _showSignaturePad(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Here'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Signature(
              controller: _controller,
              height: 100,
              width: 300,
              backgroundColor: Colors.grey[200]!,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.clear(); // Clear the signature pad
                  },
                  child: const Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_controller.isNotEmpty) {
                      final signature = await _controller.toPngBytes();
                      if (signature != null) {
                        setState(() {
                          _signatureImage = signature; // Save the signature
                        });
                      }
                      Navigator.of(context).pop(); // Close the dialog
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _createPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
          build: (pw.Context context) => pw.Center(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Logo'),
                        pw.Row(
                          children: [
                            pw.Text('Date : $date'),
                          ],
                        )
                      ],
                    ),
                    pw.SizedBox(height: 30),
                    pw.Center(
                        child: pw.Text('Invoice',
                            style: const pw.TextStyle(fontSize: 28))),
                    pw.SizedBox(height: 30),
                    pw.Row(children: [
                      pw.SizedBox(
                        width: 170,
                      ),
                      pw.Text('Customer Name    : $customerName')
                    ]),
                    pw.SizedBox(height: 10),
                    pw.Row(children: [
                      pw.SizedBox(
                        width: 170,
                      ),
                      pw.Text('Customer No         : $customerNo'),
                    ]),
                    pw.SizedBox(height: 10),
                    pw.Row(children: [
                      pw.SizedBox(
                        width: 170,
                      ),
                      pw.Text('Vehicle Number    : $vehicleNumber'),
                    ]),
                    pw.SizedBox(height: 10),
                    pw.Row(children: [
                      pw.SizedBox(
                        width: 170,
                      ),
                      pw.Text('Start Point             : $startPoint'),
                    ]),
                    pw.SizedBox(height: 10),
                    pw.Row(children: [
                      pw.SizedBox(
                        width: 170,
                      ),
                      pw.Text('Drop Point             : $dropPoint'),
                    ]),
                    pw.SizedBox(height: 10),
                    pw.Row(children: [
                      pw.SizedBox(
                        width: 170,
                      ),
                      pw.Text('No of Tons/Units   : $noofTons'),
                    ]),
                    pw.SizedBox(height: 10),
                    pw.Row(children: [
                      pw.SizedBox(
                        width: 170,
                      ),
                      pw.Text('Load Amount         : $loadAmount'),
                    ]),
                    pw.SizedBox(height: 10),
                    pw.Row(children: [
                      pw.SizedBox(
                        width: 170,
                      ),
                      pw.Text('Delivery Amount    : $deliveryAmount'),
                    ]),
                    pw.SizedBox(height: 30),
                    pw.Align(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text('Total Amount: ₹ $deliveryAmount'),
                    ),
                    if (_signatureImage != null) ...[
                      pw.SizedBox(height: 20),
                      pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Column(children: [
                            pw.Text('Signature:'),
                            pw.SizedBox(height: 3),
                            pw.Image(pw.MemoryImage(_signatureImage!),
                                width: 80, height: 40),
                          ]))
                    ],
                  ],
                ),
              )),
    );

    return pdf.save();
  }

  // Function to share the generated PDF
  Future<void> _sharePdf() async {
    final pdfBytes = await _createPdf();

    // Share the PDF using share_plus
    await Share.shareXFiles(
      [
        XFile.fromData(pdfBytes,
            mimeType: 'application/pdf', name: 'invoice.pdf')
      ],
      text: 'Here is your invoice!',
    );
  }

//   @override
//   void initState() {
//     super.initState();
//    // Initialize controllers with data from Firestore
//   vehicleNumber =  widget.data['vehiclenumber'] ?? '';
//    date= widget.data['date'] ?? '';
//    startPoint=  widget.data['Start Point'] ?? '';
//    loadPoint= widget.data['Load Point'] ?? '';
//     dropPoint= widget.data['Drop Point'] ?? '';
//   noofTons = widget.data['No Of Tons / Units'] ?? '';
//     loadAmount = widget.data['Load Amount'] ?? '';
//    deliveryAmount= widget.data['Delivery Amount'] ?? '';
//  customerName = widget.data['Customer Name'] ?? '';
//   customerNo =  widget.data['Customer Number'] ?? '';
//   }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Invoice'),
      body: Column(
        children: [
          Center(
            child: Container(
              width: 350,
              height: 550,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: orange, width: w * 0.005)),
              child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 20, top: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Logo'),
                          Row(
                            children: [
                              const Text('Date :'),
                              Text(date),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          'Invoice',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Customer name    :'),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(customerName),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Customer No         :'),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(customerNo),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Vehicle Number    :'),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(vehicleNumber),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Start Point             :'),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(startPoint),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Drop Point             :'),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(dropPoint),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('No of Tons/ Units :'),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(noofTons),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Load Amount          :'),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(loadAmount),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Delivery Amount   :'),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(deliveryAmount),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text('Total Amount : ₹'),
                          Text(deliveryAmount)
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => _showSignaturePad(context),
                            child: Container(
                              height: 80,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                // border: Border.all(color: Colors.black),
                              ),
                              child: _signatureImage != null
                                  ? Image.memory(
                                      _signatureImage!) // Display the signature
                                  : const Center(child: Text('Tap to Sign')),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                border: Border.all(
                                    color: orange, width: w * 0.005)),
                            child: Center(
                              child: IconButton(
                                  onPressed: _sharePdf,
                                  icon: const Icon(
                                    Icons.share_rounded,
                                    size: 26,
                                    color: orange,
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
