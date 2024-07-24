import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:e_commerce/widgets/customtextform.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var w =MediaQuery.sizeOf(context).width;
    var _emailcontroller =TextEditingController();
    var _passwordcontroller =TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:  Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(left: w * 0.05),
            child: Align(alignment: Alignment.topLeft, child: Text('Welcome',style: TextStyle(color: orange,fontSize: w * 0.075,fontWeight: FontWeight.bold),)),
          ),
          Padding(
            padding:  EdgeInsets.only(left: w * 0.05,top: w * 0.035,bottom: w * 0.07),
            child: Align(
             alignment: Alignment.topLeft, child: Text('Please Enter your Login Details',style: TextStyle(color: grey,fontSize: w *0.039),)),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: CustomTextFormField(controller: _emailcontroller, labeltext:'Email / Phone Number', keyboardType: TextInputType.name, hintText: 'Enter Email / Phone Number',),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: CustomTextFormField(controller: _passwordcontroller, labeltext:'Password', keyboardType: TextInputType.name, hintText: 'Enter Your Password',),
          ),
         
          Align(
            alignment:Alignment.centerRight, child: TextButton(onPressed: (){}, child: const Text('Forget Password? '))),
           SizedBox(height: w * 0.24,),
          CustomTextButton(title: 'Login',width: 300, background: orange, textColor: white, fontSize: 20, onTap:(){}) ,
          SizedBox(height: w* 0.025,),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: w * 0.15),
                child: Text("Don't have an account?",style: TextStyle(fontSize: 16,color: grey),),
              ),
              TextButton(onPressed: (){}, child: Text('Sign Up',style: TextStyle(fontSize: 16,color: blue),))
            ],
          )
          // TextField(
            
            
          //   decoration: InputDecoration(
          //     labelText:'Email / Phone Number',
          //     hintText:  'enter',
          //     focusColor: orange,
          //     border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))


          //   ),
          // )
        ],
      ),
      )
      
      

    );
  }
}