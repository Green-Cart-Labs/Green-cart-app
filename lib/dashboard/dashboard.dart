// dashboard.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    const assetName = 'assets/images/logo.svg';

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          const SizedBox(
            height: 60,
          ),
          const Text(
            "Welcome User!",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 28,
              // color: Colors.deepPurple,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //Timeline will come here
          const Text(
            "Timeline will come here",
            style: TextStyle(
              // fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "History",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    side: BorderSide(
                  color: Theme.of(context).primaryColor,
                )),
                child: Text(
                  "Show more",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    // fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.85,
              ),
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: InkWell(
                    onTap: () {
                      print("Tapped");
                    },
                    child: Stack(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child:
                                    // Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png', fit: BoxFit.contain,),
                                    SvgPicture.asset(
                                  assetName,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "productName",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "dataName",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            print("pressed favourite");
                          },
                          icon: const Icon(Icons.favorite_outline, size: 25),
                        ),
                      ),
                    ]),
                  ),
                );
              }),
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Consumer Trends",
            style: TextStyle(
              // color: Theme.of(context).primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Alternate sustainable choices for your top scans",
            style: TextStyle(
              // color: Theme.of(context).primaryColor,
              fontSize: 16,
            ),
          ),
          GridView.builder(
              itemCount: 3,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.35,
                // mainAxisExtent: double.infinity,
                //have to adjust childAspectRatio according to content inside card
              ),
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  // child: InkWell(
                  //   onTap: () {
                  //     print("Tapped");
                  //   },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Kraft Heinz Ketchup",
                                style: TextStyle(
                                  // color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const Text(
                                "Alternative of: Kissan Ketchup",
                                style: TextStyle(
                                  // color: Theme.of(context).primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  const Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      "No ingredients that threaten species ",
                                      style: TextStyle(
                                        // color: Theme.of(context).primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.green,
                                      ),
                                      // overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  ),
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  const Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      "No ingredients that threaten species ",
                                      style: TextStyle(
                                        // color: Theme.of(context).primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.green,
                                      ),
                                      // overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  ),
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  const Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      "No ingredients that threaten species ",
                                      style: TextStyle(
                                        // color: Theme.of(context).primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.green,
                                      ),
                                      // overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          // width: constraints.maxWidth * 0.4,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png',
                                        fit: BoxFit.fill,
                                      ),
                                      // SvgPicture.asset(assetName, fit: BoxFit.contain,),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.loose,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print("pressed Know More");
                                      // Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Theme.of(context).primaryColor),
                                    ),
                                    child: const Text(
                                      "Details",
                                      style: TextStyle(
                                        // fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
          ),
        ],
      ),
    );
  }
}
