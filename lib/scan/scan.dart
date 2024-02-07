import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cart/scan/productDetails.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String _scanBarcodeResult = '';

  @override
  Widget build(BuildContext context) {
    const assetName = 'assets/images/logo.svg';

    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    assetName,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "BLOOM",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () async {
                await scanBarcodeNormal();

                if (_scanBarcodeResult.isNotEmpty){
                  print("Product Details");

                  GoRouter.of(context).go('/product');

                  print("Product Details");
                  // context.go('/product');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ProductDetails()),
                  // );
                }
              },
              // scanBarcodeNormal,
              child: Text('Scan'),
            ),
            Text("Barcode Result : $_scanBarcodeResult"),
          ],
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#295B3E",
          "Cancel",
          true,
          ScanMode.BARCODE
      );
    } on PlatformException {
      barcodeScanRes = "Failed to get platform version";
    }
    setState(() {
      _scanBarcodeResult = barcodeScanRes;
    });
  }
}

