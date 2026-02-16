# study_flutter

A Flutter project for studying various Flutter features, including image carousels and WebViews.

## Packages Used

*   **flutter**: The core framework for building Flutter applications.
*   **cupertino_icons**: Provides iOS-style icons.
*   **webview_flutter**: A Flutter plugin for adding a WebView.

## Package Component Usage

### `webview_flutter`
*   **WebViewWidget (widget)**: Renders the web content.
    *   **Properties Used:** `controller`.
*   **WebViewController**: Manages the WebView.
    *   **Methods Used:**
        *   `setJavaScriptMode()`: Sets the JavaScript mode, configured to `JavaScriptMode.unrestricted`.
        *   `loadRequest()`: Loads a specific URL.
