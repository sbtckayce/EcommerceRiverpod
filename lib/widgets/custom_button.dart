

import 'package:e_commerce/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed, });
  final String text;
  final VoidCallback onPressed;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        
        style: ElevatedButton.styleFrom(
          
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
        ),
        onPressed: onPressed, child: Text(text,style:Theme.of(context).textTheme.titleSmall!.copyWith(color: Coloors.whiteColor,fontWeight: FontWeight.bold))),
    );
  }
}