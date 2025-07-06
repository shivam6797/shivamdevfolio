import 'dart:math';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_custom_portfolio/utils/url_launcher.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HeroSection extends StatefulWidget {
  final AutoScrollController scrollController;
  const HeroSection({super.key, required this.scrollController});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _handController;

  final String name = 'Shivam Singh';
  final List<String> titles = [
    'Flutter Developer',
    'UI/UX Enthusiast',
    'Open to Work',
  ];

  @override
  void initState() {
    super.initState();
    _handController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _handController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final double width = size.width;

    // Define responsive breakpoints
    final bool isSmall = width < 700;
    final bool isMedium = width >= 700 && width < 1000;
    final bool isWide = width >= 1000;

    final double horPad = isWide
        ? 80
        : isMedium
        ? 40
        : 20;
    final double topPad = isSmall
        ? 10
        : isMedium
        ? 5
        : 10;
    final double bottomPad = isSmall
        ? 20
        : isMedium
        ? 5
        : 10;

    final double statusBar = MediaQuery.of(context).padding.top;
    final double headerHeight = kToolbarHeight + statusBar;
    final double heroHeight = size.height - headerHeight;

    final double h1 = isWide
        ? 54
        : isMedium
        ? 42
        : 34;
    final double body = isWide
        ? 20
        : isMedium
        ? 18
        : 16;
    final double animationHeight = isWide
        ? heroHeight * 0.6
        : isMedium
        ? heroHeight * 0.5
        : heroHeight * 0.4;

    return AutoScrollTag(
      key: const ValueKey(0),
      controller: widget.scrollController,
      index: 0,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: topPad),
        padding: EdgeInsets.fromLTRB(horPad, topPad, horPad, bottomPad),
        child: isSmall
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextContent(h1, body),
                  const SizedBox(height: 30),
                  Center(
                    child: isDark
                        ? ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.multiply,
                            ),
                            child: Lottie.asset(
                              'assets/animation/coding_boy.json',
                              height: animationHeight,
                            ),
                          )
                        : Lottie.asset(
                            'assets/animation/coding_boy.json',
                            height: animationHeight,
                          ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _buildTextContent(h1, body),
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    flex: 5,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: isDark
                          ? ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                Colors.transparent,
                                BlendMode.multiply,
                              ),
                              child: Lottie.asset(
                                'assets/animation/coding_boy.json',
                                height: animationHeight,
                              ),
                            )
                          : Lottie.asset(
                              'assets/animation/coding_boy.json',
                              height: animationHeight,
                            ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildTextContent(double h1, double body) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            AnimatedBuilder(
              animation: _handController,
              builder: (_, __) => Transform.rotate(
                angle: sin(_handController.value * pi) * 0.4,
                child: const Text('👋', style: TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 6),
            AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TyperAnimatedText(
                  'Welcome to my portfolio',
                  speed: const Duration(milliseconds: 80),
                  textStyle: TextStyle(
                    fontSize: body,
                    color: theme.textTheme.bodyLarge?.color,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: h1,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.headlineLarge?.color,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/icons/next.png", height: 20, width: 20),
            const SizedBox(width: 4),
            Expanded(
              child: AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(milliseconds: 1000),
                animatedTexts: titles
                    .map(
                      (title) => TyperAnimatedText(
                        title,
                        speed: const Duration(milliseconds: 90),
                        textStyle: GoogleFonts.poppins(
                          fontSize: body,
                          color: theme.textTheme.bodyLarge?.color,
                          height: 1.4,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _socialIcon(
              'assets/icons/linkedin.png',
              () => launchURL("https://www.linkedin.com/in/shivamsinghflutter"),
            ),
            const SizedBox(width: 12),
            _socialIcon(
              'assets/icons/github_latest.png',
              () => launchURL("https://github.com/shivam6797"),
            ),
            const SizedBox(width: 12),
            _socialIcon(
              'assets/icons/facebooks.png',
              () => launchURL(
                "https://www.facebook.com/shivam.pratap.singh.900158",
              ),
            ),
            const SizedBox(width: 12),
            _socialIcon(
              'assets/icons/instagram.png',
              () => launchURL("http://instagram.com/ss_pratap_singh"),
            ),
            const SizedBox(width: 12),
            _socialIcon(
              'assets/icons/twitter.png',
              () => launchURL("https://x.com/shivam90845894"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialIcon(String path, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(path, width: 30, height: 30),
    );
  }
}
