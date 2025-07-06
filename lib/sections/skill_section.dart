import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class SkillSection extends StatelessWidget {
  final AutoScrollController scrollController;

  const SkillSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return AutoScrollTag(
      key: ValueKey(2),
      controller: scrollController,
      index: 2,
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, isMobile ? 40 : 60, 24, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Skills',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: _skills
                  .take(10)
                  .map((s) => _SkillChip(skill: s, theme: theme))
                  .toList(),
            ),
            const SizedBox(height: 28),

            // ✅ ORIGINAL VIEW ALL BUTTON
            ElevatedButton.icon(
              icon: const Icon(Icons.view_comfy),
              label: Text(
                'View All',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: theme.colorScheme.onSurface,
                backgroundColor: theme.colorScheme.secondary.withOpacity(0.1),
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              onPressed: () => _showAllDialog(context, theme),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ ORIGINAL DIALOG STYLE
  // ─────────────────────────────────────────────────────────────
  //  View-All  Skills  Dialog   (theme-aware + icons)
  // ─────────────────────────────────────────────────────────────
  void _showAllDialog(BuildContext context, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF171717) : Colors.white;
    final chipColor = (isDark ? Colors.white70 : Colors.black87).withOpacity(
      .06,
    );

    // ► skill → FontAwesome icon map
    const iconMap = <String, IconData>{
      'Dart': FontAwesomeIcons.code,
      'C++': FontAwesomeIcons.codeBranch,
      'JavaScript': FontAwesomeIcons.js,
      'Flutter': FontAwesomeIcons.mobileScreenButton,
      'Firebase': FontAwesomeIcons.fire,
      'Bloc': FontAwesomeIcons.cubesStacked,
      'Provider': FontAwesomeIcons.peopleGroup,
      'Git': FontAwesomeIcons.gitAlt,
      'GitHub': FontAwesomeIcons.github,
      'VS Code': FontAwesomeIcons.codeMerge,
      'Android Studio': FontAwesomeIcons.android,
      'Postman': FontAwesomeIcons.paperPlane,
      'REST API': FontAwesomeIcons.server,
      'SQLite': FontAwesomeIcons.database,
    };

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: bgColor,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 620),
          padding: const EdgeInsets.fromLTRB(28, 30, 28, 34),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── title ──
                Text(
                  'All Skills',
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 26),

                // ── categories ──
                _category(
                  theme,
                  title: 'Languages',
                  skills: ['Dart', 'C++', 'JavaScript'],
                  icon: FontAwesomeIcons.code,
                  chipColor: chipColor,
                  iconMap: iconMap,
                ),
                _category(
                  theme,
                  title: 'Frameworks / Libs',
                  skills: ['Flutter', 'Firebase', 'Bloc', 'Provider'],
                  icon: FontAwesomeIcons.layerGroup,
                  chipColor: chipColor,
                  iconMap: iconMap,
                ),
                _category(
                  theme,
                  title: 'Version Control',
                  skills: ['Git', 'GitHub'],
                  icon: FontAwesomeIcons.gitAlt,
                  chipColor: chipColor,
                  iconMap: iconMap,
                ),
                _category(
                  theme,
                  title: 'Tools & IDEs',
                  skills: ['VS Code', 'Android Studio', 'Postman'],
                  icon: FontAwesomeIcons.toolbox,
                  chipColor: chipColor,
                  iconMap: iconMap,
                ),
                _category(
                  theme,
                  title: 'Others',
                  skills: ['REST API', 'SQLite'],
                  icon: FontAwesomeIcons.gears,
                  chipColor: chipColor,
                  iconMap: iconMap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  helper – category section with icon-chips
  // ─────────────────────────────────────────────────────────────
  Widget _category(
    ThemeData theme, {
    required String title,
    required List<String> skills,
    required IconData icon,
    required Color chipColor,
    required Map<String, IconData> iconMap,
  }) {
    final textColor = theme.colorScheme.onBackground;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: theme.colorScheme.secondary),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: skills.map((s) {
              return Chip(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                backgroundColor: chipColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: theme.colorScheme.secondary.withOpacity(.25),
                    width: .8,
                  ),
                ),
                avatar: Icon(
                  iconMap[s] ?? FontAwesomeIcons.circleInfo,
                  size: 13,
                  color: theme.colorScheme.secondary.withOpacity(.9),
                ),
                label: Text(
                  s,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final _Skill skill;
  final ThemeData theme;
  const _SkillChip({required this.skill, required this.theme});

  @override
  Widget build(BuildContext context) {
    final dark = theme.brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: dark
                ? Colors.white.withOpacity(.08)
                : Colors.black.withOpacity(.05),
            border: Border.all(
              color: theme.colorScheme.secondary.withOpacity(.35),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                skill.icon,
                size: 16,
                color: theme.colorScheme.secondary.withOpacity(.85),
              ),
              const SizedBox(width: 6),
              Text(
                skill.name,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Skill {
  final String name;
  final IconData icon;
  const _Skill(this.name, this.icon);
}

final _skills = <_Skill>[
  _Skill('Flutter', FontAwesomeIcons.mobileScreen),
  _Skill('Dart', FontAwesomeIcons.code),
  _Skill('Firebase', FontAwesomeIcons.fireFlameCurved),
  _Skill('REST API', FontAwesomeIcons.link),
  _Skill('SQLite', FontAwesomeIcons.database),
  _Skill('Bloc', FontAwesomeIcons.cubesStacked),
  _Skill('Cubit', FontAwesomeIcons.atom),
  _Skill('Provider', FontAwesomeIcons.handshakeAngle),
  _Skill('Git', FontAwesomeIcons.gitAlt),
  _Skill('GitHub', FontAwesomeIcons.github),
  _Skill('VS Code', FontAwesomeIcons.codeBranch),
  _Skill('Android Studio', FontAwesomeIcons.android),
];
