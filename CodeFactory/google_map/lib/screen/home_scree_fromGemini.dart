import 'dart:async'; // Completer, StreamSubscription 사용
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 회사 위치 (상수)
  static final LatLng companyLatLng = LatLng(37.5214, 126.9246);

  // 초기 카메라 위치
  final CameraPosition initialPosition = CameraPosition(
    target: companyLatLng,
    zoom: 15,
  );

  // 1. [핵심] Completer 선언
  // "나중에 컨트롤러가 생기면 알려주는 우체통" 같은 역할입니다.
  final Completer<GoogleMapController> _googleMapController = Completer();

  bool choolCheckDone = false;
  bool canChoolCheck = false;
  final double okDistance = 100.0;

  StreamSubscription<Position>? positionStreamSubscription;
  late Future<String> permissionFuture;

  @override
  void initState() {
    super.initState();
    permissionFuture = checkPermission();
    _startLocationStream();
  }

  @override
  void dispose() {
    positionStreamSubscription?.cancel();
    super.dispose();
  }

  void _startLocationStream() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      if (!mounted) return; // 화면이 살아있을 때만 실행

      final start = companyLatLng;
      final end = LatLng(position.latitude, position.longitude);

      final distance = Geolocator.distanceBetween(
        start.latitude,
        start.longitude,
        end.latitude,
        end.longitude,
      );

      setState(() {
        // 100m 이내면 true, 아니면 false
        canChoolCheck = distance < okDistance;
      });
    });
  }

  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return '위치 서비스를 켜주세요.';
    }

    LocationPermission checkPermission = await Geolocator.checkPermission();

    if (checkPermission == LocationPermission.denied) {
      checkPermission = await Geolocator.requestPermission();
    }

    if (checkPermission == LocationPermission.denied ||
        checkPermission == LocationPermission.deniedForever) {
      return '위치 권한을 허가해주세요.';
    }

    return '위치 권한 허가됨';
  }

  // 2. [핵심] 내 위치로 이동하는 로직 (Completer 사용)
  Future<void> myLocationPressed() async {
    final location = await Geolocator.getCurrentPosition();

    // ★ 중요: 컨트롤러가 준비될 때까지 여기서 대기(await)합니다.
    // 지도가 로딩 중이라도 에러가 나지 않고, 로딩이 끝나면 바로 실행됩니다.
    final controller = await _googleMapController.future;

    controller.animateCamera(
      CameraUpdate.newLatLng(LatLng(location.latitude, location.longitude)),
    );
  }

  // 출근 버튼 로직
  Future<void> choolCheckPressed() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('출근하기'),
          content: Text('출근하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
              child: Text('확인'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      setState(() {
        choolCheckDone = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '오늘도 출근',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: myLocationPressed,
            icon: Icon(Icons.my_location),
            color: Colors.blue,
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: permissionFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData && !snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data != '위치 권한 허가됨') {
            return Center(child: Text(snapshot.data ?? '권한 에러 발생'));
          }

          return Column(
            children: [
              Expanded(
                flex: 2,
                child: _GoogleMap(
                  initialCameraPosition: initialPosition,
                  // 3. [핵심] 지도가 생성되면 Completer 완료 처리
                  onMapCreated: (GoogleMapController controller) {
                    _googleMapController.complete(controller);
                  },
                  canChoolCheck: canChoolCheck,
                  okDistance: okDistance,
                  companyLatLng: companyLatLng,
                ),
              ),
              Expanded(
                flex: 1,
                child: _BottomChoolcheck(
                  canChoolCheck: canChoolCheck,
                  choolCheckDone: choolCheckDone,
                  choolCheckPressed: choolCheckPressed,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GoogleMap extends StatelessWidget {
  final CameraPosition initialCameraPosition;
  final MapCreatedCallback onMapCreated;
  final double okDistance;
  final bool canChoolCheck;
  final LatLng companyLatLng;

  const _GoogleMap({
    super.key,
    required this.initialCameraPosition,
    required this.onMapCreated,
    required this.okDistance,
    required this.canChoolCheck,
    required this.companyLatLng,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: onMapCreated,
      markers: {
        Marker(
          markerId: MarkerId('company'),
          position: companyLatLng,
        ),
      },
      circles: {
        Circle(
          circleId: CircleId('inDistance'),
          center: companyLatLng,
          radius: okDistance,
          fillColor: canChoolCheck
              ? Colors.blue.withAlpha(100)
              : Colors.red.withAlpha(100),
          strokeColor: canChoolCheck ? Colors.blue : Colors.red,
          strokeWidth: 1,
        ),
      },
    );
  }
}

class _BottomChoolcheck extends StatelessWidget {
  final bool choolCheckDone;
  final bool canChoolCheck;
  final VoidCallback choolCheckPressed;

  const _BottomChoolcheck({
    super.key,
    required this.canChoolCheck,
    required this.choolCheckDone,
    required this.choolCheckPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          choolCheckDone ? Icons.check : Icons.timelapse_outlined,
          color: choolCheckDone ? Colors.green : Colors.blue,
          size: 50,
        ),
        SizedBox(height: 16.0),
        if (!choolCheckDone && canChoolCheck)
          OutlinedButton(
            onPressed: choolCheckPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue,
            ),
            child: Text('출근하기'),
          ),
        if (!choolCheckDone && !canChoolCheck)
          Text('회사 근처로 와주세요!', style: TextStyle(color: Colors.red)),
      ],
    );
  }
}
