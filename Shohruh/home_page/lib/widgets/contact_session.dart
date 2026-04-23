import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_page/constants/colors.dart';
import 'package:home_page/constants/size.dart';
import 'package:home_page/constants/sns_links.dart';
import 'package:home_page/widgets/custom_text_field.dart';

class ContactSession extends StatelessWidget {
  const ContactSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 20, 25, 60),
      color: CustomColor.bgLight1,
      child: Column(
        children: [
          //Title
          Text(
            'Get in touch',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: CustomColor.whitePrimary,
            ),
          ),

          const SizedBox(height: 50),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 700, maxHeight: 100),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= kMinDesktopWidth) {
                  return buildNameEmailFieldDesktop();
                }

                //else
                return buildNameEmailFieldMobile();
              },
            ),
          ),
          const SizedBox(height: 15),
          //message
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 700),
            child: const CustomTextField(hintText: 'Your Message', maxLine: 20),
          ),
          const SizedBox(height: 20),
          //send button
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 700),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Get in touch'),
              ),
            ),
          ),

          const SizedBox(height: 30),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 300),
            child: const Divider(),
          ),

          const SizedBox(height: 15),

          //SNS icon button links
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              InkWell(
                onTap: SnsLinks().googleLink,
                child: SvgPicture.asset(
                  "assets/icons/github-original.svg",
                  width: 28,
                ),
              ),
              InkWell(
                onTap: SnsLinks().googleLink,
                child: SvgPicture.asset(
                  "assets/icons/git-original.svg",
                  width: 28,
                ),
              ),
              InkWell(
                onTap: SnsLinks().googleLink,
                child: SvgPicture.asset(
                  "assets/icons/slack-original.svg",
                  width: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row buildNameEmailFieldDesktop() {
    return Row(
      children: [
        //name
        Flexible(child: const CustomTextField(hintText: 'Your Name')),
        const SizedBox(width: 15),
        //email
        Flexible(child: const CustomTextField(hintText: 'Your Email')),
      ],
    );
  }

  Column buildNameEmailFieldMobile() {
    return Column(
      children: [
        //name
        Flexible(child: const CustomTextField(hintText: 'Your Name')),
        const SizedBox(height: 15),
        //email
        Flexible(child: const CustomTextField(hintText: 'Your Email')),
      ],
    );
  }
}
