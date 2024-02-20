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
  // late Future<Nutri>? _futureNutriDetails;

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

// <<<<<<< HEAD
// =======

  final FirebaseAuth auth = FirebaseAuth.instance;
  String? getUserId() {
    final User? user = auth.currentUser;
    final String? uid = user?.uid.toString();
    return uid;
  }

// >>>>>>> master
  // Future<Nutri> getNutri(int barcode, String user_id) async {
  //   try {
  //     log('entered getBarcode');
  //     var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.barcodeEndpoint);
  //     var response = await http.post(url,
  //         headers: <String, String>{
  //           'Content-Type': 'application/json',
  //         },
  //         body: jsonEncode({
  //           'user_id': user_id,
  //           'barcode': barcode,
  //         }));
  //     log('response statuscode: ${response}');
  //
  //     if (response.statusCode == 200) {
  //       log('response statuscode:: ${jsonDecode(response.body)}');
  //       log('message : ${Nutri.fromJson(jsonDecode(response.body))}');
  //       // setState(() {
  //       // _jsonData = jsonDecode(response.body);
  //       // _jsonData = BarcodeDetails.fromJson(response.body);
  //       // });
  //       // return response.body;
  //       return Nutri.fromJson(jsonDecode(response.body) );
  //     } else {
  //       log('Failed to load barcode details: ${response.statusCode}');
  //       // throw Exception('Failed to create album.');
  //     }
  //   } catch (e) {
  //     log('Error: $e');
  //   }
  //   log('barcode n userid: $barcode, $user_id');
  //   throw Exception('Failed.');
  // }


  @override
  void initState() {
    super.initState();
// <<<<<<< HEAD
//       _futureBarcodeDetails = getBarcode(widget.child, '0');
      // _futureNutriDetails = getNutri(widget.child, '0');
// =======
    _futureBarcodeDetails = getBarcode(widget.child, getUserId() ?? '0');
// >>>>>>> master

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

  Color getColorFromData(data) {
    if (data == 'a') {
      return Colors.green;
    } else if (data == 'b') {
      return Colors.lightGreenAccent;
    } else if (data == 'c') {
      return Colors.yellow;
    } else if (data == 'd') {
      return Colors.orange;
    } else if (data == 'e') {
    return Colors.red;
    } else {
    return Colors.grey;
    }
  }

  Color getTextColorFromData(data) {
    if (data == 'a') {
      return Colors.black;
    } else if (data == 'b') {
      return Colors.black;
    } else if (data == 'c') {
      return Colors.black;
    } else if (data == 'd') {
      return Colors.black;
    } else if (data == 'e') {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color getNovaColorFromData(data) {
    if (data == 1) {
      return Colors.green;
    } else if (data == 2) {
      return Colors.yellow;
    } else if (data == 3) {
      return Colors.orange;
    } else if (data == 4) {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }

  String getTextFromData(data) {
    if (data == 1) {
      return 'Unprocessed or minimally processed foods';
    } else if (data == 2) {
      return 'Processed culinary ingredients';
    } else if (data == 3) {
      return 'Processed foods';
    }else if (data == 4) {
      return 'Ultra-processed food and drink products';
    } else {
      return 'No Data';
    }
  }



  @override
  Widget build(BuildContext context) {
    const assetName = 'assets/images/logo.svg';
    double container1Size;
    double container2Size;
    double container3Size;
    double container4Size;
    void updateContainerSize(int? value) {
      setState(() {
        if (value == 1) {
          container1Size = 40;
        } else if (value == 2) {
          container2Size = 40.0;
        } else if (value == 3) {
          container3Size = 40.0;
        } else if (value == 4) {
          container4Size = 40.0;
        }
      });
    }

    return Scaffold(
      floatingActionButton: ChatButton(),
      body: GradientContainer(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 30.0),
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
                                  Icon(Icons.arrow_back_ios,color: Theme.of(context).primaryColor,),
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
              }
              // else {
              //   // updateContainerSize(snapshot.data!.novaGroup);
              //   return  SingleChildScrollView(
              //     scrollDirection: Axis.vertical,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         IconButton(
              //           onPressed: () {
              //             Navigator.pop(context);
              //           },
              //           icon: Row(
              //             children: [
              //               Icon(
              //                 Icons.arrow_back_ios,
              //                 color: Theme.of(context).primaryColor,
              //               ),
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
              //         ),
              //         const Center(child: CircularProgressIndicator()),
              //       ],
              //     ),
              //   );
              //   }
              else if (snapshot.hasError) {
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
                      // ],
                      // ),

                        Text(
                          "Product Name: ${snapshot.data!.name.toString()}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("${snapshot.data!.brands ?? 'No data' }", style: TextStyle(fontSize: 18),),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        Text(
                            "Barcode No.: ${widget.child}",
                            style: const TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(
                          height: 10,
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
                        height: 15,
                      ),
                      // ),
                      Card(
                        color: getColorFromData(snapshot.data?.ecoscoreGrade),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                child: Icon(Icons.eco, color: getColorFromData(snapshot.data?.ecoscoreGrade),),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Eco Grade: ${(snapshot.data!.ecoscoreGrade ?? 'No data').toUpperCase()}",
                                    style: const TextStyle(
                                        // color: getTextColorFromData(snapshot.data?.ecoscoreGrade),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const Text("Environmental impact for this product is: " ,
                                      softWrap: true
                                  ),
                                  Text("Score: ${snapshot.data!.ecoscoreScore ?? 'No data' }/100", style: const TextStyle(fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  child: Icon(Icons.local_grocery_store, color: Theme.of(context).primaryColor,),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Ingredients",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text("${snapshot.data!.ingredients ?? 'No data' }" ,
                                      softWrap: true,
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
// // <<<<<<< HEAD
//                       Card(
//                         color: getColorFromData(snapshot.data?.ecoscoreGrade),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               CircleAvatar(
//                                 child: Icon(Icons.eco, color: getColorFromData(snapshot.data?.ecoscoreGrade),),
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Eco Grade: ${(snapshot.data!.ecoscoreGrade ?? 'No data').toUpperCase()}",
//                                     style: const TextStyle(
//                                         // color: getTextColorFromData(snapshot.data?.ecoscoreGrade),
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                   const Text("Environmental impact for this product is: " ,
//                                       softWrap: true
//                                   ),
//                                   Text("Score: ${snapshot.data!.ecoscoreScore ?? 'No data' }/100", style: const TextStyle(fontWeight: FontWeight.bold),),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Card(
//                         color: Colors.white,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: CircleAvatar(
//                                   child: Icon(Icons.local_grocery_store, color: Theme.of(context).primaryColor,),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 3,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   // mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text("Ingredients",
//                                       style: TextStyle(
//                                           color: Theme.of(context).primaryColor,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold
//                                       ),
//                                     ),
//                                     Text("${snapshot.data!.ingredients ?? 'No data' }" ,
//                                       softWrap: true,
//                                       maxLines: 10,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
// // =======
// // >>>>>>> master
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  child: Icon(Icons.emoji_food_beverage, color: Theme.of(context).primaryColor,),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Categories",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text("${snapshot.data!.categories ?? 'No data' }" ,
                                      softWrap: true,
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  child: Icon(Icons.restaurant_menu,
                                      color: Theme.of(context).primaryColor,
                                      // color: Color.fromRGBO(255, 135, 0, 1.0),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Allergens",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          // color: Color.fromRGBO(255, 135, 0, 1.0),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text("${snapshot.data!.allergens ?? 'No data' }" ,
                                      softWrap: true,
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 35,
                                        color: Colors.green,
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text('1',
                                              style: TextStyle(
                                                // fontSize: 18,
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 25,
                                        height: 35,
                                        color: Color.fromRGBO(255, 200, 0, 1.0),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text('2',
                                              style: TextStyle(
                                                // fontSize: 18,
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 25,
                                        height: 35,
                                        color: Colors.orange,
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text('3',
                                              style: TextStyle(
                                                // fontSize: 18,
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 25,
                                        height: 35,
                                        // width: container4Size,
                                        color: Colors.red,
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text('4',
                                              style: TextStyle(
                                                // fontSize: 18,
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nova Groups",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            width: 40,
                                            height: 70,
                                            decoration: BoxDecoration(
                                            color: getNovaColorFromData(snapshot.data!.novaGroup),
                                            border: Border.all(color: Colors.black, width: 3),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text('${snapshot.data!.novaGroup ?? 'No data'}',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5,),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Group: ${snapshot.data!.novaGroup ?? 'No data'}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: getNovaColorFromData(snapshot.data!.novaGroup),
                                                ),
                                              ),
                                              Text( getTextFromData(snapshot.data!.novaGroup),
                                                style: TextStyle(
                                                  // fontSize: 16,
                                                  // fontWeight: FontWeight.bold,
                                                  color: getNovaColorFromData(snapshot.data!.novaGroup),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  child: Icon(Icons.co2, color: Theme.of(context).primaryColor, size: 35),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Carbon Footprint",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text("${snapshot.data!.carbonFootprint ?? 'No data' }" ,
                                      softWrap: true,
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  child: Icon(Icons.archive, color: Theme.of(context).primaryColor,),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Packaging",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text("${snapshot.data!.packaging ?? 'No data' }" ,
                                      softWrap: true,
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                              // const Expanded(
                              //   flex: 1,
                              //   child: CircleAvatar(
                              //     child: Icon(Icons.warning, color: Color.fromRGBO(255, 150, 0, 1.0),),
                              //   ),
                              // ),
                              // Expanded(
                              //   flex: 3,
                              //   child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Row(
                                      children: [
                                        CircleAvatar(
                                            child: Icon(Icons.warning, color: Color.fromRGBO(255, 150, 0, 1.0),),
                                          ),
                                        SizedBox(width: 10,),
                                        Text("Warning!",
                                          style: TextStyle(
                                              color: Color.fromRGBO(255, 150, 0, 1.0),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                        scrollDirection: Axis.vertical,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data!.warnings?.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: Icon(Icons.circle, size: 15, color: Color.fromRGBO(255, 150, 0, 1.0),),
                                            subtitle: Text("${snapshot.data!.warnings?[index] ?? 'No data' }" ,
                                              softWrap: true,
                                              maxLines: 10,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              // ),
                          //   ],
                          // ),
                        ),
                      ),
                      // Text("Allergens: ${snapshot.data!.allergens ?? 'No data'}"),
                      // Text("Carbon Footprint: ${snapshot.data!.carbonFootprint ?? 'No data' }"),
                      // Text("Categories: ${snapshot.data!.categories ?? 'No data' }"),
                      // Text("countries: ${snapshot.data!.countries ?? 'No data' }"),
                      // Text("Nutri Score: ${snapshot.data!.nutriscoreScore ?? 'No data'}"),
                      // Text("Nutrigrade: ${snapshot.data!.nutriscoreGrade ?? 'No data' }"),
                      //Not keeping countries, nurti score and grade

                      // Text("Eco Score Grade: ${snapshot.data!.ecoscoreGrade ?? 'No data' }"),
                      // Text("ecoscore: ${snapshot.data!.ecoscoreScore ?? 'No data' }"),
                      // Text("Ingredients: ${snapshot.data!.ingredients ?? 'No data' }"),
                      // Text("Nova Group: ${snapshot.data!.novaGroup ?? 'No data'}"),
                      // Text("Packaging: ${snapshot.data!.packaging ?? 'No data' }"),
                      // Text("warning: ${snapshot.data!.warnings ?? 'No data'}"),

                      // Text("nutrient levels: ${snapshot.data!.nutrientLevels ?? 'No data' }"),
                      // Text("Nutriements: ${snapshot.data!.nutriments}"),


                      // Text('Barcode Details: ${snapshot.data}');
                    ],
                  ),
                );
              }
            },
          )
        ),
      ),
    );
  }
}

// Text("Brand: ${snapshot.data!.brands ?? 'No data' }"),
// Text("countries: ${snapshot.data!.countries != null && snapshot.data!.countries!.isNotEmpty ? snapshot.data!.countries?.removeLast() : 'No data' }"),
// Text("data: ${snapshot.data!.allergens != null && snapshot.data!.allergens!.isNotEmpty ? snapshot.data!.allergens?.removeLast() : 'No data'}"),
// != '[]'
// Text("carbon: ${snapshot.data!.carbonFootprint != null && snapshot.data!.carbonFootprint != '' ? snapshot.data!.carbonFootprint : 'No data' }"),
