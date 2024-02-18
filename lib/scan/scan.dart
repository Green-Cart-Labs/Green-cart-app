import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_cart/layouts/auth.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cart/layouts/auth.dart';
import 'package:green_cart/scan/productDetails.dart';
import 'package:green_cart/utils/push_with_gradient.dart';
import 'package:camera/camera.dart';
import 'package:green_cart/main.dart';
// import 'package:camerawesome/camerawesome_plugin.dart';
// import 'package:camerawesome/pigeon.dart';

// late List<CameraDescription> _cameras;

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> with WidgetsBindingObserver {
  int _scanBarcodeResult = 0;
  // late CameraController controller;
  // late Future<void> _initializeControllerFuture;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   // _initializeCamera();
  //   // WidgetsBinding.instance?.addObserver(AppLifecycleListener());
  //   controller = CameraController(cameras[0], ResolutionPreset.max);
  //   // Next, initialize the controller. This returns a Future.
  //   _initializeControllerFuture = controller.initialize()
  //       .then((_) {
  //     if (!mounted) {
  //       return;
  //     }
  //     setState(() {});
  //   }).catchError((Object e) {
  //     if (e is CameraException) {
  //       switch (e.code) {
  //         case 'CameraAccessDenied':
  //           print("access was denied");
  //         // Handle access errors here.
  //           break;
  //         default:
  //           print("error: ${e.description}");
  //         // Handle other errors here.
  //           break;
  //       }
  //     }
  //   });
  // }
  //
  // // void onNewCameraSelected(CameraDescription cameraDescription) async {
  // //   if (controller != null) {
  // //     await controller.dispose();
  // //   }
  // //   controller = CameraController(
  // //     cameraDescription,
  // //     ResolutionPreset.medium,
  // //     // enableAudio: enableAudio,
  // //   );
  // //
  // //   // If the controller is updated then update the UI.
  // //   controller.addListener(() {
  // //     if (mounted) setState(() {});
  // //     if (controller.value.hasError) {
  // //       // showInSnackBar('Camera error ${controller.value.errorDescription}');
  // //     }
  // //   });
  // //
  // //   try {
  // //     await controller.initialize();
  // //   } on CameraException catch (e) {
  // //     // _showCameraException(e);
  // //   }
  // //
  // //   if (mounted) {
  // //     setState(() {});
  // //   }
  // // }
  //
  // // @override
  // // void didChangeAppLifecycleState(AppLifecycleState state) {
  // //   // App state changed before we got the chance to initialize.
  // //   if (controller == null || !controller.value.isInitialized) {
  // //     return;
  // //   }
  // //   if (state == AppLifecycleState.inactive) {
  // //     controller?.dispose();
  // //   } else if (state == AppLifecycleState.resumed) {
  // //     if (controller != null) {
  // //       onNewCameraSelected(controller.description);
  // //     }
  // //   }
  // // }
  //
  //
  // // @override
  // // void didChangeAppLifecycleState(AppLifecycleState state) {
  // // final CameraController? cameraController = controller;
  // //
  // // // App state changed before we got the chance to initialize.
  // // if (cameraController == null || !cameraController.value.isInitialized) {
  // // return;
  // // }
  // //
  // // if (state == AppLifecycleState.inactive) {
  // // cameraController.dispose();
  // // } else if (state == AppLifecycleState.resumed) {
  // // // _initializeCameraController(cameraController.description);
  // // _initializeCamera();
  // // }
  // // }
  // //
  // // Future<void> _initializeCamera() async {
  // //   // Initialize camera controller and handle errors
  // //   controller = CameraController(cameras[0], ResolutionPreset.max);
  // //   // Next, initialize the controller. This returns a Future.
  // //   _initializeControllerFuture = controller.initialize()
  // //       .then((_) {
  // //     if (!mounted) {
  // //       return;
  // //     }
  // //     setState(() {});
  // //   }).catchError((Object e) {
  // //     if (e is CameraException) {
  // //       switch (e.code) {
  // //         case 'CameraAccessDenied':
  // //           print("access was denied");
  // //           // Handle access errors here.
  // //           break;
  // //         default:
  // //           print("error: ${e.description}");
  // //           // Handle other errors here.
  // //           break;
  // //       }
  // //     }
  // //   });
  // // }
  //
  // @override
  // void dispose() {
  //   controller.dispose();
  //   // WidgetsBinding.instance?.removeObserver(AppLifecycleListener());
  //   super.dispose();
  // }

  CameraController? _cameraController;
  bool _isCameraReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addObserver(this);
    _disposeCamera();
    super.dispose();
  }

  @override
  void didChangeLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.inactive:
        _disposeCamera();
        print("dispose inactive**");
        break;
      case AppLifecycleState.resumed:
        if (!_isCameraReady) {
          _initializeCamera();
          print("initialize**");
        }
        break;
      case AppLifecycleState.paused:
        _disposeCamera();
        print("dispose pause**");
        break;
        // break;
      default:
        print("default pause**");
        break;
    }
  }

  Future<void> _initializeCamera() async {
    // Check permissions
    // if (!await requestCameraPermission()) {
    //   return; // Handle permission denied case
    // }

    // Get available cameras
    final cameras = await availableCameras();
    final camera = cameras.first;

    // Create the controller
    final controller = CameraController(camera, ResolutionPreset.medium);

    // Initialize the controller
    await controller.initialize();

    setState(() {
      _cameraController = controller;
      _isCameraReady = true;
    });
  }

  void _disposeCamera() {
    _cameraController?.dispose();
    _cameraController = null;
    _isCameraReady = false;
  }

  @override
  Widget build(BuildContext context) {
    const assetName = 'assets/images/logo.svg';

    return LayoutBuilder(
      builder: (context, constraints) {
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
            const Text(
              "Scan your barcode",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: constraints.maxHeight * 0.55,
                  // height:(MediaQuery.of(this.context).size.height) / 2.3, //change media query
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:
                    // FutureBuilder<void>(
                    //   future: _initializeControllerFuture,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.done) {
                    //       // If the Future is complete, display the preview.
                    //       return CameraPreview(controller);
                    //     } else {
                    //       // Otherwise, display a loading indicator.
                    //       return const Center(child: CircularProgressIndicator());
                    //     }
                    //   },
                    // ),
                    _cameraController != null
                    ? Opacity(
                        opacity: 0.5 ,
                        child: CameraPreview(_cameraController!)
                    )
                    : Center(
                        child: Container(
                          width: 70,
                          height: 70,
                          child: CircularProgressIndicator(),
                        ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: double.infinity,
                    height: constraints.maxHeight * 0.55,
                    // height: (MediaQuery.of(this.context).size.height) / 2.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await scanBarcodeNormal();
                              if (_scanBarcodeResult != 0 && _scanBarcodeResult != '-1') {
                                print(_scanBarcodeResult);
                                try {
                                  // ProductDetails();

                                  if (mounted) pushPageWithGradient(context, child: ProductDetails(_scanBarcodeResult));
                                  print("Product details");
                                } catch (e) {
                                  print("error: $e");
                                }
                              }
                              else {
                                // if (mounted) context.go('/scan');
                              }
                            },
                            // scanBarcodeNormal,
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                            ),
                            child: Text('Scan', style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text("Place a barcode inside the viewfinder rectangle to scan it.", textAlign: TextAlign.center),
            Text("Barcode Result : $_scanBarcodeResult"),
          ],
        );
      }
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#295B3E", "Cancel", true, ScanMode.BARCODE);

      int? parsedResult = int.tryParse(barcodeScanRes);
      if (parsedResult != null) {
        setState(() {
          // _scanBarcodeResult = parsedResult.toString();
          _scanBarcodeResult = parsedResult;
        });
      } else {
        setState(() {
          // _scanBarcodeResult = "Failed to parse barcode as an integer";
          log('Failed to parse barcode as an integer');
        });
      }
    } on PlatformException {
      barcodeScanRes = "Failed to get platform version";
    }
    // setState(() {
    //   _scanBarcodeResult = barcodeScanRes;
    // });
  }
}
