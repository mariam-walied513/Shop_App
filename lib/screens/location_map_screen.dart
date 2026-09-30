import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationMapScreen extends StatefulWidget {
  final LatLng? initialLocation;

  const LocationMapScreen({
    super.key,
    this.initialLocation,
  });

  @override
  State<LocationMapScreen> createState() =>
      _LocationMapScreenState();
}

class _LocationMapScreenState
    extends State<LocationMapScreen> {

  // ==========================================================
  // DEFAULT LOCATION
  // ==========================================================

  static const LatLng defaultLocation =
      LatLng(30.0444, 31.2357);

  // ==========================================================
  // SELECTED LOCATION
  // ==========================================================

  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();

    selectedLocation =
        widget.initialLocation;
  }

  @override
  Widget build(BuildContext context) {

    final LatLng mapCenter =
        selectedLocation ??
            defaultLocation;

    return Scaffold(
      backgroundColor: Colors.white,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 21,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          "Select Location",

          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ========================================================
      // MAP
      // ========================================================

      body: Stack(
        children: [

          FlutterMap(
            options: MapOptions(
              initialCenter: mapCenter,
              initialZoom: 13,

              // ==================================================
              // TAP ANYWHERE ON MAP
              // ==================================================

              onTap: (tapPosition, point) {

                setState(() {
                  selectedLocation = point;
                });
              },
            ),

            children: [

              // ==================================================
              // OPEN STREET MAP
              // ==================================================

              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

                userAgentPackageName:
                    'com.example.shopping_app',
              ),

              // ==================================================
              // MARKER
              // ==================================================

              if (selectedLocation != null)
                MarkerLayer(
                  markers: [

                    Marker(
                      point:
                          selectedLocation!,

                      width: 60,
                      height: 65,

                      child: const Icon(
                        Icons.location_on,

                        color:
                            Color(0xFFFF3655),

                        size: 55,
                      ),
                    ),
                  ],
                ),
            ],
          ),

          // ========================================================
          // CONFIRM BUTTON
          // ========================================================

          if (selectedLocation != null)
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,

              child: SizedBox(
                height: 52,

                child: ElevatedButton(
                  onPressed: () {

                    Navigator.pop(
                      context,
                      selectedLocation,
                    );
                  },

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFFF3655),

                    foregroundColor:
                        Colors.white,

                    elevation: 0,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(6),
                    ),
                  ),

                  child: const Text(
                    "Confirm Location",

                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
