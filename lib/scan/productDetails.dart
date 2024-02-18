// import 'dart:math';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_cart/widgets/gradient_container.dart';
import 'package:green_cart/api_service.dart';
import 'package:http/http.dart' as http;

import '../chat.dart';
import '../constants.dart';
import '../models/barcodeDetails.dart';

class ProductDetails extends StatefulWidget {
  final int child;
  ProductDetails(this.child, {super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // late List<BarcodeDetails>? _barcodeDetails =[];
  // BarcodeDetails barcodeDetails ;
  // late String _barcodeDetails = '';
  // int? barcode = int.tryParse(widget.child);
  late Future<String> _futureBarcodeDetails;
  final http.Client httpClient = http.Client();

  Future<String> getBarcode(int barcode, String user_id) async {
    try {
      log('entered getBarcode');
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.barcodeEndpoint);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'user_id': user_id,
            'barcode': barcode,
          }));
      log('response statuscode: ${response}');

      if (response.statusCode == 200) {
        log('response statuscode: ${jsonDecode(response.body)}');
        // log('message : ${BarcodeDetails.fromJson(jsonDecode(response.body))}');
        return response.body;
      } else {
        log('Failed to load barcode details: ${response.statusCode}');
        // throw Exception('Failed to create album.');
      }
    } catch (e) {
      log('Error: $e');
    }
    log('barcode n userid: $barcode, $user_id');
    throw Exception('Failed.');
  }

  @override
  void initState() {
    super.initState();
      _futureBarcodeDetails = getBarcode(widget.child, '0');
  }

  // void getBarcodeDetails(int barcode, String user_id) async {
  //   // _barcodeDetails = (await ApiService().getBarcode(barcode, user_id))!;
  //   var response = await ApiService().getBarcode(barcode, user_id);
  //   log("response : $response");
  //   await Future.delayed(const Duration(seconds: 1), () {
  //   setState(() {
  //     _barcodeDetails = response!;
  //   });
  //   });

    // ApiService apiService = ApiService();
    // try {
      // String? response = await apiService.getBarcode(barcode, user_id);
      // print('*** : $response');
    // } catch (e) {
    //   print('Error: $e');
    // }
  // }

  @override
  void dispose() {
    httpClient.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const assetName = 'assets/images/logo.svg';

    return Scaffold(
      floatingActionButton: ChatButton(),
      body: GradientContainer(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 30.0),
          child: FutureBuilder<String>(
            future: _futureBarcodeDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Barcode Details: ${snapshot.data}');
              }
            },
          )
          // SingleChildScrollView(
          //   scrollDirection: Axis.vertical,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       IconButton(
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //           icon: Row(
          //             children: [
          //               Icon(Icons.arrow_back_ios,color: Theme.of(context).primaryColor,),
          //               Text(
          //                 "Go back",
          //                 style: TextStyle(
          //                   color: Theme.of(context).primaryColor,
          //                   fontWeight: FontWeight.w700,
          //                   fontSize: 18,
          //                 ),
          //               ),
          //             ],
          //           ),
          //       ),
          //       const SizedBox(
          //         height: 30,
          //       ),
          //       const Text(
          //         "Product Name",
          //         style: TextStyle(
          //           fontSize: 24,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 10,
          //       ),
          //       Text(
          //         "Barcode No.: ${widget.child}",
          //         style: const TextStyle(
          //           fontSize: 18,
          //           // fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 20,
          //       ),
          //       ClipRRect(
          //         borderRadius: BorderRadius.circular(15),
          //         child: Image.network(
          //           'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png',
          //           fit: BoxFit.fill,
          //         ),
          //         // SvgPicture.asset(assetName, fit: BoxFit.contain,),
          //       ),
          //       const SizedBox(
          //         height: 20,
          //       ),
          //       const Text(
          //         "Product Details:",
          //         style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //       // _barcodeDetails == null || _barcodeDetails!.isEmpty
          //       //     ? const Center(
          //       //   child: CircularProgressIndicator(),
          //       // )
          //       //     :
          //       Text("data: "),
          //           // "${_barcodeDetails.toString()}"),
          //       // ListView.builder(
          //       //       physics: NeverScrollableScrollPhysics(),
          //       //       shrinkWrap: true,
          //       //       // itemCount: barcodeDetails?.length,
          //       //       itemCount: 10,
          //       //       itemBuilder: (context, index) {
          //       //         return Container(
          //       //           child: Text(' {response}'),
          //       //         );
          //       //       },
          //       //     )
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
