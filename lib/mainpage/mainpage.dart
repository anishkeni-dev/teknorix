import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teknorix/repository/repository.dart';
import 'package:teknorix/repository/services.dart';

import '../deatailpage/deatailpage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  ApiRepository repo = ApiRepository();
  Future<dynamic> futureUserData = Future.value();

  //gets main page state and api response data
  getUserData() async {
    var temp = await repo.getUsers();
    futureUserData = Future.value(temp);
    setState(() {});
  }

  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              //show confirm dialogue
              //the return value will be from "Yes" or "No" options
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Exit App'),
                content: Text('Do you want to exit an App?'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    //return false when click on "NO"
                    child: const Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () => SystemNavigator.pop(),
                    //return true when click on "Yes"
                    child: Text('Yes'),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Main Page",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(children: [
            FutureBuilder(
              future: futureUserData,
              builder: (context, snapshot) => snapshot.hasError
                  ? const Text("Something went wrong!")
                  : snapshot.hasData?
                       SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Container(
                                  padding: const EdgeInsets.only(left: 10,top: 10,right: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(id: snapshot.data[index].id),));
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            //image
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  10.0), // Adjust the radius to control corner roundness
                                              child: Image.network(
                                                snapshot.data[index].avatar,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2,
                                                fit: BoxFit
                                                    .cover, // You can choose different BoxFit options depending on your needs
                                              ),
                                            ),
                                            //name
                                            Container(
                                              margin: const EdgeInsets.only(left: 20),
                                              child: Text(
                                                snapshot.data[index].firstName +" "+ snapshot.data[index].lastName,
                                                style:  TextStyle(
                                                  fontSize: MediaQuery.of(context).devicePixelRatio*8,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                            itemCount: snapshot.data.length),
                      )
                      : const CircularProgressIndicator(
                              color: Colors.white,
                            )

            )
          ]),
        )),
      ),
    );
  }
}
