// contact_section.dart (Fixed Light Theme version)
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  final AutoScrollController scrollController;
  const ContactSection({super.key, required this.scrollController});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final uri = Uri(
      scheme: 'mailto',
      path: 'yourmail@example.com',
      query: {
        'subject': _subjectCtrl.text,
        'body': '''
Name: ${_nameCtrl.text}
Email: ${_emailCtrl.text}

${_msgCtrl.text}
''',
      }.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value)}').join('&'),
    );

    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Message sent!')),
    );
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isWide = MediaQuery.of(context).size.width >= 800;

    Widget _glass({required Widget child}) => ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: Container(
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(.15)
                      : Colors.black.withOpacity(.1),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 16,
                    color: isDark
                        ? Colors.black.withOpacity(.4)
                        : Colors.grey.withOpacity(0.15),
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(28),
              child: child,
            ),
          ),
        );

    Widget _form() => _glass(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _field(icon: FontAwesomeIcons.user, hint: 'Your Name', ctrl: _nameCtrl, validator: (v) => v!.isEmpty ? 'Enter name' : null),
                const SizedBox(height: 14),
                _field(icon: FontAwesomeIcons.envelope, hint: 'Email', ctrl: _emailCtrl, keyboard: TextInputType.emailAddress, validator: (v) => !RegExp(r'\S+@\S+\.\S+').hasMatch(v!) ? 'Invalid email' : null),
                const SizedBox(height: 14),
                _field(icon: FontAwesomeIcons.tag, hint: 'Subject', ctrl: _subjectCtrl, validator: (v) => v!.isEmpty ? 'Enter subject' : null),
                const SizedBox(height: 14),
                _field(icon: FontAwesomeIcons.message, hint: 'Message', ctrl: _msgCtrl, maxLines: 4, validator: (v) => v!.length < 10 ? 'Too short' : null),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _submit,
                    icon: const Icon(FontAwesomeIcons.paperPlane, size: 16),
                    label: const Text('Send Message'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondary,
                      foregroundColor: isDark ? Colors.black : Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        );

    Widget _art() => isWide
        ? Padding(
            padding: const EdgeInsets.only(top: 14),
            child: _glass(
              child: Center(
                child: Icon(
                  FontAwesomeIcons.commentDots,
                  size: 100,
                  color: theme.colorScheme.secondary.withOpacity(0.25),
                ),
              ),
            ),
          )
        : const SizedBox();

    return AutoScrollTag(
      key: const ValueKey(4),
      controller: widget.scrollController,
      index: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Get in touch',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.secondary,
                )),
            const SizedBox(height: 32),
            isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _form()),
                      const SizedBox(width: 40),
                      Expanded(child: _art()),
                    ],
                  )
                : _form(),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required IconData icon,
    required String hint,
    required TextEditingController ctrl,
    int maxLines = 1,
    TextInputType keyboard = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextFormField(
      controller: ctrl,
      validator: validator,
      maxLines: maxLines,
      keyboardType: keyboard,
      style: GoogleFonts.poppins(fontSize: 14.5, color: theme.textTheme.bodyLarge!.color),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, size: 15, color: theme.colorScheme.secondary.withOpacity(.7)),
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: theme.hintColor.withOpacity(.6), fontSize: 14),
        filled: true,
        fillColor: isDark ? Colors.white.withOpacity(.05) : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.withOpacity(.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.withOpacity(.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: theme.colorScheme.secondary.withOpacity(.7), width: 1.3),
        ),
      ),
    );
  }
}
