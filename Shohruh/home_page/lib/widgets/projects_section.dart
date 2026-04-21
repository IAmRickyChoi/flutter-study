import 'package:flutter/material.dart';
import 'package:home_page/constants/colors.dart';
import 'package:home_page/utils/project_utils.dart';
import 'package:home_page/widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: EdgeInsets.fromLTRB(24, 20, 25, 60),
      child: Column(
        children: [
          //Work projects title
          const Text(
            'Work Projects',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CustomColor.whitePrimary,
            ),
          ),

          const SizedBox(height: 50),

          //Work projects cards
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 900),
            child: Wrap(
              spacing: 25,
              runSpacing: 25,
              children: [
                ...workProjectUtils.map((e) => ProjectCardWidget(project: e)),

                // ProjectCardWidget(project: workProjectUtils.first),
              ],
            ),
          ),

          const SizedBox(height: 80),

          //Hobby projects title
          const Text(
            'Hobby Projects',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CustomColor.whitePrimary,
            ),
          ),

          const SizedBox(height: 50),

          //Hobby projects cards
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 900),
            child: Wrap(
              spacing: 25,
              runSpacing: 25,
              children: [
                ...hobbyProjectUtils.map((e) => ProjectCardWidget(project: e)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
