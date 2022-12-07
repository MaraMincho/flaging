import 'dart:async';
import 'dart:ffi';
import 'package:flaging/appvalue.dart';
import 'package:flaging/asset/Profile.dart';
import 'package:flaging/controller/Me.dart';
import 'package:flaging/screen/boardlist.dart';
import 'package:flaging/screen/home_screen.dart';
import 'package:flaging/screen/running.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static final routename = '/MainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentPageIndex = 0; // pageIndex
  Completer<GoogleMapController> _controller = Completer();
  //final FindGetXController = Get.put(UserController()); // controller 등록

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
    final size = MediaQuery.of(context).size;
    final LargeSizeFont = (size.width / 7);
    final MediumSizeFont = (size.width / 15);
    final SmallSizeFont = (size.width / 20);
    return Scaffold(
      appBar: AppBar(
      ),
      body: <Widget> [
       MainPage(),ChatHomeScreen(),WalkPage(),
      ][currentPageIndex],

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
        mapType: MapType.normal,
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

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(23),
      child: Column(
        children: [
          ProfileViewer(), // Profile만들기
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: 50,),
                    //1카드
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text('열심히 걷는 당신 칭찬해~',
                          style: TextStyle(
                              fontSize: 34,
                              letterSpacing: -3
                          ),),
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/icons/img_3.png'),
                          ),
                          boxShadow: [
                            myBoxShadow,
                          ]
                      ),
                    ),
                    SizedBox(height: 30,),


                    GestureDetector(
                      onTap: (){
                        Get.to(BoardList());
                      },
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
        ],
      ),
    );
  }
}
