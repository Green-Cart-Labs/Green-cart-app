// dashboard.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../layouts/auth.dart';
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

    return Stack(
      children: [
        const AuthGlobalWidget(),
        SingleChildScrollView(
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
                color: Colors.deepPurple,
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
            const SizedBox(height: 15,),
            GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              physics: ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index){
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset(assetName),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Column(
                          children: [
                            Text("dataName"),
                            Text("dataName"),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            ),
          ],
        ),
      ),]
    );
  }
}
