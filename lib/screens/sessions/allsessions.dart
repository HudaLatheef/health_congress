import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcomingSessionsPage extends StatefulWidget {
  const UpcomingSessionsPage({super.key});

  static const navyDark = Color(0xFF06163F);
  static const navy = Color(0xFF082B7A);
  static const royalBlue = Color(0xFF084BDB);
  static const cyan = Color(0xFF20C7F7);
  static const gold = Color(0xFFFFC857);
  static const textDark = Color(0xFF102A5E);

  @override
  State<UpcomingSessionsPage> createState() => _UpcomingSessionsPageState();
}

class _UpcomingSessionsPageState extends State<UpcomingSessionsPage> {
  final TextEditingController searchController = TextEditingController();

  int selectedFilter = 0;

  final filters = ["All", "Keynote", "Nutrition", "Research", "Saved"];

  final List<SessionModel> sessions = [
    SessionModel(time: "08:30", period: "AM", title: "Opening Ceremony", speaker: "Main Auditorium", category: "Keynote", icon: Icons.event_available_rounded, highlighted: true),
    SessionModel(time: "09:30", period: "AM", title: "Welcome & Introduction", speaker: "Dr. Hassan Ali", category: "Keynote", icon: Icons.mic_rounded),
    SessionModel(time: "10:30", period: "AM", title: "Future of Pediatric Nutrition", speaker: "Dr. Sarah Johnson", category: "Nutrition", icon: Icons.spa_rounded),
    SessionModel(time: "12:00", period: "PM", title: "Clinical Research Updates", speaker: "Dr. Ahmed Khalid", category: "Research", icon: Icons.science_rounded),
    SessionModel(time: "02:00", period: "PM", title: "Panel Discussion & Q&A", speaker: "Global Expert Panel", category: "Keynote", icon: Icons.groups_rounded),
  ];

