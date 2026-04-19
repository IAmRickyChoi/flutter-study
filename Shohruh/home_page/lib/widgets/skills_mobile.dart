import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_page/constants/colors.dart';
import 'package:home_page/constants/skill_items.dart';

class SkillsMobile extends StatelessWidget {
  const SkillsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500.0),
      child: Column(
        children: [
          //PlatForms
          ...platformItems.map(
            (platformItem) => Container(
              margin: EdgeInsets.only(bottom: 5.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: CustomColor.bgLight2,
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                leading: SvgPicture.asset(platformItem["img"]!, width: 26.0),
                title: Text(platformItem["title"]!),
              ),
            ),
          ),
          SizedBox(height: 50.0),

          //Skills
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            alignment: WrapAlignment.center,
            children: skillItems
                .map(
                  (skillItem) => Chip(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    backgroundColor: CustomColor.bgLight2,
                    label: Text(skillItem["title"]!),
                    avatar: SvgPicture.asset(skillItem["img"]!),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
