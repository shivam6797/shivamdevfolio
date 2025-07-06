import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_custom_portfolio/theme/themenotifier.dart';
import 'package:my_custom_portfolio/utils/url_launcher.dart';
import 'package:my_custom_portfolio/widgets/resume_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HeaderSection extends StatefulWidget {
  final AutoScrollController scrollController;
  final int activeIndex;
  const HeaderSection({
    super.key,
    required this.scrollController,
    required this.activeIndex,
  });

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  void _scrollTo(int index) => widget.scrollController.scrollToIndex(
        index,
        preferPosition: AutoScrollPosition.begin,
        duration: const Duration(milliseconds: 500),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDesktop = MediaQuery.of(context).size.width > 800;

    // Logo Widget
    Widget logo = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.code, size: 20, color: Colors.blueAccent),
        const SizedBox(width: 6),
        RichText(
          text: TextSpan(
            text: 'Shivam',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            children: [
              TextSpan(
                text: '.dev',
                style: GoogleFonts.poppins(color: Colors.blueAccent),
              ),
            ],
          ),
        ),
      ],
    );

    // Desktop Navbar
    if (isDesktop) {
      return SafeArea(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.grey.shade100.withOpacity(0.85),
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.05),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  logo,
                  Row(
                    children: [
                      Consumer<ThemeNotifier>(
                        builder: (context, themeNotifier, _) => IconButton(
                          icon: Icon(
                            themeNotifier.isDarkMode
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            color: theme.colorScheme.onSurface,
                            size: 22,
                          ),
                          onPressed: () => themeNotifier.toggleTheme(),
                        ),
                      ),
                      _NavBtn(
                        'Home',
                        () => _scrollTo(0),
                        isActive: widget.activeIndex == 0,
                        color: theme.colorScheme.onSurface,
                      ),
                      _NavBtn(
                        'About',
                        () => _scrollTo(1),
                        isActive: widget.activeIndex == 1,
                        color: theme.colorScheme.onSurface,
                      ),
                      _NavBtn(
                        'Skills',
                        () => _scrollTo(2),
                        isActive: widget.activeIndex == 2,
                        color: theme.colorScheme.onSurface,
                      ),
                      _NavBtn(
                        'Projects',
                        () => _scrollTo(3),
                        isActive: widget.activeIndex == 3,
                        color: theme.colorScheme.onSurface,
                      ),
                      _NavBtn(
                        'Contact',
                        () => _scrollTo(4),
                        isActive: widget.activeIndex == 4,
                        color: theme.colorScheme.onSurface,
                      ),
                      const SizedBox(width: 14),
                      const ResumeButtonWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Mobile AppBar
    return SafeArea(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.grey.shade100.withOpacity(0.85),
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Hamburger + Logo
                Row(
                  children: [
                    Builder(
                      builder: (ctx) => IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: theme.colorScheme.onSurface,
                        ),
                        onPressed: () => Scaffold.of(ctx).openDrawer(),
                      ),
                    ),
                    const SizedBox(width: 6),
                    logo,
                  ],
                ),
                // Theme toggle + GitHub
                Row(
                  children: [
                    Consumer<ThemeNotifier>(
                      builder: (context, themeNotifier, _) => IconButton(
                        icon: Icon(
                          themeNotifier.isDarkMode
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: theme.colorScheme.onSurface,
                          size: 22,
                        ),
                        onPressed: () => themeNotifier.toggleTheme(),
                      ),
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                        size: 25,
                      ),
                      onPressed: () => launchURL("https://github.com/shivam6797"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* ───────────────────── SMALL NAV BUTTON ───────────────────── */
class _NavBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isActive;
  final Color color;

  const _NavBtn(
    this.label,
    this.onTap, {
    this.isActive = false,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.tealAccent : color,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}


// Drawer for mobile (Glassmorphic)
Drawer buildDrawer(
  BuildContext context,
  AutoScrollController controller,
  int activeIndex,
  void Function(int) onItemTap,
) {
  return Drawer(
    width: 240,
    backgroundColor: Colors.transparent,
    child: Stack(
      children: [
        // Glass Background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(color: Colors.white.withOpacity(0.05)),
        ),
        Column(
          children: [
            const SizedBox(height: 48),
            const Center(
              child: CircleAvatar(
                radius: 36,
                backgroundImage: AssetImage('assets/images/shivam_image.jpg'),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'Shivam.dev',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(milliseconds: 1000),
                animatedTexts: [
                  TyperAnimatedText(
                    'Flutter Developer',
                    speed: const Duration(milliseconds: 80),
                    textStyle: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TyperAnimatedText(
                    'UI/UX Enthusiast',
                    speed: const Duration(milliseconds: 80),
                    textStyle: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _drawerItem(
                    context,
                    'Home',
                    0,
                    controller,
                    activeIndex,
                    onItemTap,
                  ),
                  _drawerItem(
                    context,
                    'About',
                    1,
                    controller,
                    activeIndex,
                    onItemTap,
                  ),
                   _drawerItem(
                    context,
                    'Skills',
                    2,
                    controller,
                    activeIndex,
                    onItemTap,
                  ),
                  _drawerItem(
                    context,
                    'Projects',
                    3,
                    controller,
                    activeIndex,
                    onItemTap,
                  ),
                  _drawerItem(
                    context,
                    'Contact',
                    4,
                    controller,
                    activeIndex,
                    onItemTap,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ResumeButtonWidget(),
            ),
            const Divider(color: Colors.white24),
             Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => launchURL("https://github.com/shivam6797"),
                    child: FaIcon(
                      FontAwesomeIcons.github,
                      color: Colors.white70,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 16),
                  InkWell(
                    onTap: () =>  launchURL("https://www.linkedin.com/in/shivamsinghflutter"),
                    child: FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: Colors.white70,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 16),
                  InkWell(
                    onTap: () =>  sendEmail("shivampratap6797@gmail.com"),
                    child: FaIcon(
                      FontAwesomeIcons.envelope,
                      color: Colors.white70,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Text(
                'v1.0.0',
                style: GoogleFonts.poppins(
                  color: Colors.white38,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ],
    ),
  );
}

// Drawer item helper
Widget _drawerItem(
  BuildContext context,
  String label,
  int index,
  AutoScrollController controller,
  int activeIndex,
  void Function(int) onItemTap,
) {
  final isActive = activeIndex == index;

  return InkWell(
    onTap: () {
      onItemTap(index);
      controller.scrollToIndex(
        index,
        preferPosition: AutoScrollPosition.begin,
        duration: const Duration(milliseconds: 500),
      );
      Navigator.of(context).maybePop();
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        // left accent bar
        gradient: isActive
            ? const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF00C9FF), // cyan accent
                  Color(0xFF92FE9D), // light‑green tint
                ],
                stops: [0.0, 0.05], // very thin bar
              )
            : null,
        color: isActive ? Colors.white.withOpacity(0.06) : Colors.transparent,
        boxShadow: isActive
            ? [
                BoxShadow(
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                  color: Colors.black.withOpacity(0.25),
                ),
              ]
            : [],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: isActive ? const Color(0xFF00C9FF) : Colors.white70,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          letterSpacing: 0.3,
        ),
      ),
    ),
  );
}
