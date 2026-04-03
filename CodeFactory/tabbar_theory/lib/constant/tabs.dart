import 'package:flutter/material.dart';

class TabInfo {
  final IconData icon;
  final String label;

  const TabInfo({required this.icon, required this.label});
}

const TABs = [
  TabInfo(icon: Icons.abc, label: "지갑"),
  TabInfo(icon: Icons.abc, label: "알람"),
  TabInfo(icon: Icons.key, label: "키보드"),
  TabInfo(icon: Icons.temple_hindu_rounded, label: "온도"),
  TabInfo(icon: Icons.adb, label: "안드로이드"),
];
