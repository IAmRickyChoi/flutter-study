import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_page/constants/colors.dart';
import 'package:home_page/constants/skill_items.dart';

class SkillsDesktop extends StatelessWidget {
  const SkillsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 450),
          child: Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            children: platformItems
                .map(
                  (platform) => Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: CustomColor.bgLight2,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      leading: SvgPicture.asset(platform["img"]!, width: 26.0),
                      title: Text(platform["title"]!),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(width: 50.0),

        //Skills
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
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
        ),
      ],
    );
  }
}
