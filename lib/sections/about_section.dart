// about_section.dart
import 'dart:ui';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_custom_portfolio/widgets/resume_button_widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class AboutSection extends StatelessWidget {
  final AutoScrollController scrollController;
  const AboutSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    
    final isWide   = MediaQuery.of(context).size.width > 800;
    final theme    = Theme.of(context);
    final accent   = theme.colorScheme.secondary;
    final txtBody  = theme.textTheme.bodyLarge?.color ?? Colors.white;
    final txtFade  = txtBody.withOpacity(0.7);

    // ─── static data ──────────────────────────────
    const name = "Shivam Singh";
    const age  = "29";
    const email = "shivampratap6797@email.com";
    const location = "Agra, India";

    const aboutMe = [
      "I'm Shivam Singh, a passionate Flutter developer.",
      "I’ve worked as a Flutter Developer at Accedom Information Technology Pvt. Ltd. from June to October 2024, where I contributed to multiple live mobile applications.",
      "Currently, I’m pursuing an advanced Flutter development course at WsCube Tech, Jaipur, which has helped me deepen my hands-on skills with modern tools and best practices.",
      "I’m eager to work in a dynamic and growth-driven environment where I can contribute as well as learn continuously. I’m actively looking for opportunities to work with forward-thinking teams and deliver high-quality mobile app solutions.",
    ];

    const skills = [
      'Flutter','Dart','Firebase','REST API','SQLite',
      'BLoC','Cubit','Provider','Git','Github',
    ];

    final isMobile = defaultTargetPlatform == TargetPlatform.android ||
                     defaultTargetPlatform == TargetPlatform.iOS;

    final vPad = isWide ? 60.0 : 24.0;  // dynamic padding

    return AutoScrollTag(
      key: const ValueKey(1),
      controller: scrollController,
      index: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: vPad),
        // 🔹 **कोई background-color नहीं** – main.dart वाली BG यहाँ भी दिखेगी
        child: isWide
            ? _buildWide(aboutMe, skills, name, age, email, location,
                         txtBody, txtFade, accent)
            : _buildNarrow(aboutMe, skills, name, age, email, location,
                           isMobile, txtBody, txtFade, accent),
      ),
    );
  }

  /* ─────────────  WIDE  ──────────── */
  Widget _buildWide(
    List<String> about, List<String> skills,
    String name, String age, String email, String loc,
    Color txt, Color txtFade, Color accent,
  ){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _textBlock(about, skills, name, age, email, loc,
                            false, txt, txtFade, accent),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: ClipOval(
              child: Image.asset(
                'assets/images/shivam_image.jpg',
                width: 300, height: 300, fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }

  /* ─────────────  NARROW  ─────────── */
  Widget _buildNarrow(
    List<String> about, List<String> skills,
    String name, String age, String email, String loc,
    bool isMobile,
    Color txt, Color txtFade, Color accent,
  ){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textBlock(about, skills, name, age, email, loc,
                   isMobile, txt, txtFade, accent),
        const SizedBox(height: 24),
        Center(
          child: ClipOval(
            child: Image.asset(
              'assets/images/shivam_image.jpg',
              width: 220, height: 220, fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }

  /* ─────────────  TEXT-BLOCK  ─────────── */
  Widget _textBlock(
    List<String> about, List<String> skills,
    String name, String age, String email, String loc,
    bool showResume,
    Color txt, Color txtFade, Color accent,
  ){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("About Me",
            style: GoogleFonts.poppins(
              color: txt, fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 18),

        for (final line in about)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(line,
                style: GoogleFonts.poppins(
                  color: txtFade, fontSize: 16, height: 1.5)),
          ),

        const SizedBox(height: 20),
        Text("Technologies I have worked with:",
            style: GoogleFonts.poppins(
              color: accent, fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),

        Wrap(
          spacing: 12, runSpacing: 12,
          children: skills.map((s) => _chip(s, accent, txt)).toList(),
        ),
  
        const SizedBox(height: 20),
        Divider(color: txtFade.withOpacity(.3)),
        const SizedBox(height: 10),

        Wrap(
          spacing: 40, runSpacing: 12,
          children: [
            _infoRow("Name", name, accent, txtFade),
            _infoRow("Age",  age,  accent, txtFade),
            _infoRow("Email",email,accent, txtFade),
            _infoRow("From", loc, accent, txtFade),
          ],
        ),

        const SizedBox(height: 30),
       const ResumeButtonWidget(),
      ],
    );
  }

  /* ─────────────  CHIP  ─────────── */
  Widget _chip(String label, Color accent, Color txt){
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: accent.withOpacity(.10),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: accent.withOpacity(.25)),
          ),
          child: Text(label,
              style: GoogleFonts.poppins(
                color: txt, fontSize: 15, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }

  /* ─────────────  INFO ROW  ─────────── */
  Widget _infoRow(String k, String v, Color accent, Color txtFade){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("$k: ",
            style: GoogleFonts.poppins(
              color: accent, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(width: 2),
        Text(v,
            style: GoogleFonts.poppins(
              color: txtFade, fontSize: 14)),
      ],
    );
  }
}
