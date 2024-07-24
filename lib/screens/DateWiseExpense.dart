// ignore: file_names
import 'package:e_commerce/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Datewiseexpense extends StatefulWidget  implements PreferredSizeWidget {
  
  final double height;

   const Datewiseexpense({
    super.key,
    
    this.height = kToolbarHeight,
  });

  @override
  State<Datewiseexpense> createState() => _DatewiseexpenseState();
  
  @override
 
  Size get preferredSize => throw UnimplementedError();
}

class _DatewiseexpenseState extends State<Datewiseexpense> {
  final TextEditingController _datepickController = TextEditingController();

  Size get preferredSize => Size.fromHeight(widget.height);

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150,
            color: Colors.orange,
            alignment: Alignment.center,
            child: TextField(
              
             readOnly: true,
              controller: _datepickController,
              decoration: InputDecoration(
                prefixIcon: GestureDetector(
                  onTap: _selectDate, child: const Icon(Icons.calendar_today,color: white,)),
                hintText: 'Date',
                hintStyle: const TextStyle(color: white),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none
                ),
                ),
            ),
          ),
          Container(
            color: lightBrown,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(
                    color: white
                  ),
                  child: const Center(child: Text('1')),
                ),
                 Container(
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(color: white),
                  child: const Center(child: Text('2')),
                ),
                 Container(
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(color: white),
                  child: const Center(child: Text('3')),
                ),
                 Container(
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(color: white),
                  child: const Center(child: Text('4')),
                ),
                 Container(
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(color: white),
                  child: const Center(child: Text('5')),
                ),
                
              ],
            ),
          ),
          const SizedBox(
            height: 240,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Bharath BENZ V1 -', style: TextStyle(fontSize: 16)),
                   SizedBox(
                      width: 30,
                    ),
                  Text('10', style: TextStyle(fontSize: 16))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Bharath BENZ V2 -',style: TextStyle(fontSize: 16),),
                   SizedBox(
                      width: 30,
                    ),
                  Text('10', style: TextStyle(fontSize: 16))
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Taurus          -', style: TextStyle(fontSize: 16)),
                  SizedBox(width: 30,),
                  Text('10', style: TextStyle(fontSize: 16))
                ],
              ),
            ],
          ),
          
          ),
           Align(
            alignment: Alignment.bottomRight,
             child: FloatingActionButton.small(
              onPressed: () {},
              backgroundColor: orange,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.add,
                color: white,
              ),
                       ),
           ),
         
        ],
      ),
      
    );
  }

  Future <void> _selectDate()async{
    DateTime? picked = await showDatePicker(
    context: context, 
    initialDate: DateTime.now(),
    firstDate: DateTime(2000), 
    lastDate: DateTime(2099));
    if (picked!=null){
      setState(() {
        _datepickController.text = DateFormat('yyyy-MM-dd').format(picked);
      });

    }
  }
}