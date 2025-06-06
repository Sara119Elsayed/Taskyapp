import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {

  const CustomTextFiled({super.key,required this.textData , this.hintTextData,this.size,this.textcolor,
  this.hintcolor,this.validator,required this.controller,this.maxLines
});
  
  final String? textData ;
  final String? hintTextData;
  final double? size;
  final int? textcolor ;
  final int? hintcolor;
  final TextEditingController controller;
  final Function(String?)? validator;
  final int? maxLines;

   
   

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
               "$textData",
               style: Theme.of(context).textTheme.titleMedium  
            ),

            SizedBox(
              height: 8,
            ),
         
           TextFormField(
            controller:controller,
            maxLines: maxLines,
            style: Theme.of(context).textTheme.labelMedium,
            decoration: InputDecoration(
              hintText: hintTextData,
            ),
           
           )
        
          ],
     
    );
  }
}
