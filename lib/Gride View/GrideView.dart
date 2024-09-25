import 'package:e_commerce/Gride%20View/Vehicledetailsgrid1.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/screens/select/driverselect.dart';
import 'package:e_commerce/screens/select/loaddetailselect.dart';
import 'package:e_commerce/screens/select/refuelselect.dart';
import 'package:e_commerce/screens/select/serviceselect.dart';
import 'package:e_commerce/widgets/customappbar.dart';
import 'package:flutter/material.dart';

class Grideview extends StatelessWidget {
  const Grideview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Taurus',
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            _buildRow(
                context,
                const TFuelselect(),
                'Refuel',
                'assets/images/fuel.jpg',
                const TServiceselect(),
                'Service',
                'assets/images/service.jpg'),
            const SizedBox(
              height: 30,
            ),
            _buildRow(
                context,
                const Loaddetailselect(),
                'Load',
                'assets/images/load.jpg',
                const TDriverselect(),
                'Driver',
                'assets/images/driver.jpg'),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Vehicledetailsgrid1()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 21),
                    child: _buildCard(
                        'Vehicle Details', 'assets/images/vehicledetails.jpg'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, Widget screen1, String title1,
      String image1, Widget screen2, String title2, String image2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen1),
            );
          },
          child: _buildCard(title1, image1),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen2),
            );
          },
          child: _buildCard(title2, image2),
        ),
      ],
    );
  }

  Widget _buildCard(String title, String imagePath) {
    return Container(
      height: 100,
      width: 155,
      decoration: BoxDecoration(
        color: black,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black
                .withOpacity(0.5), // Adjust the opacity to dim the image
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              color: white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
