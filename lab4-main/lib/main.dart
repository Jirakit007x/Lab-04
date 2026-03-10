import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Pastel color seed for a soft UI
    final seed = const Color(0xFFBFE6D6); // soft mint
    final scheme = ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light);

    final theme = ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: scheme.onSurface),
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
      // Set a light, slightly translucent card color for a soft "glass" look
      cardColor: Color.fromRGBO(255, 255, 255, 0.90),
    );

    return MaterialApp(
      title: 'Course Grid',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const CourseGridPage(),
    );
  }
}

/// โมเดลข้อมูลคอร์ส
class Course {
  final String id;
  final String title;
  final String level;
  final double price;
  final String imageUrl;

  Course({
    required this.id,
    required this.title,
    required this.level,
    required this.price,
    required this.imageUrl,
  });
}

/// List ข้อมูลคอร์ส
final List<Course> sampleCourses = [
  Course(
    id: '1',
    title: 'Minimalist House Design',
    level: 'Beginner',
    price: 3000000,
    imageUrl: 'https://img.iproperty.com.my/angel-legacy/1110x624-crop/static/2021/04/Modern-wooden-house.jpg',
  ),
  Course(
    id: '2',
    title: 'Minimalist Interior Design',
    level: 'Beginner',
    price: 3500000,
    imageUrl: 'https://media.istockphoto.com/id/1442148484/th/%E0%B8%A3%E0%B8%B9%E0%B8%9B%E0%B8%96%E0%B9%88%E0%B8%B2%E0%B8%A2/%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%81%E0%B8%AA%E0%B8%94%E0%B8%87%E0%B8%9C%E0%B8%A5-3-%E0%B8%A1%E0%B8%B4%E0%B8%95%E0%B8%B4%E0%B8%82%E0%B8%AD%E0%B8%87%E0%B8%9A%E0%B9%89%E0%B8%B2%E0%B8%99%E0%B8%8A%E0%B8%B2%E0%B8%99%E0%B9%80%E0%B8%A1%E0%B8%B7%E0%B8%AD%E0%B8%87%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%97%E0%B8%B1%E0%B8%99%E0%B8%AA%E0%B8%A1%E0%B8%B1%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B8%AA%E0%B8%A7%E0%B8%99.jpg?s=612x612&w=is&k=20&c=p5San4__3Odn05zVoP_MUa4PHWRiBTgBTTC62BCiOZw=',
  ),
  Course(
    id: '3',
    title: 'Mastering Modern Architecture',
    level: 'Intermediate',
    price: 13000000,
    imageUrl: 'https://propholic.com/wp-content/uploads/2020/03/Paddington-S.jpg',
  ),
  Course(
    id: '4',
    title: 'Mastering Classic Architecture',
    level: 'Intermediate',
    price: 150000000,
    imageUrl: 'https://propholic.com/wp-content/uploads/2020/03/Baker.jpg',
  ),
  Course(
    id: '5',
    title: 'super luxury design',
    level: 'Advanced',
    price: 590000000,
    imageUrl: 'https://www.scgheim.com/images/house/scg_heim_20220811153711400.jpg',
  ),
  Course(
    id: '6',
    title: 'Doraemon Dream House Design',
    level: 'Intermediate',
    price: 1200000000,
    imageUrl: 'https://media.readthecloud.co/wp-content/uploads/2021/01/29184658/architecture-in-doraemon-feature.webp',
  ),
];

class CourseGridPage extends StatefulWidget {
  const CourseGridPage({super.key});

  @override
  State<CourseGridPage> createState() => _CourseGridPageState();
}

class _CourseGridPageState extends State<CourseGridPage> {
  Course? _selectedCourse;
  String _search = '';

  String _formatCurrency(double value) {
    final s = value.toInt().toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      buffer.write(s[i]);
      count++;
      if (count % 3 == 0 && i != 0) buffer.write(',');
    }
    return buffer.toString().split('').reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
      final isNarrow = maxWidth < 600;
      final isMedium = maxWidth >= 600 && maxWidth < 900;
      final isWide = maxWidth >= 900;
      final crossAxisCount = isNarrow ? 1 : isMedium ? 2 : 3;

      final visible = sampleCourses.where((c) => c.title.toLowerCase().contains(_search.toLowerCase())).toList();

