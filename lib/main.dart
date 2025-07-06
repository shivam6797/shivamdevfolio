import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_sections.dart';
import 'sections/header_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/skill_section.dart';
import 'theme/app_theme.dart';
import 'theme/themenotifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyPortfolioApp(),
    ),
  );
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();
    return MaterialApp(
      title: 'ShivamDev Folio',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeNotifier.themeMode,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AutoScrollController _scrollController;
  int _activeIndex = 0;
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController = AutoScrollController()..addListener(_handleScroll);
  }

  void _handleScroll() {
    for (int i = 0; i <= 4; i++) {
      final context = _scrollController.tagMap[i]?.context;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          final pos = box.localToGlobal(Offset.zero).dy;
          if (pos <= 150 && _activeIndex != i) {
            setState(() => _activeIndex = i);
            break;
          }
        }
      }
    }

    final offset = _scrollController.offset;
    if (offset >= 400 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (offset < 400 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: HeaderSection(
          scrollController: _scrollController,
          activeIndex: _activeIndex,
        ),
      ),
      drawer: buildDrawer(
        context,
        _scrollController,
        _activeIndex,
        (i) => setState(() => _activeIndex = i),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              isDark
                  ? 'assets/images/hero_bg.png'
                  : 'assets/images/bg_light.png',
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            controller: _scrollController,
            children: [
              _tagged(0, HeroSection(scrollController: _scrollController)
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.1)),
              _tagged(1, AboutSection(scrollController: _scrollController)
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideX(begin: -0.1)),
              _tagged(2, SkillSection(scrollController: _scrollController)
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.1)),
              _tagged(3, ProjectsSection(scrollController: _scrollController)
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.1)),
              _tagged(4, ContactSection(scrollController: _scrollController)
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.1)),
              const FooterSection(),
            ],
          ),
        ],
      ),
      floatingActionButton: _showBackToTop
          ? FloatingActionButton(
              tooltip: 'Back to Top',
              backgroundColor: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.arrow_upward, color: Colors.white),
            )
          : null,
    );
  }

  Widget _tagged(int index, Widget child) => AutoScrollTag(
        key: ValueKey(index),
        controller: _scrollController,
        index: index,
        child: child,
      );
}
