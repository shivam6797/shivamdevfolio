import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_custom_portfolio/widgets/common_widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../model/projects_model.dart';

class ProjectsSection extends StatelessWidget {
  final AutoScrollController scrollController;
  const ProjectsSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final List<Project> myProjects = [
      Project(
        title: 'ApnaMall Ecommerce App',
        description:
            'Built a complete e-commerce mobile app allowing users to browse products by category, search, manage wishlist, add to cart, checkout, and track orders. Integrated secure login/signup, user feedback system, and push notifications. Applied Bloc for efficient state management and used image caching for performance optimization.',
        imagePath: 'assets/images/ApnaMall.png',
        technologies: ['Flutter', 'REST API', 'Bloc'],
        githubUrl: 'https://github.com/shivam6797/ApnaMall_App',
        liveDemoUrl: null,
      ),
      Project(
        title: 'ExpensifyX App',
        description:
            'Developed a personal finance app to track expenses with category-wise sorting, smart budgeting, and interactive analytics through charts. Implemented dark/light mode toggle and managed data using SQLite local database. Utilized Bloc for structured state management.',
        imagePath: 'assets/images/expensify.jpeg',
        technologies: ['Flutter', 'SQLite', 'Bloc'],
        githubUrl: 'https://github.com/shivam6797/ExpensifyX_App',
        liveDemoUrl: null,
      ),
      Project(
        title: 'GemniChat App',
        description:
            'A smart chatbot app built with Flutter using Google’s Gemini 1.5 Flash model for dynamic text & image-based interactions. Features include Google Sign-In authentication, real-time chat syncing with Firebase Firestore, and chat management (rename/delete). Supports light/dark themes, typing indicator animation, and persistent chat history.',
        imagePath: 'assets/images/app_icon.png',
        technologies: ['Flutter', 'Firebase', 'Gemini API', 'Bloc'],
        githubUrl: 'https://github.com/shivam6797/gemnichat_app',
        liveDemoUrl: null,
      ),
    ];

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AutoScrollTag(
      key: const ValueKey(3),
      controller: scrollController,
      index: 3,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Projects',
              style: GoogleFonts.poppins(
                color: theme.colorScheme.secondary,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 800;

                if (isWide) {
                  // Wide screens - ApnaMall & ExpensifyX in row, GemniChat below them
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildAnimatedCard(myProjects[0], isDark, 0),
                          const SizedBox(width: 20),
                          _buildAnimatedCard(myProjects[1], isDark, 1),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildAnimatedCard(myProjects[2], isDark, 2),
                    ],
                  );
                } else {
                  // Small screens - use Masonry view
                  return MasonryGridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: constraints.maxWidth < 600 ? 1 : 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    itemCount: myProjects.length,
                    itemBuilder: (context, index) {
                      return _buildAnimatedCard(myProjects[index], isDark, index);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedCard(Project project, bool isDark, int index) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: _AnimatedGlassCard(
        isDark: isDark,
        child: ProjectCard(project: project),
      )
          .animate()
          .fadeIn(duration: 500.ms, delay: (index * 150).ms)
          .slideY(begin: .2, curve: Curves.easeOut),
    );
  }
}

class _AnimatedGlassCard extends StatefulWidget {
  final Widget child;
  final bool isDark;
  const _AnimatedGlassCard({required this.child, required this.isDark});

  @override
  State<_AnimatedGlassCard> createState() => _AnimatedGlassCardState();
}

class _AnimatedGlassCardState extends State<_AnimatedGlassCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final dark = widget.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: _hovering ? 1.03 : 1.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: dark
                    ? Colors.white.withOpacity(.05)
                    : Colors.grey.withOpacity(.02),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: dark ? Colors.white24 : Colors.black.withOpacity(.1),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