  List<SessionModel> get filteredSessions {
    final query = searchController.text.trim().toLowerCase();
    final filter = filters[selectedFilter];

    return sessions.where((item) {
      final matchesFilter = filter == "All" || filter == item.category || (filter == "Saved" && item.saved);

      final matchesSearch = query.isEmpty || item.title.toLowerCase().contains(query) || item.speaker.toLowerCase().contains(query) || item.category.toLowerCase().contains(query);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  void _showSessionDetails(SessionModel session) {
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
                width: 76.w,
                height: 76.w,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [UpcomingSessionsPage.cyan, UpcomingSessionsPage.royalBlue]),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Icon(session.icon, color: Colors.white, size: 38.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                session.title,
                textAlign: TextAlign.center,
                style: TextStyle(color: UpcomingSessionsPage.textDark, fontSize: 22.sp, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 8.h),
              Text(
                session.speaker,
                style: TextStyle(color: const Color(0xFF6D7895), fontSize: 13.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 18.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(color: const Color(0xFFF4F7FB), borderRadius: BorderRadius.circular(20.r)),
                child: Row(
                  children: [
                    Icon(Icons.schedule_rounded, color: UpcomingSessionsPage.royalBlue, size: 24.sp),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        "${session.time} ${session.period} • ${session.category}",
                        style: TextStyle(color: UpcomingSessionsPage.textDark, fontSize: 14.sp, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Expanded(
                    child: _sheetButton(title: "Add to Schedule", icon: Icons.calendar_month_rounded, dark: true),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _sheetButton(title: "Share", icon: Icons.share_rounded, dark: false),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
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
        gradient: dark ? const LinearGradient(colors: [UpcomingSessionsPage.cyan, UpcomingSessionsPage.royalBlue]) : null,
        color: dark ? null : const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(17.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: dark ? Colors.white : UpcomingSessionsPage.royalBlue, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(color: dark ? Colors.white : UpcomingSessionsPage.royalBlue, fontSize: 13.sp, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = filteredSessions;

    return Scaffold(
      backgroundColor: UpcomingSessionsPage.navyDark,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [UpcomingSessionsPage.navyDark, UpcomingSessionsPage.navy, Color(0xFF021653)]),
                ),
              ),

              const Positioned.fill(child: CustomPaint(painter: UpcomingSessionsBackgroundPainter())),

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
                            _filterChips(),
                            SizedBox(height: 18.h),

                            Expanded(
                              child: data.isEmpty
                                  ? _emptyState()
                                  : ListView.builder(
                                      padding: EdgeInsets.only(bottom: 24.h),
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        return _SessionAnimatedCard(
                                          session: data[index],
                                          onTap: () => _showSessionDetails(data[index]),
                                          onBookmarkTap: () {
                                            setState(() {
                                              data[index].saved = !data[index].saved;
                                            });
                                          },
                                        );
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
            "Upcoming Sessions",
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
          child: Icon(Icons.event_note_rounded, color: UpcomingSessionsPage.gold, size: 23.sp),
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
              gradient: const LinearGradient(colors: [UpcomingSessionsPage.gold, Color(0xFFFF9F1C)]),
            ),
            child: Icon(Icons.schedule_rounded, color: Colors.white, size: 34.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today’s Program",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Browse sessions, save favorites and view details",
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
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search sessions or speakers",
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

  Widget _filterChips() {
    return SizedBox(
      height: 38.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final selected = selectedFilter == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: selected ? UpcomingSessionsPage.royalBlue : Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: selected ? UpcomingSessionsPage.royalBlue : const Color(0xFFE1E8F4)),
              ),
              child: Center(
                child: Text(
                  filters[index],
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
        "No sessions found",
        style: TextStyle(color: UpcomingSessionsPage.textDark, fontSize: 17.sp, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _SessionAnimatedCard extends StatefulWidget {
  final SessionModel session;
  final VoidCallback onTap;
  final VoidCallback onBookmarkTap;

  const _SessionAnimatedCard({required this.session, required this.onTap, required this.onBookmarkTap});

  @override
  State<_SessionAnimatedCard> createState() => _SessionAnimatedCardState();
}

class _SessionAnimatedCardState extends State<_SessionAnimatedCard> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.session;

    return GestureDetector(
      onTapDown: (_) => setState(() => pressed = true),
      onTapCancel: () => setState(() => pressed = false),
      onTapUp: (_) {
        setState(() => pressed = false);
        widget.onTap();
      },
      child: AnimatedScale(
        scale: pressed ? .97 : 1,
        duration: const Duration(milliseconds: 140),
        child: Container(
          margin: EdgeInsets.only(bottom: 14.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: item.highlighted ? UpcomingSessionsPage.gold.withOpacity(.65) : const Color(0xFFE1E8F4)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(.045), blurRadius: 14.r, offset: Offset(0, 7.h))],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 50.w,
                child: Column(
                  children: [
                    Text(
                      item.time,
                      style: TextStyle(color: UpcomingSessionsPage.royalBlue, fontSize: 18.sp, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      item.period,
                      style: TextStyle(color: const Color(0xFF8B96B1), fontSize: 11.sp, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),

              Container(
                width: 1.w,
                height: 58.h,
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                color: const Color(0xFFE1E8F4),
              ),

              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(color: item.highlighted ? UpcomingSessionsPage.gold.withOpacity(.18) : UpcomingSessionsPage.cyan.withOpacity(.13), borderRadius: BorderRadius.circular(16.r)),
                child: Icon(item.icon, color: item.highlighted ? UpcomingSessionsPage.gold : UpcomingSessionsPage.royalBlue, size: 24.sp),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.category.toUpperCase(),
                      style: TextStyle(color: item.highlighted ? UpcomingSessionsPage.gold : UpcomingSessionsPage.royalBlue, fontSize: 10.sp, fontWeight: FontWeight.w900, letterSpacing: .5),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: UpcomingSessionsPage.textDark, fontSize: 14.sp, height: 1.25, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      item.speaker,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: const Color(0xFF8B96B1), fontSize: 11.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: widget.onBookmarkTap,
                child: Icon(item.saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, color: item.saved ? UpcomingSessionsPage.gold : const Color(0xFF8B96B1), size: 24.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SessionModel {
  final String time;
  final String period;
  final String title;
  final String speaker;
  final String category;
  final IconData icon;
  final bool highlighted;
  bool saved;

  SessionModel({required this.time, required this.period, required this.title, required this.speaker, required this.category, required this.icon, this.highlighted = false, this.saved = false});
}

class UpcomingSessionsBackgroundPainter extends CustomPainter {
  const UpcomingSessionsBackgroundPainter();

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
