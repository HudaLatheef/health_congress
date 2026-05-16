import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({super.key});

  static const navyDark = Color(0xFF06163F);
  static const navy = Color(0xFF082B7A);
  static const royalBlue = Color(0xFF084BDB);
  static const cyan = Color(0xFF20C7F7);
  static const gold = Color(0xFFFFC857);
  static const textDark = Color(0xFF102A5E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navyDark,
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [navyDark, navy, Color(0xFF021653)]),
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
                        SizedBox(height: 24.h),
                        _headerCard(),
                        SizedBox(height: 20.h),
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
                          SizedBox(height: 18.h),

                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.only(bottom: 22.h),
                              children: const [
                                _AgendaSessionCard(time: "08:30", period: "AM", title: "Opening Ceremony", speaker: "Main Auditorium", category: "Welcome", icon: Icons.event_available_rounded, isHighlighted: true),
                                _AgendaSessionCard(time: "09:30", period: "AM", title: "Welcome & Introduction", speaker: "Dr. Hassan Ali", category: "Keynote", icon: Icons.mic_rounded),
                                _AgendaSessionCard(time: "10:30", period: "AM", title: "Future of Pediatric Nutrition", speaker: "Dr. Sarah Johnson", category: "Nutrition", icon: Icons.spa_rounded),
                                _AgendaSessionCard(time: "12:00", period: "PM", title: "Clinical Research Updates", speaker: "Dr. Ahmed Khalid", category: "Research", icon: Icons.science_rounded),
                                _AgendaSessionCard(time: "02:00", period: "PM", title: "Panel Discussion & Q&A", speaker: "Global Expert Panel", category: "Discussion", icon: Icons.groups_rounded),
                              ],
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
        Container(
          height: 46.w,
          width: 46.w,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.10),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withOpacity(.14)),
          ),
          child: Icon(Icons.search_rounded, color: Colors.white, size: 23.sp),
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
                  "Day 1 Schedule",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Thursday, May 22, 2026",
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
          child: _DayChip(title: "Day 1", date: "May 22", selected: true),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _DayChip(title: "Day 2", date: "May 23", selected: false),
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
            style: TextStyle(color: textDark, fontSize: 20.sp, fontWeight: FontWeight.w900),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 9.h),
          decoration: BoxDecoration(color: const Color(0xFFEAF3FF), borderRadius: BorderRadius.circular(14.r)),
          child: Row(
            children: [
              Icon(Icons.tune_rounded, color: royalBlue, size: 18.sp),
              SizedBox(width: 6.w),
              Text(
                "Filter",
                style: TextStyle(color: royalBlue, fontSize: 13.sp, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DayChip extends StatelessWidget {
  final String title;
  final String date;
  final bool selected;

  const _DayChip({required this.title, required this.date, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _AgendaSessionCard extends StatelessWidget {
  final String time;
  final String period;
  final String title;
  final String speaker;
  final String category;
  final IconData icon;
  final bool isHighlighted;

  const _AgendaSessionCard({required this.time, required this.period, required this.title, required this.speaker, required this.category, required this.icon, this.isHighlighted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: isHighlighted ? AgendaPage.gold.withOpacity(.65) : const Color(0xFFE1E8F4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.055), blurRadius: 18.r, offset: Offset(0, 8.h))],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 52.w,
            child: Column(
              children: [
                Text(
                  time,
                  style: TextStyle(color: AgendaPage.royalBlue, fontSize: 18.sp, fontWeight: FontWeight.w900),
                ),
                Text(
                  period,
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
            decoration: BoxDecoration(color: isHighlighted ? AgendaPage.gold.withOpacity(.18) : AgendaPage.cyan.withOpacity(.13), borderRadius: BorderRadius.circular(16.r)),
            child: Icon(icon, color: isHighlighted ? AgendaPage.gold : AgendaPage.royalBlue, size: 24.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.toUpperCase(),
                  style: TextStyle(color: isHighlighted ? AgendaPage.gold : AgendaPage.royalBlue, fontSize: 10.sp, fontWeight: FontWeight.w900, letterSpacing: .5),
                ),
                SizedBox(height: 5.h),
                Text(
                  title,
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
                        speaker,
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
          Icon(Icons.bookmark_border_rounded, color: const Color(0xFF8B96B1), size: 22.sp),
        ],
      ),
    );
  }
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
