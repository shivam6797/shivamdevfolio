class Project {
  final String title;
  final String description;
  final String imagePath;
  final List<String> technologies;
  final String githubUrl;
  final String? liveDemoUrl;

  Project({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.technologies,
    required this.githubUrl,
    this.liveDemoUrl,
  });
}
