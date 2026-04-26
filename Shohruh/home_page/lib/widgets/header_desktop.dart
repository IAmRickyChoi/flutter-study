import 'package:flutter/material.dart';
import 'package:home_page/constants/colors.dart';
import 'package:home_page/constants/nav_items.dart';
import 'package:home_page/styles/style.dart';
import 'package:home_page/widgets/site_logo.dart';

class HeaderDesktop extends StatelessWidget {
  const HeaderDesktop({super.key, required this.onNavMenuTap});
  final Function(int) onNavMenuTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      width: double.maxFinite,
      decoration: kHeaderDecoration,
      child: Row(
        children: [
          SiteLogo(onTap: () {}),
          Spacer(),
          ...List.generate(
            navTitles.length,
            (e) => Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(
                onPressed: () {
                  onNavMenuTap(e);
                },
                child: Text(
                  navTitles[e],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.whitePrimary,
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
