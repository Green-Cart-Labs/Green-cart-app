import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../scan/productDetails.dart';

void pushPageWithGradient(final BuildContext context, {required final Widget child}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => child));
}