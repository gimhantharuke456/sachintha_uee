import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sachintha_uee/services/custom_location_service.dart';
import 'package:sachintha_uee/utils/constants.dart';

class MapScreen extends StatefulWidget {
  final LatLng initialPosition;
  final bool canEdit;
  final bool isRoute;
  final Function(LatLng)? onLocationPicked;
  const MapScreen({
    super.key,
    required this.initialPosition,
    required this.canEdit,
    this.onLocationPicked,
    this.isRoute = true,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> markers = {};
  LatLng? currentLocation;
  LatLng selectedLocation = LatLng(0.0, 0.0);
  List<LatLng> polyLineCoordinates = [];
  void getPolyLines() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(
        widget.initialPosition.latitude,
        widget.initialPosition.latitude,
      ),
      PointLatLng(
        currentLocation!.latitude,
        currentLocation!.latitude,
      ),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((element) {
        polyLineCoordinates.add(LatLng(
          element.latitude,
          element.latitude,
        ));
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    if (!widget.canEdit) {
      setState(() {
        markers.add(
          Marker(
            markerId: const MarkerId("source"),
            position: LatLng(
              widget.initialPosition.latitude,
              widget.initialPosition.longitude,
            ),
          ),
        );
      });
    }
    if (widget.isRoute) {
      CustomLocationService().getCurrentLocation().then((value) {
        setState(() {
          currentLocation = LatLng(value.latitude, value.longitude);
        });
        getPolyLines();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.initialPosition.latitude,
          widget.initialPosition.longitude,
        ),
        zoom: 14.5,
      ),
      markers: markers,
      polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          points: polyLineCoordinates,
          color: successColor,
          width: 6,
        )
      },
      onTap: (LatLng tappedPoint) {
        if (widget.canEdit) {
          setState(() {
            selectedLocation = tappedPoint;
            if (widget.onLocationPicked != null) {
              widget.onLocationPicked!(selectedLocation);
            }
            markers = {};
            markers.add(
              Marker(
                markerId: const MarkerId(
                  "selected_location",
                ),
                position: selectedLocation,
              ),
            );
          });
        }
      },
    );
  }
}
