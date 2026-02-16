# date_time_app

A simple Flutter application that shows the number of days since a certain date.

## Packages Used

*   **flutter**: The core framework for building Flutter applications.
*   **cupertino_icons**: Provides iOS-style icons.

## Package Component Usage

### `package:flutter/cupertino.dart`

*   **CupertinoDatePicker**: A widget for selecting dates and times.
    *   **Properties Used:**
        *   `maximumDate`: The maximum selectable date.
        *   `initialDateTime`: The initially selected date.
        *   `mode`: The picker mode, set to `CupertinoDatePickerMode.date`.
        *   `onDateTimeChanged`: A callback that is called when the selected date or time changes.
        *   `dateOrder`: The order of the date fields, set to `DatePickerDateOrder.ymd`.
