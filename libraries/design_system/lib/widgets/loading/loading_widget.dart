import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      const Center(
        child: CircularProgressIndicator.adaptive(backgroundColor: Color.fromARGB(0, 13, 255, 0),),
      
    );
  }
}
