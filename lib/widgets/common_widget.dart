import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_custom_portfolio/model/projects_model.dart';
import 'package:my_custom_portfolio/utils/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final accent = theme.colorScheme.secondary;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          constraints: const BoxConstraints(minWidth: 280, maxWidth: 400),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(.07)
                : Colors.black.withOpacity(.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(.15)
                  : Colors.black.withOpacity(.12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(project.imagePath, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                project.title,
                style: GoogleFonts.poppins(
                  color: accent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                project.description,
                style: GoogleFonts.poppins(
                  color: isDark ? Colors.white70 : Colors.black87,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: project.technologies.map((tech) {
                  return Chip(
                    label: Text(tech),
                    backgroundColor: isDark ? Colors.white10 : Colors.black12,
                    labelStyle: GoogleFonts.poppins(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        launchURL(project.githubUrl);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark
                            ? Colors.white10
                            : const Color(0xFF24292E),
                        foregroundColor: isDark ? Colors.white : Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      icon: const Icon(Icons.code),
                      label: const Text('GitHub'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Live Demo link 
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      icon:  Icon(Icons.open_in_browser,color:  isDark ? Colors.black : Colors.white,),
                      label: Text('Live Demo',style: TextStyle(fontSize:13,color: isDark ? Colors.black : Colors.white,fontWeight:FontWeight.w600),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
