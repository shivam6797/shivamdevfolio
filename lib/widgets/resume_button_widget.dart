import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumeButtonWidget extends StatelessWidget {
  const ResumeButtonWidget({super.key});

  /* ───────────────────── Open Resume ───────────────────── */
  Future<void> _openResume(BuildContext context) async {
    try {
      if (kIsWeb) {
        final url = Uri.parse(
          'resume/Shivam_Singh_Resume.pdf',
        ); // ✅ no "assets/", no "/"
        if (!await launchUrl(url, webOnlyWindowName: '_blank')) {
          throw 'Could not launch resume';
        }
        return;
      }

      // If not web, handle mobile/desktop
      final byteData = await rootBundle.load(
        'assets/resume/Shivam_Singh_Resume.pdf',
      );
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/Shivam_Singh_Resume.pdf');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      await OpenFile.open(file.path);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Couldn't open resume")));
      }
    }
  }

  /* ───────────────────── Build Widget ───────────────────── */
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? Colors.tealAccent : Colors.indigoAccent;

    return Animate(
      effects: const [
        ScaleEffect(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
        ),
        FadeEffect(duration: Duration(milliseconds: 300)),
      ],
      child: InkWell(
        onTap: () => _openResume(context),
        borderRadius: BorderRadius.circular(30),
        splashColor: accent.withOpacity(.15),
        hoverColor: Colors.transparent,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: isDark
                ? LinearGradient(
                    colors: [
                      Colors.tealAccent.withOpacity(0.15),
                      Colors.white.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isDark ? null : Colors.indigo.withOpacity(0.07),
            border: Border.all(
              color: isDark
                  ? Colors.tealAccent.withOpacity(0.6)
                  : Colors.indigoAccent.withOpacity(0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.tealAccent.withOpacity(0.3)
                    : Colors.indigoAccent.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.picture_as_pdf, size: 18, color: accent),
              const SizedBox(width: 8),
              Center(
                child: Text(
                  'Resume',
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
