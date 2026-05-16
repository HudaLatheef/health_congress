import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExhibitorsPage extends StatefulWidget {
  const ExhibitorsPage({super.key});

  static const navyDark = Color(0xFF06163F);
  static const navy = Color(0xFF082B7A);
  static const royalBlue = Color(0xFF084BDB);
  static const cyan = Color(0xFF20C7F7);
  static const gold = Color(0xFFFFC857);
  static const textDark = Color(0xFF102A5E);

  @override
  State<ExhibitorsPage> createState() => _ExhibitorsPageState();
}

class _ExhibitorsPageState extends State<ExhibitorsPage> {
  final TextEditingController _searchController = TextEditingController();

  int selectedCategory = 0;

  final List<String> categories = ["All", "Nutrition", "Medical", "Digital", "Saved"];

  final List<ExhibitorModel> exhibitors = [
    ExhibitorModel(name: "Nestlé Health Science", category: "Nutrition", booth: "A-01", description: "Advanced nutrition solutions for patients and professionals.", icon: Icons.health_and_safety_rounded, color: Color(0xFF084BDB), featured: true),
    ExhibitorModel(name: "MediCare Innovations", category: "Medical", booth: "B-12", description: "Clinical tools and medical support solutions.", icon: Icons.medical_services_rounded, color: Color(0xFF20C7F7)),
    ExhibitorModel(name: "Digital Health Hub", category: "Digital", booth: "C-07", description: "Smart healthcare platforms and patient engagement apps.", icon: Icons.devices_rounded, color: Color(0xFFFFC857)),
    ExhibitorModel(name: "Pediatric Nutrition Lab", category: "Nutrition", booth: "A-14", description: "Research-based nutritional support for early life care.", icon: Icons.science_rounded, color: Color(0xFF6B22D8)),
  ];

  List<ExhibitorModel> get filteredExhibitors {
    final query = _searchController.text.trim().toLowerCase();

    return exhibitors.where((item) {
      final matchesCategory = selectedCategory == 0 || categories[selectedCategory] == item.category || (categories[selectedCategory] == "Saved" && item.saved);

      final matchesSearch = query.isEmpty || item.name.toLowerCase().contains(query) || item.description.toLowerCase().contains(query) || item.booth.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _showBoothDetails(ExhibitorModel exhibitor) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(22.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48.w,
                height: 5.h,
                decoration: BoxDecoration(color: const Color(0xFFD6DEEE), borderRadius: BorderRadius.circular(20.r)),
              ),
              SizedBox(height: 22.h),
              Container(
                width: 74.w,
                height: 74.w,
                decoration: BoxDecoration(color: exhibitor.color.withOpacity(.14), borderRadius: BorderRadius.circular(24.r)),
                child: Icon(exhibitor.icon, color: exhibitor.color, size: 38.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                exhibitor.name,
                textAlign: TextAlign.center,
                style: TextStyle(color: ExhibitorsPage.textDark, fontSize: 22.sp, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 8.h),
              Text(
                exhibitor.description,
                textAlign: TextAlign.center,
                style: TextStyle(color: const Color(0xFF6D7895), fontSize: 13.sp, height: 1.4, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(color: const Color(0xFFF4F7FB), borderRadius: BorderRadius.circular(20.r)),
                child: Row(
                  children: [
                    Icon(Icons.location_on_rounded, color: ExhibitorsPage.royalBlue, size: 24.sp),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        "Booth ${exhibitor.booth} • Exhibition Hall",
                        style: TextStyle(color: ExhibitorsPage.textDark, fontSize: 14.sp, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Expanded(
                    child: _sheetButton(title: "Directions", icon: Icons.navigation_rounded, dark: true),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _sheetButton(title: "Contact", icon: Icons.call_outlined, dark: false),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }

  Widget _sheetButton({required String title, required IconData icon, required bool dark}) {
    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        gradient: dark ? const LinearGradient(colors: [ExhibitorsPage.cyan, ExhibitorsPage.royalBlue]) : null,
        color: dark ? null : const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(17.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: dark ? Colors.white : ExhibitorsPage.royalBlue, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(color: dark ? Colors.white : ExhibitorsPage.royalBlue, fontSize: 14.sp, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredExhibitors;

    return Scaffold(
      backgroundColor: ExhibitorsPage.navyDark,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [ExhibitorsPage.navyDark, ExhibitorsPage.navy, Color(0xFF021653)]),
                ),
              ),

              const Positioned.fill(child: CustomPaint(painter: ExhibitorsBackgroundPainter())),

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
                                        return _exhibitorCard(items[index]);
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
            "Exhibitors",
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
          child: Icon(Icons.business_center_outlined, color: ExhibitorsPage.gold, size: 23.sp),
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
              gradient: const LinearGradient(colors: [ExhibitorsPage.gold, Color(0xFFFF9F1C)]),
            ),
            child: Icon(Icons.storefront_rounded, color: Colors.white, size: 34.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Exhibition Hall",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Discover partners, booths, products and services",
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
                hintText: "Search exhibitors or booth number",
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
                color: selected ? ExhibitorsPage.royalBlue : Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: selected ? ExhibitorsPage.royalBlue : const Color(0xFFE1E8F4)),
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

  Widget _exhibitorCard(ExhibitorModel item) {
    return GestureDetector(
      onTap: () => _showBoothDetails(item),
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: item.featured ? ExhibitorsPage.gold.withOpacity(.65) : const Color(0xFFE1E8F4)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(.045), blurRadius: 14.r, offset: Offset(0, 7.h))],
        ),
        child: Row(
          children: [
            Container(
              width: 62.w,
              height: 62.w,
              decoration: BoxDecoration(color: item.color.withOpacity(.14), borderRadius: BorderRadius.circular(20.r)),
              child: Icon(item.icon, color: item.color, size: 32.sp),
            ),

            SizedBox(width: 14.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _smallBadge(item.category),
                      if (item.featured) ...[SizedBox(width: 7.w), _smallBadge("Featured", color: ExhibitorsPage.gold, textColor: ExhibitorsPage.textDark)],
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: ExhibitorsPage.textDark, fontSize: 15.sp, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: const Color(0xFF6D7895), fontSize: 11.sp, height: 1.35, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 9.h),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: ExhibitorsPage.royalBlue, size: 15.sp),
                      SizedBox(width: 4.w),
                      Text(
                        "Booth ${item.booth}",
                        style: TextStyle(color: ExhibitorsPage.royalBlue, fontSize: 11.sp, fontWeight: FontWeight.w900),
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
                  child: Icon(item.saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, color: item.saved ? ExhibitorsPage.gold : const Color(0xFF8B96B1), size: 24.sp),
                ),
                SizedBox(height: 22.h),
                Icon(Icons.arrow_forward_ios_rounded, color: const Color(0xFF8B96B1), size: 15.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallBadge(String text, {Color color = const Color(0xFFEAF3FF), Color textColor = ExhibitorsPage.royalBlue}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20.r)),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 9.sp, fontWeight: FontWeight.w900),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Text(
        "No exhibitors found",
        style: TextStyle(color: ExhibitorsPage.textDark, fontSize: 17.sp, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class ExhibitorModel {
  final String name;
  final String category;
  final String booth;
  final String description;
  final IconData icon;
  final Color color;
  final bool featured;
  bool saved;

  ExhibitorModel({required this.name, required this.category, required this.booth, required this.description, required this.icon, required this.color, this.featured = false, this.saved = false});
}

class ExhibitorsBackgroundPainter extends CustomPainter {
  const ExhibitorsBackgroundPainter();

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
