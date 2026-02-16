# vid_player

A Flutter project for selecting and playing videos from the device's gallery.

## Packages Used

*   **flutter**: The core framework for building Flutter applications.
*   **cupertino_icons**: Provides iOS-style icons.
*   **video_player**: A Flutter plugin for video playback.
*   **image_picker**: A Flutter plugin for selecting images/videos.

## Package Component Usage

### `image_picker`
*   **ImagePicker (class)**: Used to access the device's gallery.
    *   **Methods Used:**
        *   `pickVideo()`: Opens the video gallery to let the user select a video. `ImageSource.gallery` is specified as the source.
*   **XFile (class)**: Represents the picked video file.

### `video_player`
*   **VideoPlayer (widget)**: Renders the video frames.
*   **VideoPlayerController**: Controls the video playback.
    *   **Constructors Used:** `file()` to load a video from a local file path.
    *   **Methods Used:** `initialize()`, `addListener()`, `seekTo()`, `pause()`, `play()`.
    *   **Properties Used (via `value`)**: `aspectRatio`, `isPlaying`, `position`, `duration`.
