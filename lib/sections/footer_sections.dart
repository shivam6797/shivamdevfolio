import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_custom_portfolio/utils/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white70 : Colors.black87;
    final iconColor = isDark ? Colors.tealAccent : Colors.teal;
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F2);

    return Container(
      width: double.infinity,
      color: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.github),
                color: iconColor,
                iconSize: 20,
                onPressed: () =>  launchURL("https://github.com/shivam6797"),
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.linkedin),
                color: iconColor,
                iconSize: 20,
                onPressed: () => launchURL("https://www.linkedin.com/in/shivamsinghflutter")
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.envelope),
                color: iconColor,
                iconSize: 20,
                onPressed: () =>  sendEmail("shivampratap6797@gmail.com"),
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.bolt),
                color: iconColor,
                iconSize: 20,
                onPressed: () {
                  // Launch Portfolio or any other
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Built with ❤️ in Flutter",
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "© 2025 Shivam Singh. All rights reserved.",
            style: TextStyle(
              color: textColor.withOpacity(0.7),
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
