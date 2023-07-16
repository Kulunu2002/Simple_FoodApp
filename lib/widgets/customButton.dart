import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final onPressed;
  final buttonText;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    

    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.purple[800]),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: buttonText
      ),
    );
  }
}
