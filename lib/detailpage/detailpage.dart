import 'package:flutter/material.dart';
import 'package:teknorix/detailpage/detailpage_provider.dart';
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
  DetailPageProvider provider = DetailPageProvider();
  Future<dynamic> futureUserData = Future.value();

  getUserData(id) async {
    state = await provider.getState(widget.id);
    if (state is DetailsPageLoaded) {
      futureUserData = Future.value((state as DetailsPageLoaded).userData);
    } else {
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
              ? Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.55,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://picsum.photos/seed/picsum/200/300?blur=5",
                              scale: 4),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            transform: Matrix4.translationValues(0,
                                MediaQuery.of(context).size.height * 0.25, 0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  bottomRight: Radius.circular(40.0),
                                  topLeft: Radius.circular(40.0),
                                  bottomLeft: Radius.circular(40.0)),
                            ),
                          ),
                          Center(
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          snapshot.data.avatar,
                                        ),
                                        fit: BoxFit.fill
                                        //Text
                                        ),
                                    color: Colors.white,
                                    shape: BoxShape.circle)),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                          transform: Matrix4.translationValues(
                              0, MediaQuery.of(context).size.height * -0.1, 0),
                          child: Text(
                              snapshot.data.firstName +
                                  " " +
                                  snapshot.data.lastName,
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).devicePixelRatio *
                                          20))),
                    ),
                    Container(
                      alignment: Alignment.center,
                      transform: Matrix4.translationValues(
                          0, MediaQuery.of(context).size.height * -0.1, 0),
                      child: Text(
                        snapshot.data.email,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 26),
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(
                          0, MediaQuery.of(context).size.height * -0.05, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "id:" + snapshot.data.id.toString(),
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("About:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          SizedBox(height: 10),
                          Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ],
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
                          child: const CircularProgressIndicator())
                      : Container(),
        ),
      )),
    );
  }
}
