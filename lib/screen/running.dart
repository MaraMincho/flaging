import 'dart:async';
import 'dart:math';

import 'package:flaging/asset/Profile.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';


class WalkPage extends StatefulWidget {
  const WalkPage({Key? key}) : super(key: key);

  @override
  State<WalkPage> createState() => _WalkPageState();
}


enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED,
  DATA_ADDED,
  DATA_NOT_ADDED,
  STEPS_READY,
}

class _WalkPageState extends State<WalkPage> {
  @override
  Widget build(BuildContext context) {

    List<HealthDataPoint> _healthDataList = [];
    AppState _state = AppState.DATA_NOT_FETCHED;
    int _nofSteps = 10;
    double _mgdl = 10.0;
    // create a HealthFactory for use in the app
    HealthFactory health = HealthFactory();

    /// Fetch data points from the health plugin and show them in the app.
    Future fetchData() async {
      setState(() => _state = AppState.FETCHING_DATA);

      // define the types to get
      final types = [
         HealthDataType.STEPS,
        // HealthDataType.WEIGHT,
        // HealthDataType.HEIGHT,
        // HealthDataType.BLOOD_GLUCOSE,
        // HealthDataType.WORKOUT,
        HealthDataType.ELECTROCARDIOGRAM
        // Uncomment these lines on iOS - only available on iOS
        // HealthDataType.AUDIOGRAM
      ];

      // with coresponsing permissions
      final permissions = [
         HealthDataAccess.READ,
        // HealthDataAccess.READ,
        // HealthDataAccess.READ,
        // HealthDataAccess.READ,
        // HealthDataAccess.READ,
        HealthDataAccess.READ,
        // HealthDataAccess.READ,
      ];

      // get data within the last 24 hours
      final now = DateTime.now();
      final yesterday = now.subtract(Duration(days: 300));
      // requesting access to the data types before reading them
      // note that strictly speaking, the [permissions] are not
      // needed, since we only want READ access.
      bool requested =
      await health.requestAuthorization(types, permissions: permissions);
      print('requested: $requested');

      // If we are trying to read Step Count, Workout, Sleep or other data that requires
      // the ACTIVITY_RECOGNITION permission, we need to request the permission first.
      // This requires a special request authorization call.
      //
      // The location permission is requested for Workouts using the Distance information.
      await Permission.activityRecognition.request();
      await Permission.location.request();

      if (requested) {
        try {
          // fetch health data
          List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(yesterday, now, types);
          // save all the new data points (only the first 100)
          _healthDataList.addAll((healthData.length < 100)
              ? healthData
              : healthData.sublist(0, 100));
        } catch (error) {
          print("Exception in getHealthDataFromTypes: $error");
        }

        // filter out duplicates
        _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

        // print the results
        _healthDataList.forEach((x) => print(x));
        print((_healthDataList.first.value as ElectrocardiogramHealthValue)
            .voltageValues);

        // update the UI to display the results
        setState(() {
          _state =
          _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
        });
      } else {
        print("Authorization not granted");
        setState(() => _state = AppState.DATA_NOT_FETCHED);
      }
    }

    /// Add some random health data.
    Future addData() async {
      final now = DateTime.now();
      final earlier = now.subtract(Duration(minutes: 20));

      final types = [
        HealthDataType.STEPS,
        HealthDataType.HEIGHT,
        HealthDataType.BLOOD_GLUCOSE,
        HealthDataType.WORKOUT, // Requires Google Fit on Android
        // Uncomment these lines on iOS - only available on iOS
        // HealthDataType.AUDIOGRAM,
      ];
      final rights = [
        HealthDataAccess.WRITE,
        HealthDataAccess.WRITE,
        HealthDataAccess.WRITE,
        HealthDataAccess.WRITE,
        // HealthDataAccess.WRITE
      ];
      final permissions = [
        HealthDataAccess.READ_WRITE,
        HealthDataAccess.READ_WRITE,
        HealthDataAccess.READ_WRITE,
        HealthDataAccess.READ_WRITE,
        // HealthDataAccess.READ_WRITE,
      ];
      bool? hasPermissions =
      await HealthFactory.hasPermissions(types, permissions: rights);
      if (hasPermissions == false) {
        await health.requestAuthorization(types, permissions: permissions);
      }

      // Store a count of steps taken
      _nofSteps = Random().nextInt(10);
      bool success = await health.writeHealthData(
          _nofSteps.toDouble(), HealthDataType.STEPS, earlier, now);

      // Store a height
      success &=
      await health.writeHealthData(1.93, HealthDataType.HEIGHT, earlier, now);

      // Store a Blood Glucose measurement
      _mgdl = Random().nextInt(10) * 1.0;
      success &= await health.writeHealthData(
          _mgdl, HealthDataType.BLOOD_GLUCOSE, now, now);

      // Store a workout eg. running
      success &= await health.writeWorkoutData(
        HealthWorkoutActivityType.RUNNING, earlier, now,
        // The following are optional parameters
        // and the UNITS are functional on iOS ONLY!
        totalEnergyBurned: 230,
        totalEnergyBurnedUnit: HealthDataUnit.KILOCALORIE,
        totalDistance: 1234,
        totalDistanceUnit: HealthDataUnit.FOOT,
      );


      setState(() {
        _state = success ? AppState.DATA_ADDED : AppState.DATA_NOT_ADDED;
      });
    }
    /// Fetch steps from the health plugin and show them in the app.
    Future fetchStepData() async {
      int? steps;
      // get steps for today (i.e., since midnight)
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);
      bool requested = await health.requestAuthorization([HealthDataType.STEPS]);

      if (requested) {
        try {
          steps = await health.getTotalStepsInInterval(midnight, now);
        } catch (error) {
          print("Caught exception in getTotalStepsInInterval: $error");
        }
        print('$midnight');
        print('${DateTime.now()}');
        print('Total number of steps: $steps');
        return steps;
      } else {
        print("Authorization not granted - error in authorization");
        setState(() => _state = AppState.DATA_NOT_FETCHED);
      }
    }

    return StreamBuilder(
        stream: Stream.fromFuture(fetchStepData()),
        builder: (context, snapshot) {
          return ListView(
            children: [
              Column(
                children: [
                  ProfileViewer(),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '${snapshot.data} 걸음',
                    style: TextStyle(fontSize: 30),
                  ),
                  GestureDetector(child: Text('ww'),
                    onTap: (){
                    fetchStepData();
                    addData();
                    print("걸음");
                    print(snapshot.data);
                    },
                  ),
                  Container(
                      padding: EdgeInsets.all(23),
                      width: double.infinity,
                      height: 400,
                      child: runningpage()),
                ],
              ),
            ],
          );
        });
  }
}

class runningpage extends StatefulWidget {
  @override
  State<runningpage> createState() => runningpageState();
}

class runningpageState extends State<runningpage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition init = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: init,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}