import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logysto_app/blocs/auth/bloc/auth_bloc.dart';
import 'package:logysto_app/blocs/weather/bloc/weather_bloc.dart';

import '../constants.dart';
import 'Address.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController listController;

  List<String> items = [];

  Set<Marker> _markers = Set();
  AddressItem _currentAddress =
      const AddressItem("0", "Recent", "Find address", 0.0, 0.0);

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(25.761681, -80.191788),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    _markers.add(
      const Marker(
        markerId: MarkerId('miami'),
        position: LatLng(25.761681, -80.191788),
        draggable: true,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    listController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              width: double.infinity,
              height: kToolbarHeight,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: findDirection(),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 15),
                                child: SizedBox(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, // or use fixed size like 200
                                  height:
                                      MediaQuery.of(context).size.height * 0.45,
                                  child: _buildMap(context),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                child: BlocBuilder<WeatherBloc, WeatherState>(
                                    builder: (context, state) {
                                  if (state is WeatherFound) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0, right: 10),
                                                child: Text(
                                                  "Feels Like",
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 10,
                                                          bottom: 0,
                                                          top: 0),
                                                  child: Text(
                                                    state.weather.feels_like,
                                                    textAlign: TextAlign.left,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0, right: 10),
                                                child: Text(
                                                  "Humidity",
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 10,
                                                          bottom: 0,
                                                          top: 0),
                                                  child: Text(
                                                    state.weather.humidity,
                                                    textAlign: TextAlign.left,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0, right: 10),
                                                child: Text(
                                                  "Humidity",
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 10,
                                                          bottom: 0,
                                                          top: 0),
                                                  child: Text(
                                                    state.weather.humidity,
                                                    textAlign: TextAlign.left,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0, right: 10),
                                                child: Text(
                                                  "Temperature Max",
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 10,
                                                          bottom: 0,
                                                          top: 0),
                                                  child: Text(
                                                    state.weather.temp_max,
                                                    textAlign: TextAlign.left,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0, right: 10),
                                                child: Text(
                                                  "Temperature Min",
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 10,
                                                          bottom: 0,
                                                          top: 0),
                                                  child: Text(
                                                    state.weather.temp_min,
                                                    textAlign: TextAlign.left,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0, right: 10),
                                                child: Text(
                                                  "Temperature",
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 10,
                                                          bottom: 0,
                                                          top: 0),
                                                  child: Text(
                                                    state.weather.temp,
                                                    textAlign: TextAlign.left,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0, right: 10),
                                                child: Text(
                                                  "Pressure",
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 10,
                                                          bottom: 0,
                                                          top: 0),
                                                  child: Text(
                                                    state.weather.pressure,
                                                    textAlign: TextAlign.left,
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                  if (state is WeatherSending) {
                                    return const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          primary),
                                    );
                                  } else {
                                    return Container();
                                  }
                                })),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: logOut(context)),
            const SizedBox(
              width: double.infinity,
              height: kToolbarHeight,
            ),
          ],
        ),
      ),
    );
  }

  /// button for send login data
  Widget logOut(context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: primary, width: 1.0)),
      color: primary,
      textColor: Colors.white,
      padding: const EdgeInsets.all(8.0),
      onPressed: () async {
        BlocProvider.of<AuthBloc>(context).add(const LogOut());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8, bottom: 10, top: 10),
            child: Text(
              'Log Out',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget findDirection() {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: Color(0xFFEAEAEA), width: 1.0)),
      color: const Color(0xFFEAEAEA),
      textColor: Colors.white,
      padding: const EdgeInsets.all(8.0),
      onPressed: () async {
        Prediction? p = await PlacesAutocomplete.show(
            offset: 0,
            radius: 1000,
            types: [],
            strictbounds: false,
            region: "ar",
            context: context,
            apiKey: "",
            mode: Mode.overlay,
            language: "en",
            components: []);
        if (p != null) {
          GoogleMapsPlaces _places =
              GoogleMapsPlaces(apiKey: ""); //Same API_KEY as above
          PlacesDetailsResponse detail =
              await _places.getDetailsByPlaceId(p.placeId!);
          double latitude = detail.result.geometry!.location.lat;
          double longitude = detail.result.geometry!.location.lng;
          _goToTheLocation(latitude, longitude);

          BlocProvider.of<WeatherBloc>(context).add(SendWeather(
              latitude: latitude.toString(), longitude: longitude.toString()));

          setState(() {
            _currentAddress = AddressItem(
                "0",
                "Recent",
                p.description!,
                detail.result.geometry!.location.lat,
                detail.result.geometry!.location.lng);
          });
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const FaIcon(FontAwesomeIcons.search, color: Color(0xFF464646)),
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 10, top: 10),
            child: Text(
              _currentAddress.detail.length > 32
                  ? _currentAddress.detail.substring(0, 32) + "..."
                  : _currentAddress.detail,
              style: const TextStyle(
                color: Color(0xFF464646),
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _markers,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Future<void> _goToTheLocation(lat, lon) async {
    CameraPosition temp = CameraPosition(
      target: LatLng(lat, lon),
      zoom: 14.4746,
    );

    setState(() {
      _kGooglePlex = temp;
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId(_currentAddress.detail),
        position: LatLng(lat, lon),
        draggable: true,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }
}
