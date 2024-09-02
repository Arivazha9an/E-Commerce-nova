import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/screens/BottomNavigation.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Welcome'),
      centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 300,
          ),
          Center(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: orange
              ),
              child: TextButton(onPressed: (){
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>BottomNavigationBarExampleApp()),
                );
                 
              }, child: const Text('Click Here',style: TextStyle(color: white),),
                        ),
            )
          )
        ],
      ),
    );
  }
}