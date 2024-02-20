// import 'dart:math';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_cart/widgets/gradient_container.dart';
import 'package:green_cart/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
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
  late Future<BarcodeDetails>? _futureBarcodeDetails;
  final http.Client httpClient = http.Client();
  late String _jsonData;

  Future<BarcodeDetails> getBarcode(int barcode, String user_id) async {
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
        log('response statuscode:: ${jsonDecode(response.body)}');
        log('message : ${BarcodeDetails.fromJson(jsonDecode(response.body)).imageUrl}');
        // setState(() {
        // _jsonData = jsonDecode(response.body);
        // _jsonData = BarcodeDetails.fromJson(response.body);
        // });
        // return response.body;
        return BarcodeDetails.fromJson(jsonDecode(response.body));
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

  final FirebaseAuth auth = FirebaseAuth.instance;
  String? getUserId() {
    final User? user = auth.currentUser;
    final String? uid = user?.uid.toString();
    return uid;
  }

  @override
  void initState() {
    super.initState();
    _futureBarcodeDetails = getBarcode(widget.child, getUserId() ?? '0');
  }

  @override

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
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 20.0, top: 30.0),
            child: FutureBuilder<BarcodeDetails?>(
              future: _futureBarcodeDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              "Go back",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Center(child: CircularProgressIndicator()),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                "Go back",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Product Name: ${snapshot.data!.name.toString()}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Barcode No.: ${widget.child}",
                          style: const TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              'https:${snapshot.data!.imageUrl.toString()}',
                              // 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png',
                              fit: BoxFit.fill,
                            ),
                            // SvgPicture.asset(assetName, fit: BoxFit.contain,),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Product Details:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text("data: ${snapshot.data!.brands}"),
                        // Text('Barcode Details: ${snapshot.data}');
                      ],
                    ),
                  );
                }
              },
            )),
      ),
    );
  }
}
