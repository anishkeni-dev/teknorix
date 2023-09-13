import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../mainpage/mainpage.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool status = true;

  checkConnectivity()async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      status = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      status = true;
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      status = true;
    } else if (connectivityResult == ConnectivityResult.vpn) {
      status = true;
    }else if (connectivityResult == ConnectivityResult.none) {
      status = false;
    }
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkConnectivity();
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
          const Text("Start",style: TextStyle(color: Colors.white,fontSize: 18)),
          ElevatedButton(onPressed:(){
            status==true? Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),)):null;
          }, child: const Icon(Icons.play_arrow,color: Colors.black,)),
              status==false?const Center(child: Text("the button will be enabled when you're online", style: TextStyle(color: Colors.white,fontSize: 18,),)):SizedBox(),
        ]),
      ),
    );
  }
}
