import 'package:flutter/material.dart';

import '../mainpage/mainpage.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text("Teknorix Test",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          const Text("Start",style: TextStyle(color: Colors.white)),
          ElevatedButton(onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
          }, child: const Icon(Icons.play_arrow,color: Colors.black,)),
        ]),
      ),
    );
  }
}
