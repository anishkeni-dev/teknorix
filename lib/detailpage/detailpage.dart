import 'package:flutter/material.dart';
import 'package:teknorix/repository/repository.dart';

import 'detailspage_states.dart';

class DetailPage extends StatefulWidget {
  DetailPage({super.key, this.id});
  var id;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailsPageStates state = DetailsPageInitial();
  ApiRepository repo = ApiRepository();
  Future<dynamic> futureUserData = Future.value();

  getUserData(id) async {
    state = await repo.getUserById(id);
    if (state is DetailsPageLoaded) {
      futureUserData = Future.value((state as DetailsPageLoaded).userData);
    }
    else {
      state = DetailsPageError();
    }
    setState(() {});
  }

  @override
  void initState() {
    state = DetailsPageLoading();
    // TODO: implement initState
    getUserData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Center(
        child: FutureBuilder(
          future: futureUserData,
          builder: (context, snapshot) => state is DetailsPageLoaded &&
                  snapshot.hasData
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the radius to control corner roundness
                        child: Image.network(
                          snapshot.data.avatar,
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.height * 0.5,
                          fit: BoxFit
                              .cover, // You can choose different BoxFit options depending on your needs
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).devicePixelRatio * 10,
                      ),
                      Text("First Name: ${snapshot.data.firstName} ",
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).devicePixelRatio * 10,
                          )),
                      Text("Last Name: ${snapshot.data.lastName} ",
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).devicePixelRatio * 10,
                          )),
                      Text("Id: ${snapshot.data.id}",
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).devicePixelRatio * 10,
                          )),
                      Text("Email: ${snapshot.data.email}",
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).devicePixelRatio * 10,
                          )),
                    ],
                  ),
                )
              : state is DetailsPageError
                  ? Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4),
                      child: Text((state as DetailsPageError).error))
                  : state is DetailsPageLoading
                      ? Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.4),
                          child: CircularProgressIndicator())
                      : Container(),
        ),
      )),
    );
  }
}
