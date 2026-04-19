import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_page/constants/colors.dart';
import 'package:home_page/constants/size.dart';
import 'package:home_page/constants/skill_items.dart';
import 'package:home_page/widgets/drawer_mobile.dart';
import 'package:home_page/widgets/header_desktop.dart';
import 'package:home_page/widgets/header_mobile.dart';
import 'package:home_page/widgets/main_desktop.dart';
import 'package:home_page/widgets/main_mobile.dart';
import 'package:home_page/widgets/skills_desktop.dart';
import 'package:home_page/widgets/skills_mobile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: CustomColor.scaffoldBg,
          endDrawer: constraints.maxWidth >= kMinDesktopWidth
              ? null
              : const DrawerMobile(),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              //Main
              if (constraints.maxWidth >= kMinDesktopWidth) ...[
                const HeaderDesktop(),
                const MainDesktop(),
              ] else ...[
                HeaderMobile(
                  onLogoTap: () {},
                  onMenuTap: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                ),
                const MainMobile(),
              ],

              //Skills
              Container(
                width: screenWidth,
                color: CustomColor.bgLight1,
                padding: EdgeInsets.fromLTRB(24, 20, 25, 60),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //Title
                    Text(
                      'What I can do',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.whitePrimary,
                      ),
                    ),

                    const SizedBox(height: 50.0),

                    //PlatForms and Skills
                    if (constraints.maxWidth >= kMedDesktopWidth)
                      const SkillsDesktop()
                    else
                      const SkillsMobile(),
                  ],
                ),
              ),
              //Projects
              Container(height: 500, width: double.maxFinite),
              //Contact
              Container(
                height: 500,
                width: double.maxFinite,
                color: Colors.blueGrey,
              ),
              //Footer
              Container(height: 500, width: double.maxFinite),
            ],
          ),
        );
      },
    );
  }
}
