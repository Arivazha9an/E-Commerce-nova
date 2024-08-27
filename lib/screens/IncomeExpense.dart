
import 'package:e_commerce/constants/colors.dart';

import 'package:e_commerce/screens/forms/retrieve/customerretrivehover.dart';
import 'package:e_commerce/screens/forms/retrieve/supplierretrievehover.dart';

import 'package:e_commerce/widgets/customcolorappbar.dart';
import 'package:flutter/material.dart';

class IncomeExpense extends StatefulWidget {
  const IncomeExpense({super.key});

  @override
  State<IncomeExpense> createState() => _IncomeExpenseState();
}

class _IncomeExpenseState extends State<IncomeExpense> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarcolor(
        height: 185,
        title: '',
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: white),
                    hintText: 'Search',
                    suffixIcon: const Icon(
                      Icons.search,
                      color: white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: const BorderSide(
                          color: white, style: BorderStyle.solid),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: const BorderSide(
                          color: white, style: BorderStyle.solid),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: const BorderSide(
                          color: white, style: BorderStyle.solid),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextButton("Customer ", 0),
                _buildTextButton("Supplier", 1),
              ],
            ),
          ],
        ),
      ),
      body: Expanded(
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: const [
            Customerretrivehover(),
            Supplierretrievehover(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextButton(String text, int page) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          page,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: AnimatedDefaultTextStyle(
        style: TextStyle(
          fontSize: 20,
          color: _currentPage == page ? Colors.blue : Colors.black,
          decoration: _currentPage == page
              ? TextDecoration.underline
              : TextDecoration.none,
        ),
        duration: Duration(milliseconds: 300),
        child: Text(
          text,
          style: TextStyle(fontSize: 22, color: white),
        ),
      ),
    );
  }
}
