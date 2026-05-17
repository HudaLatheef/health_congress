import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:health_congress/screens/quick_access/agenda.dart';
import 'package:health_congress/screens/quick_access/ask_qna.dart';
import 'package:health_congress/screens/quick_access/exhibitors.dart';
import 'package:health_congress/screens/quick_access/nametagepage.dart';
import 'package:health_congress/screens/quick_access/resources.dart';
import 'package:health_congress/screens/quick_access/speakers.dart';
import 'package:health_congress/screens/quick_access/venue.dart';
import 'package:health_congress/screens/quick_access/votingpage.dart';

class QuickAccessViewAllPage extends StatefulWidget {
  const QuickAccessViewAllPage({super.key});

  static const navyDark = Color(0xFF06163F);
  static const navy = Color(0xFF082B7A);
  static const royalBlue = Color(0xFF084BDB);
  static const cyan = Color(0xFF20C7F7);
  static const gold = Color(0xFFFFC857);
  static const textDark = Color(0xFF102A5E);

  @override
  State<QuickAccessViewAllPage> createState() => _QuickAccessViewAllPageState();
}

class _QuickAccessViewAllPageState extends State<QuickAccessViewAllPage> {
  final TextEditingController searchController = TextEditingController();

  int selectedCategory = 0;

  final categories = ["All", "Event", "Interactive", "Tools"];

  late final List<QuickAccessModel> items = [
    QuickAccessModel(title: "Agenda", subtitle: "View full congress schedule", category: "Event", icon: Icons.calendar_month_rounded, page: const AgendaPage()),
    QuickAccessModel(title: "Speakers", subtitle: "Explore global medical experts", category: "Event", icon: Icons.groups_rounded, page: const SpeakersPage()),
    QuickAccessModel(title: "Name Tag", subtitle: "Access your digital badge", category: "Tools", icon: Icons.badge_outlined, page: const NameTagPage()),
    QuickAccessModel(title: "Venue", subtitle: "Location, facilities and directions", category: "Tools", icon: Icons.location_on_outlined, page: const VenuePage()),
    QuickAccessModel(title: "Voting", subtitle: "Join live audience polls", category: "Interactive", icon: Icons.bar_chart_rounded, page: const VotingPage()),
    QuickAccessModel(title: "Ask Q&A", subtitle: "Submit questions to speakers", category: "Interactive", icon: Icons.chat_bubble_outline_rounded, page: const AskQAPage()),
    QuickAccessModel(title: "Resources", subtitle: "Download congress materials", category: "Tools", icon: Icons.folder_open_rounded, page: const ResourcesPage()),
    QuickAccessModel(title: "Exhibitors", subtitle: "Discover booths and partners", category: "Event", icon: Icons.business_center_outlined, page: const ExhibitorsPage()),
  ];

  List<QuickAccessModel> get filteredItems {
    final query = searchController.text.trim().toLowerCase();
    final category = categories[selectedCategory];

    return items.where((item) {
      final matchesCategory = category == "All" || item.category == category;
      final matchesSearch = query.isEmpty || item.title.toLowerCase().contains(query) || item.subtitle.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _openPage(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final data = filteredItems;

    return Scaffold(
      backgroundColor: QuickAccessViewAllPage.navyDark,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [QuickAccessViewAllPage.navyDark, QuickAccessViewAllPage.navy, Color(0xFF021653)]),
                ),
              ),

              const Positioned.fill(child: CustomPaint(painter: QuickAccessBackgroundPainter())),

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
                              child: data.isEmpty
                                  ? _emptyState()
                                  : GridView.builder(
                                      padding: EdgeInsets.only(bottom: 24.h),
                                      itemCount: data.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 14.h, crossAxisSpacing: 14.w, childAspectRatio: .82),
                                      itemBuilder: (context, index) {
                                        return _QuickAccessAnimatedCard(item: data[index], onTap: () => _openPage(data[index].page));
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
            "Quick Access",
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
          child: Icon(Icons.grid_view_rounded, color: QuickAccessViewAllPage.gold, size: 23.sp),
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
              gradient: const LinearGradient(colors: [QuickAccessViewAllPage.cyan, QuickAccessViewAllPage.royalBlue]),
            ),
            child: Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 34.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Explore Congress Tools",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Everything you need for the full event experience",
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
              controller: searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search quick access",
                hintStyle: TextStyle(color: const Color(0xFF8B96B1), fontSize: 13.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          if (searchController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                searchController.clear();
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
                color: selected ? QuickAccessViewAllPage.royalBlue : Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: selected ? QuickAccessViewAllPage.royalBlue : const Color(0xFFE1E8F4)),
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

  Widget _emptyState() {
    return Center(
      child: Text(
        "No quick links found",
        style: TextStyle(color: QuickAccessViewAllPage.textDark, fontSize: 17.sp, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _QuickAccessAnimatedCard extends StatefulWidget {
  final QuickAccessModel item;
  final VoidCallback onTap;

  const _QuickAccessAnimatedCard({required this.item, required this.onTap});

  @override
  State<_QuickAccessAnimatedCard> createState() => _QuickAccessAnimatedCardState();
}

class _QuickAccessAnimatedCardState extends State<_QuickAccessAnimatedCard> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => pressed = true);
      },
      onTapCancel: () {
        setState(() => pressed = false);
      },
      onTapUp: (_) {
        setState(() => pressed = false);
        widget.onTap();
      },
      child: AnimatedScale(
        scale: pressed ? .96 : 1,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26.r),
            border: Border.all(color: pressed ? QuickAccessViewAllPage.cyan : const Color(0xFFE1E8F4), width: pressed ? 1.4 : 1),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(.045), blurRadius: 14.r, offset: Offset(0, 7.h))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [QuickAccessViewAllPage.cyan, QuickAccessViewAllPage.royalBlue]),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [BoxShadow(color: QuickAccessViewAllPage.cyan.withOpacity(.25), blurRadius: 14.r, offset: Offset(0, 7.h))],
                ),
                child: Icon(widget.item.icon, color: Colors.white, size: 30.sp),
              ),

              const Spacer(),

              Text(
                widget.item.title,
                style: TextStyle(color: QuickAccessViewAllPage.textDark, fontSize: 16.sp, fontWeight: FontWeight.w900),
              ),

              SizedBox(height: 6.h),

              Text(
                widget.item.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: const Color(0xFF6D7895), fontSize: 11.sp, height: 1.35, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 12.h),

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
                    decoration: BoxDecoration(color: QuickAccessViewAllPage.gold.withOpacity(.18), borderRadius: BorderRadius.circular(20.r)),
                    child: Text(
                      widget.item.category,
                      style: TextStyle(color: QuickAccessViewAllPage.textDark, fontSize: 9.sp, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward_rounded, color: QuickAccessViewAllPage.royalBlue, size: 20.sp),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickAccessModel {
  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  final Widget page;

  QuickAccessModel({required this.title, required this.subtitle, required this.category, required this.icon, required this.page});
}

class QuickAccessBackgroundPainter extends CustomPainter {
  const QuickAccessBackgroundPainter();

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
