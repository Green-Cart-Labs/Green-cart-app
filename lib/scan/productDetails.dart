import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_cart/widgets/gradient_container.dart';

class ProductDetails extends StatefulWidget {
  final String child;
  ProductDetails(this.child, {super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    const assetName = 'assets/images/logo.svg';

    return Scaffold(
      body: GradientContainer(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 30.0),
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
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Product Name",
                style: TextStyle(
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
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png',
                  fit: BoxFit.fill,
                ),
                // SvgPicture.asset(assetName, fit: BoxFit.contain,),
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

            ],
          ),
        ),
      ),
    );
  }
}
