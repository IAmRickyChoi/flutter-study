import 'package:flutter/material.dart';
import 'package:home_page/constants/colors.dart';
import 'package:home_page/constants/size.dart';
import 'package:home_page/constants/sns_links.dart';
import 'package:home_page/widgets/contact_session.dart';
import 'package:home_page/widgets/drawer_mobile.dart';
import 'package:home_page/widgets/footer.dart';
import 'package:home_page/widgets/header_desktop.dart';
import 'package:home_page/widgets/header_mobile.dart';
import 'package:home_page/widgets/main_desktop.dart';
import 'package:home_page/widgets/main_mobile.dart';
import 'package:home_page/widgets/projects_section.dart';
import 'package:home_page/widgets/skills_desktop.dart';
import 'package:home_page/widgets/skills_mobile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

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
              : DrawerMobile(
                  onNavItemTap: (int navIndex) {
                    //call Function
                    scaffoldKey.currentState?.closeEndDrawer();
                    scrollToSection(navIndex);
                  },
                ),
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(key: navbarKeys.first),
                  //Main
                  if (constraints.maxWidth >= kMinDesktopWidth) ...[
                    HeaderDesktop(
                      onNavMenuTap: (int navIndex) {
                        //call Function
                        scrollToSection(navIndex);
                      },
                    ),
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
                    key: navbarKeys[1],
                    width: screenWidth,
                    color: CustomColor.bgLight1,
                    padding: EdgeInsets.fromLTRB(24, 20, 25, 60),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Title
                        const Text(
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

                  const SizedBox(height: 30),

                  //Projects
                  ProjectsSection(key: navbarKeys[2]),

                  const SizedBox(height: 30),

                  //Contact
                  ContactSession(key: navbarKeys[3]),

                  const SizedBox(height: 30),

                  //Footer
                  const Footer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void scrollToSection(int navIndex) {
    if (navIndex == 4) {
      //open a blog page
      SnsLinks().googleLink();
      return;
    }
    final key = navbarKeys[navIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
