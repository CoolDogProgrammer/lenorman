import 'package:flutter/material.dart';

class LoadingMealWidget extends StatelessWidget {
  const LoadingMealWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Mohon bersabar Mindful Pantry sedang membuatkan resep untuk anda',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Text color
          ),
          textAlign: TextAlign.center,),
        const SizedBox(height: 8),
        Text('', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 32),
        const LinearProgressIndicator()
      ],
    );
  }
}