      return Scaffold(
        appBar: AppBar(
          title: const Text('Courses'),
          elevation: 1,
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(62),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: TextField(
                        onChanged: (v) => setState(() => _search = v),
                        decoration: InputDecoration(
                          hintText: 'Search courses...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filter'),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          // pastel gradient background
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFDF6FF), // pale lavender
                Color(0xFFEEF9F4), // mint
                Color(0xFFFFFBEE), // pale cream
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: isWide && _selectedCourse != null
              ? _buildWide(crossAxisCount, visible)
              : _buildGrid(crossAxisCount, visible),
        ),
      );
    });
  }

  Widget _buildGrid(int crossAxisCount, List<Course> courses) {
    if (courses.isEmpty) {
      return Center(
        child: Text('No courses found', style: Theme.of(context).textTheme.titleMedium),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final c = courses[index];
        return _CourseCard(
          course: c,
          isSelected: _selectedCourse?.id == c.id,
          onTap: () {
            setState(() => _selectedCourse = c);
            if (MediaQuery.of(context).size.width < 900) {
              _showCourseDetail(context, c);
            }
          },
          formatCurrency: _formatCurrency,
        );
      },
    );
  }

  Widget _buildWide(int crossAxisCount, List<Course> courses) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.78,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final c = courses[index];
              final isSelected = _selectedCourse?.id == c.id;
              return Stack(
                children: [
                  _CourseCard(
                    course: c,
                    isSelected: isSelected,
                    onTap: () => setState(() => _selectedCourse = c),
                    formatCurrency: _formatCurrency,
                  ),
                  if (isSelected)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).colorScheme.primary, width: 3),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: _CourseDetailPanel(course: _selectedCourse!),
          ),
        ),
      ],
    );
  }

  void _showCourseDetail(BuildContext context, Course course) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(child: _CourseDetailPanel(course: course)),
        ),
      ),
    );
  }
}

/// Card widget
class _CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;
  final bool isSelected;
  final String Function(double)? formatCurrency;

  const _CourseCard({
    required this.course,
    required this.onTap,
    this.isSelected = false,
    this.formatCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final price = formatCurrency != null ? '${formatCurrency!(course.price)} THB' : '${course.price.toStringAsFixed(0)} THB';

    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withAlpha((0.14 * 255).round()),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image with fade-in
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Hero(
                    tag: 'course-image-${course.id}',
                    child: Image.network(
                      course.imageUrl,
                      fit: BoxFit.cover,
                      frameBuilder: (context, child, frame, wasSync) {
                        if (wasSync) return child;
                        return AnimatedOpacity(opacity: frame == null ? 0 : 1, duration: const Duration(milliseconds: 400), child: child);
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(child: Icon(Icons.image_not_supported, size: 40)),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(course.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Chip(
                        label: Text(course.level),
                        visualDensity: VisualDensity.compact,
                        backgroundColor: Theme.of(context).colorScheme.primary.withAlpha((0.12 * 255).round()),
                      ),
                      const Spacer(),
                      Text(price, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Detail panel
class _CourseDetailPanel extends StatelessWidget {
  final Course course;

  const _CourseDetailPanel({required this.course});

  String _formatCurrency(double value) {
    final s = value.toInt().toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      buffer.write(s[i]);
      count++;
      if (count % 3 == 0 && i != 0) buffer.write(',');
    }
    return buffer.toString().split('').reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    final price = '${_formatCurrency(course.price)} THB';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(child: Text(course.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold))),
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onSurface),
          )
        ]),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Hero(
            tag: 'course-image-${course.id}',
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                course.imageUrl,
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSync) {
                  if (wasSync) return child;
                  return AnimatedOpacity(opacity: frame == null ? 0 : 1, duration: const Duration(milliseconds: 350), child: child);
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.image_not_supported)),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(children: [
          Chip(label: Text(course.level)),
          const SizedBox(width: 8),
          Text(price, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
        ]),
        const SizedBox(height: 12),
        Text('Course Description', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
          'Lorem ipsum dolor sit amet. This is a detailed description of the course ${course.title}. Students will learn fundamental concepts and hands-on skills applicable to real-world projects. Level: ${course.level}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enrolled: ${course.title}')));
              },
              icon: const Icon(Icons.school),
              label: const Text('Enroll Now'),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: const Text('Close'),
          ),
        ]),
      ],
    );
  }
}
