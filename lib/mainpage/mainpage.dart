import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teknorix/mainpage/mainpage_provider.dart';
import 'package:teknorix/repository/repository.dart';

import '../detailpage/detailpage.dart';
import 'mainpage_states.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  MainPageProvider provider = MainPageProvider();
  Future<dynamic> futureUserData = Future.value();
  MainPageStates state = MainPageInitial();
  ScrollController controller = ScrollController();
  List responseData = [];
  late var count;

  var size = 4;
  late int maxSize;

  //gets main page state and api response data
  getUserData(int size) async {
    state = await provider.getState(size);
    if (state is MainPageLoaded) {
      responseData = (state as MainPageLoaded).userData;
    } else {
      state = MainPageError();
    }
    setState(() {});
  }

  getMaxSize() async {
    maxSize = await provider.getMaxSize();
    setState(() {});
  }
  getCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    count = prefs.getInt('counter')!;
    setState(() {

    });
  }
  void initState() {
    getCount();
    // TODO: implement initState
    getMaxSize();
    getUserData(size);
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  getmore(size) async {
    await getUserData(size);
    addingMore = false;
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
          leading: IconButton(
              icon: const Icon(
                Icons.rocket_launch_outlined,
                color: Colors.white,
              ),
              onPressed: (){
                // bottom modal sheet four launch count
                 showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        color: Colors.black,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('App Launch Counter',style: TextStyle(color: Colors.white,fontSize: 22),),
                              const Text('App has been launched',style: TextStyle(color: Colors.white,fontSize: 18),),
                              Text("$count times so far!!!",style: const TextStyle(color: Colors.white,fontSize: 18),),

                            ],
                          ),
                        ),
                      );
                    });
              }),
          title: const Text(
            "Main Page",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: state is MainPageLoaded
            ? Scrollbar(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemExtent: MediaQuery.of(context).size.height * 0.3,
                        itemCount: responseData.length,
                        controller: controller,
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.only(
                              left: 10, top: 10, right: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(id: responseData[index].id),
                                  ));
                            },
                            child: Card(
                              color: Colors.white,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    //image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Adjust the radius to control corner roundness
                                      child: Image.network(
                                        responseData[index].avatar,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        fit: BoxFit
                                            .cover, // You can choose different BoxFit options depending on your needs
                                      ),
                                    ),
                                    //name
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      margin: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        responseData[index].firstName +
                                            " " +
                                            responseData[index].lastName,
                                        maxLines: 4,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .devicePixelRatio *
                                                8,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    addingMore ? const CircularProgressIndicator() : SizedBox(),
                  ],
                ),
              )
            : state is MainPageError
                ? Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.4),
                    child: Text((state as MainPageError).error))
                : state is MainPageLoading
                    ? Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.4),
                        child: const CircularProgressIndicator())
                    : Container(),
      ),
    );
  }

  bool addingMore = false;
  void _scrollListener() {
    if (controller.position.extentAfter < controller.position.maxScrollExtent) {
      setState(() {
        addingMore = true;
      });

      if (size < maxSize) {
        size++;
      } else {
        size = maxSize;
      }
      getmore(size);

      setState(() {});
    }
  }
}
