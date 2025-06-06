import 'package:flutter/material.dart';

 class CustomElevatedbutton extends StatelessWidget {

  const CustomElevatedbutton({super.key,required this.textData,this.onPressFunc});
  
   final String? textData ; 

  final VoidCallback? onPressFunc;

   @override
   Widget build(BuildContext context) {

    return Column(
          children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width, 40),
            ),
            onPressed:onPressFunc,
            
             child:Text(
              "$textData",
            ),

             ),
          ],
    );
  }
}
