import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResourcesPage extends StatefulWidget {
  const ResourcesPage({super.key});

  static const navyDark = Color(0xFF06163F);
  static const navy = Color(0xFF082B7A);
  static const royalBlue = Color(0xFF084BDB);
  static const cyan = Color(0xFF20C7F7);
  static const gold = Color(0xFFFFC857);
  static const textDark = Color(0xFF102A5E);

  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  final TextEditingController _searchController = TextEditingController();

  int selectedCategory = 0;

  final List<String> categories = ["All", "PDF", "Slides", "Videos", "Saved"];

  final List<ResourceModel> resources = [
    ResourceModel(title: "Congress Scientific Program", subtitle: "Complete schedule and session details", type: "PDF", size: "4.2 MB", icon: Icons.picture_as_pdf_rounded, color: Color(0xFFE53935)),
    ResourceModel(title: "Pediatric Nutrition Guidelines", subtitle: "Clinical reference material", type: "PDF", size: "2.8 MB", icon: Icons.menu_book_rounded, color: Color(0xFF084BDB)),
    ResourceModel(title: "Keynote Presentation Slides", subtitle: "The Next Era of Nutrition & Health", type: "Slides", size: "8.6 MB", icon: Icons.slideshow_rounded, color: Color(0xFFFFC857)),
    ResourceModel(title: "Expert Panel Recording", subtitle: "Watch the panel discussion again", type: "Videos", size: "120 MB", icon: Icons.play_circle_fill_rounded, color: Color(0xFF20C7F7)),
  ];

  List<ResourceModel> get filteredResources {
    final query = _searchController.text.trim().toLowerCase();

    return resources.where((item) {
      final matchesCategory = selectedCategory == 0 || categories[selectedCategory] == item.type || (categories[selectedCategory] == "Saved" && item.saved);

      final matchesSearch = query.isEmpty || item.title.toLowerCase().contains(query) || item.subtitle.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _downloadResource(ResourceModel item) {
    setState(() {
      item.downloaded = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${item.title} downloaded")));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredResources;

    return Scaffold(
      backgroundColor: ResourcesPage.navyDark,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [ResourcesPage.navyDark, ResourcesPage.navy, Color(0xFF021653)]),
                ),
              ),

              const Positioned.fill(child: CustomPaint(painter: ResourcesBackgroundPainter())),

              SafeArea(
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 0), child: _topBar(context)),

                    SizedBox(height: 22.h),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: _headerCard(),
                    ),

                    SizedBox(height: 18.h),

                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(22.w, 22.h, 22.w, 0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F8FC),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(34.r), topRight: Radius.circular(34.r)),
                        ),
                        child: Column(
                          children: [
                            _searchBar(),

                            SizedBox(height: 16.h),

                            _categoryChips(),

                            SizedBox(height: 18.h),

                            Expanded(
                              child: items.isEmpty
                                  ? _emptyState()
                                  : ListView.builder(
                                      padding: EdgeInsets.only(bottom: 24.h),
                                      itemCount: items.length,
                                      itemBuilder: (context, index) {
                                        final resource = items[index];

                                        return _resourceCard(resource);
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 46.w,
            width: 46.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.10),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withOpacity(.14)),
            ),
            child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18.sp),
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Text(
            "Resources",
            style: TextStyle(color: Colors.white, fontSize: 23.sp, fontWeight: FontWeight.w900),
          ),
        ),
        Container(
          height: 46.w,
          width: 46.w,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.10),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withOpacity(.14)),
          ),
          child: Icon(Icons.folder_open_rounded, color: ResourcesPage.gold, size: 23.sp),
        ),
      ],
    );
  }

  Widget _headerCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.09),
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: Colors.white.withOpacity(.16)),
      ),
      child: Row(
        children: [
          Container(
            width: 62.w,
            height: 62.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.r),
              gradient: const LinearGradient(colors: [ResourcesPage.cyan, ResourcesPage.royalBlue]),
            ),
            child: Icon(Icons.cloud_download_rounded, color: Colors.white, size: 34.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Congress Library",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Access presentations, documents and media files",
                  style: TextStyle(color: Colors.white.withOpacity(.72), fontSize: 12.sp, height: 1.35, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE1E8F4)),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: const Color(0xFF8B96B1), size: 22.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search resources",
                hintStyle: TextStyle(color: const Color(0xFF8B96B1), fontSize: 13.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          if (_searchController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() {});
              },
              child: Icon(Icons.close_rounded, color: const Color(0xFF8B96B1), size: 20.sp),
            ),
        ],
      ),
    );
  }

  Widget _categoryChips() {
    return SizedBox(
      height: 38.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final selected = selectedCategory == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: selected ? ResourcesPage.royalBlue : Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: selected ? ResourcesPage.royalBlue : const Color(0xFFE1E8F4)),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(color: selected ? Colors.white : const Color(0xFF6D7895), fontSize: 12.sp, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _resourceCard(ResourceModel item) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: item.saved ? ResourcesPage.gold.withOpacity(.65) : const Color(0xFFE1E8F4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.045), blurRadius: 14.r, offset: Offset(0, 7.h))],
      ),
      child: Row(
        children: [
          Container(
            width: 58.w,
            height: 58.w,
            decoration: BoxDecoration(color: item.color.withOpacity(.14), borderRadius: BorderRadius.circular(18.r)),
            child: Icon(item.icon, color: item.color, size: 30.sp),
          ),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.type.toUpperCase(),
                  style: TextStyle(color: item.color, fontSize: 9.sp, letterSpacing: .5, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 5.h),
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: ResourcesPage.textDark, fontSize: 14.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 5.h),
                Text(
                  item.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: const Color(0xFF6D7895), fontSize: 11.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.storage_rounded, color: const Color(0xFF8B96B1), size: 13.sp),
                    SizedBox(width: 4.w),
                    Text(
                      item.size,
                      style: TextStyle(color: const Color(0xFF8B96B1), fontSize: 10.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 12.w),
                    if (item.downloaded)
                      Text(
                        "Downloaded",
                        style: TextStyle(color: ResourcesPage.royalBlue, fontSize: 10.sp, fontWeight: FontWeight.w900),
                      ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    item.saved = !item.saved;
                  });
                },
                child: Icon(item.saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, color: item.saved ? ResourcesPage.gold : const Color(0xFF8B96B1), size: 24.sp),
              ),
              SizedBox(height: 18.h),
              GestureDetector(
                onTap: () => _downloadResource(item),
                child: Icon(item.downloaded ? Icons.check_circle_rounded : Icons.download_rounded, color: item.downloaded ? ResourcesPage.royalBlue : const Color(0xFF8B96B1), size: 24.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded, color: const Color(0xFF8B96B1), size: 56.sp),
          SizedBox(height: 12.h),
          Text(
            "No resources found",
            style: TextStyle(color: ResourcesPage.textDark, fontSize: 17.sp, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class ResourceModel {
  final String title;
  final String subtitle;
  final String type;
  final String size;
  final IconData icon;
  final Color color;
  bool saved;
  bool downloaded;

  ResourceModel({required this.title, required this.subtitle, required this.type, required this.size, required this.icon, required this.color, this.saved = false, this.downloaded = false});
}

class ResourcesBackgroundPainter extends CustomPainter {
  const ResourcesBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(.045)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    final goldPaint = Paint()
      ..color = const Color(0xFFFFC857).withOpacity(.10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (int i = 0; i < 5; i++) {
      final path = Path()
        ..moveTo(-100.w, size.height * (.14 + i * .04))
        ..quadraticBezierTo(size.width * .25, size.height * (.08 + i * .035), size.width * .75, size.height * (.20 + i * .025));

      canvas.drawPath(path, linePaint);
    }

    final goldPath = Path()
      ..moveTo(-90.w, size.height * .68)
      ..quadraticBezierTo(size.width * .18, size.height * .58, size.width * .62, size.height * .70);

    canvas.drawPath(goldPath, goldPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
