import 'dart:async';
import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:flaging/route_generator.gr.dart';
import 'package:flaging/screen/mypage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;
  Completer<GoogleMapController> _controller = Completer();

  final name = '정다함'; //구글 이름 받아오기
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
        child: ListView(
          children: [
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hi \n$name님',
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -1,
                          height: 1),
                        ),
                        SizedBox(width: 40,),
                        GestureDetector(
                          child: PhysicalModel(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            elevation: 5,

                            child: Container(
                              height: 120,
                              width: 120,

                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    'images/imgs/steelo.png'
                                  )
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '오늘도 힘차게 뛰어볼까요?',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: -1.5
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 50,),
                //1카드
                Container(
                  alignment: Alignment.topLeft,
                  child: Text('열심히 걷는 당신 칭찬해~',
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: -1.5
                  ),),
                ),
                PhysicalModel(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  elevation: 10,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage('images/icons/img_3.png'),
                      )
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){AutoRouter.of(context).push(BoardList());},
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text('오늘도 힘차게 뛰어볼까요?',
                      style: TextStyle(
                          fontSize: 25,
                          letterSpacing: -1.5
                      ),),
                  ),
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  child: MapSample(),
                )
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: '',),
          NavigationDestination(icon: Icon(Icons.chat), label: ''),
          NavigationDestination(icon: Icon(Icons.directions_run), label: ''),
          NavigationDestination(icon: Icon(Icons.settings), label: '')
        ],


      ),
    );
  }
}




class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final CameraPosition _lAngels = CameraPosition(
      target: LatLng(37.381111, 126.802245),
      zoom: 15
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('작은 천사들!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_lAngels));
  }
}