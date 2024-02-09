import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    const assetName = 'assets/images/logo.svg';

    return Scaffold(
      body: Column(
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
                      color: Theme
                          .of(context)
                          .primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Text("Barcode Result : "),
        ],
      ),
    );
  }
}
