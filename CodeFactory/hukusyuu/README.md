# google_map

A simple Flutter application that uses Google Maps to check if a user is within a certain distance of a location.

## Packages Used

*   **flutter**: The core framework for building Flutter applications.
*   **cupertino_icons**: Provides iOS-style icons.
*   **google_maps_flutter**: A Flutter plugin for integrating Google Maps.
*   **geolocator**: A Flutter plugin for location services.

## Package Component Usage

### `geolocator`
*   **Geolocator (static class)**:
    *   `getPositionStream()`: Listens for real-time location updates.
    *   `distanceBetween()`: Calculates the distance in meters between two geographic coordinates.
    *   `isLocationServiceEnabled()`: Checks if the device's location service is enabled.
    *   `checkPermission()`: Checks the current location permission status.
    *   `requestPermission()`: Requests location permission from the user.
    *   `getCurrentPosition()`: Fetches the current device location once.
*   **LocationPermission (enum)**: Represents the location permission status (e.g., `denied`, `whileInUse`).

### `google_maps_flutter`
*   **GoogleMap (widget)**: Displays the map.
    *   **Properties Used:** `initialCameraPosition`, `mapType`, `myLocationEnabled`, `myLocationButtonEnabled`, `zoomControlsEnabled`, `onMapCreated`, `markers`, `circles`.
*   **GoogleMapController**: Programmatically controls the map camera.
    *   `animateCamera()`: Animates the camera to a new position.
*   **CameraPosition**: Defines the camera's position and zoom level.
    *   **Properties Used:** `target`, `zoom`.
*   **LatLng**: Represents a geographical coordinate (latitude and longitude).
*   **Marker**: A marker icon on the map.
    *   **Properties Used:** `markerId`, `position`.
*   **Circle**: A circle shape on the map.
    *   **Properties Used:** `circleId`, `center`, `radius`, `fillColor`, `strokeColor`, `strokeWidth`.
*   **CameraUpdate**: Used to update the camera position.
    *   `newLatLng()`: Creates a camera update to a new `LatLng`.
