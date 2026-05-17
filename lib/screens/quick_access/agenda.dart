import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  static const navyDark = Color(0xFF06163F);
  static const navy = Color(0xFF082B7A);
  static const royalBlue = Color(0xFF084BDB);
  static const cyan = Color(0xFF20C7F7);
  static const gold = Color(0xFFFFC857);
  static const textDark = Color(0xFF102A5E);

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final TextEditingController searchController = TextEditingController();

  int selectedDay = 0;
  int selectedFilter = 0;
  bool showSearch = false;

  final filters = ["All", "Keynote", "Nutrition", "Research", "Discussion"];

  final List<AgendaSessionModel> sessions = [
    AgendaSessionModel(day: 0, time: "08:30", period: "AM", title: "Opening Ceremony", speaker: "Main Auditorium", category: "Keynote", icon: Icons.event_available_rounded, isHighlighted: true),
    AgendaSessionModel(day: 0, time: "09:30", period: "AM", title: "Welcome & Introduction", speaker: "Dr. Hassan Ali", category: "Keynote", icon: Icons.mic_rounded),
    AgendaSessionModel(day: 0, time: "10:30", period: "AM", title: "Future of Pediatric Nutrition", speaker: "Dr. Sarah Johnson", category: "Nutrition", icon: Icons.spa_rounded),
    AgendaSessionModel(day: 0, time: "12:00", period: "PM", title: "Clinical Research Updates", speaker: "Dr. Ahmed Khalid", category: "Research", icon: Icons.science_rounded),
    AgendaSessionModel(day: 1, time: "09:00", period: "AM", title: "Panel Discussion & Q&A", speaker: "Global Expert Panel", category: "Discussion", icon: Icons.groups_rounded),
    AgendaSessionModel(day: 1, time: "11:00", period: "AM", title: "Digital Health in Nutrition", speaker: "Dr. Maria Gomez", category: "Research", icon: Icons.devices_rounded),
  ];

  List<AgendaSessionModel> get filteredSessions {
    final query = searchController.text.trim().toLowerCase();
    final filter = filters[selectedFilter];

    return sessions.where((item) {
      final matchesDay = item.day == selectedDay;

      final matchesFilter = filter == "All" || item.category == filter;

      final matchesSearch = query.isEmpty || item.title.toLowerCase().contains(query) || item.speaker.toLowerCase().contains(query) || item.category.toLowerCase().contains(query);

      return matchesDay && matchesFilter && matchesSearch;
    }).toList();
  }

  void _showSessionDetails(AgendaSessionModel session) {
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
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AgendaPage.cyan, AgendaPage.royalBlue]),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Icon(session.icon, color: Colors.white, size: 38.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                session.title,
                textAlign: TextAlign.center,
                style: TextStyle(color: AgendaPage.textDark, fontSize: 22.sp, fontWeight: FontWeight.w900),
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
                    Icon(Icons.schedule_rounded, color: AgendaPage.royalBlue, size: 24.sp),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        "${session.time} ${session.period} • ${session.category}",
                        style: TextStyle(color: AgendaPage.textDark, fontSize: 14.sp, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Expanded(
                    child: _sheetButton(title: session.saved ? "Saved" : "Add to Schedule", icon: session.saved ? Icons.check_circle_rounded : Icons.calendar_month_rounded, dark: true),
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
        gradient: dark ? const LinearGradient(colors: [AgendaPage.cyan, AgendaPage.royalBlue]) : null,
        color: dark ? null : const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(17.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: dark ? Colors.white : AgendaPage.royalBlue, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(color: dark ? Colors.white : AgendaPage.royalBlue, fontSize: 13.sp, fontWeight: FontWeight.w900),
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
      backgroundColor: AgendaPage.navyDark,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AgendaPage.navyDark, AgendaPage.navy, Color(0xFF021653)]),
                ),
              ),
              const Positioned.fill(child: CustomPaint(painter: AgendaBackgroundPainter())),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 0),
                      child: Column(
                        children: [
                          _topBar(context),
                          SizedBox(height: 20.h),
                          if (showSearch) ...[_searchBar(), SizedBox(height: 16.h)],
                          _headerCard(),
                          SizedBox(height: 18.h),
                          _daySelector(),
                        ],
                      ),
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
                            _filterRow(),
                            SizedBox(height: 14.h),
                            _filterChips(),
                            SizedBox(height: 18.h),
                            Expanded(
                              child: data.isEmpty
                                  ? _emptyState()
                                  : ListView.builder(
                                      padding: EdgeInsets.only(bottom: 22.h),
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        final session = data[index];

                                        return _AgendaSessionCard(
                                          session: session,
                                          onTap: () => _showSessionDetails(session),
                                          onBookmarkTap: () {
                                            setState(() {
                                              session.saved = !session.saved;
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
            "Congress Agenda",
            style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w900),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              showSearch = !showSearch;
              if (!showSearch) searchController.clear();
            });
          },
          child: Container(
            height: 46.w,
            width: 46.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.10),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withOpacity(.14)),
            ),
            child: Icon(showSearch ? Icons.close_rounded : Icons.search_rounded, color: Colors.white, size: 23.sp),
          ),
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.10),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.white.withOpacity(.18)),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: Colors.white.withOpacity(.75), size: 22.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: searchController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              onChanged: (_) => setState(() {}),
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search sessions, speakers...",
                hintStyle: TextStyle(color: Colors.white.withOpacity(.55), fontSize: 13.sp),
              ),
            ),
          ),
        ],
      ),
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
              gradient: const LinearGradient(colors: [Color(0xFFFFC857), Color(0xFFFF9F1C)]),
            ),
            child: Icon(Icons.calendar_month_rounded, color: Colors.white, size: 34.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedDay == 0 ? "Day 1 Schedule" : "Day 2 Schedule",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 6.h),
                Text(
                  selectedDay == 0 ? "Thursday, May 22, 2026" : "Friday, May 23, 2026",
                  style: TextStyle(color: Colors.white.withOpacity(.72), fontSize: 13.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _daySelector() {
    return Row(
      children: [
        Expanded(
          child: _DayChip(
            title: "Day 1",
            date: "May 22",
            selected: selectedDay == 0,
            onTap: () {
              setState(() {
                selectedDay = 0;
              });
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _DayChip(
            title: "Day 2",
            date: "May 23",
            selected: selectedDay == 1,
            onTap: () {
              setState(() {
                selectedDay = 1;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _filterRow() {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Today’s Sessions",
            style: TextStyle(color: AgendaPage.textDark, fontSize: 20.sp, fontWeight: FontWeight.w900),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedFilter = 0;
              searchController.clear();
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 9.h),
            decoration: BoxDecoration(color: const Color(0xFFEAF3FF), borderRadius: BorderRadius.circular(14.r)),
            child: Row(
              children: [
                Icon(Icons.refresh_rounded, color: AgendaPage.royalBlue, size: 18.sp),
                SizedBox(width: 6.w),
                Text(
                  "Reset",
                  style: TextStyle(color: AgendaPage.royalBlue, fontSize: 13.sp, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
      ],
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
                color: selected ? AgendaPage.royalBlue : Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: selected ? AgendaPage.royalBlue : const Color(0xFFE1E8F4)),
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
        style: TextStyle(color: AgendaPage.textDark, fontSize: 17.sp, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  final String title;
  final String date;
  final bool selected;
  final VoidCallback onTap;

  const _DayChip({required this.title, required this.date, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(vertical: 13.h),
        decoration: BoxDecoration(
          color: selected ? AgendaPage.gold : Colors.white.withOpacity(.09),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: selected ? AgendaPage.gold : Colors.white.withOpacity(.14)),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(color: selected ? AgendaPage.textDark : Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 3.h),
            Text(
              date,
              style: TextStyle(color: selected ? AgendaPage.textDark.withOpacity(.7) : Colors.white.withOpacity(.65), fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _AgendaSessionCard extends StatefulWidget {
  final AgendaSessionModel session;
  final VoidCallback onTap;
  final VoidCallback onBookmarkTap;

  const _AgendaSessionCard({required this.session, required this.onTap, required this.onBookmarkTap});

  @override
  State<_AgendaSessionCard> createState() => _AgendaSessionCardState();
}

class _AgendaSessionCardState extends State<_AgendaSessionCard> {
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
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(color: item.isHighlighted ? AgendaPage.gold.withOpacity(.65) : const Color(0xFFE1E8F4)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(.055), blurRadius: 18.r, offset: Offset(0, 8.h))],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 52.w,
                child: Column(
                  children: [
                    Text(
                      item.time,
                      style: TextStyle(color: AgendaPage.royalBlue, fontSize: 18.sp, fontWeight: FontWeight.w900),
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
                width: 46.w,
                height: 46.w,
                decoration: BoxDecoration(color: item.isHighlighted ? AgendaPage.gold.withOpacity(.18) : AgendaPage.cyan.withOpacity(.13), borderRadius: BorderRadius.circular(16.r)),
                child: Icon(item.icon, color: item.isHighlighted ? AgendaPage.gold : AgendaPage.royalBlue, size: 24.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.category.toUpperCase(),
                      style: TextStyle(color: item.isHighlighted ? AgendaPage.gold : AgendaPage.royalBlue, fontSize: 10.sp, fontWeight: FontWeight.w900, letterSpacing: .5),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AgendaPage.textDark, fontSize: 14.sp, height: 1.25, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: const Color(0xFF8B96B1), size: 14.sp),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            item.speaker,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: const Color(0xFF8B96B1), fontSize: 11.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 6.w),
              GestureDetector(
                onTap: widget.onBookmarkTap,
                child: Icon(item.saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, color: item.saved ? AgendaPage.gold : const Color(0xFF8B96B1), size: 22.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AgendaSessionModel {
  final int day;
  final String time;
  final String period;
  final String title;
  final String speaker;
  final String category;
  final IconData icon;
  final bool isHighlighted;
  bool saved;

  AgendaSessionModel({required this.day, required this.time, required this.period, required this.title, required this.speaker, required this.category, required this.icon, this.isHighlighted = false, this.saved = false});
}

class AgendaBackgroundPainter extends CustomPainter {
  const AgendaBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(.045)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    final cyanPaint = Paint()
      ..color = const Color(0xFF20C7F7).withOpacity(.10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (int i = 0; i < 5; i++) {
      final path = Path()
        ..moveTo(-100.w, size.height * (.14 + i * .04))
        ..quadraticBezierTo(size.width * .25, size.height * (.08 + i * .035), size.width * .75, size.height * (.20 + i * .025));

      canvas.drawPath(path, linePaint);
    }

    final cyanPath = Path()
      ..moveTo(size.width * .45, -40.h)
      ..quadraticBezierTo(size.width * .75, size.height * .12, size.width + 70.w, size.height * .04);

    canvas.drawPath(cyanPath, cyanPaint);

    final dotPaint = Paint()
      ..color = Colors.white.withOpacity(.10)
      ..style = PaintingStyle.fill;

    for (int x = 0; x < 4; x++) {
      for (int y = 0; y < 5; y++) {
        canvas.drawCircle(Offset(12.w + x * 14.w, 58.h + y * 14.h), 1.5.r, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
