import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeakersPage extends StatelessWidget {
  const SpeakersPage({super.key});

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

            const Positioned.fill(child: CustomPaint(painter: SpeakersBackgroundPainter())),

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
                          SizedBox(height: 18.h),
                          _categoryChips(),
                          SizedBox(height: 18.h),

                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.only(bottom: 24.h),
                              children: const [
                                _SpeakerCard(name: "Dr. Sarah Johnson", role: "Pediatric Nutrition Specialist", country: "United Kingdom", session: "Future of Pediatric Nutrition", initials: "SJ", highlighted: true),
                                _SpeakerCard(name: "Dr. Hassan Ali", role: "Clinical Research Director", country: "UAE", session: "Welcome & Introduction", initials: "HA"),
                                _SpeakerCard(name: "Dr. Ahmed Khalid", role: "Medical Science Lead", country: "Saudi Arabia", session: "Clinical Research Updates", initials: "AK"),
                                _SpeakerCard(name: "Dr. Maria Gomez", role: "Neonatal Health Consultant", country: "Spain", session: "Nutrition in Early Life", initials: "MG"),
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
            "Speakers",
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
          child: Icon(Icons.star_border_rounded, color: gold, size: 24.sp),
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
              gradient: const LinearGradient(colors: [Color(0xFF20C7F7), Color(0xFF084BDB)]),
            ),
            child: Icon(Icons.groups_rounded, color: Colors.white, size: 34.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Global Medical Experts",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Meet speakers from nutrition, research and healthcare",
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
            child: Text(
              "Search speakers",
              style: TextStyle(color: const Color(0xFF8B96B1), fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),
          ),
          Icon(Icons.tune_rounded, color: royalBlue, size: 21.sp),
        ],
      ),
    );
  }

  Widget _categoryChips() {
    return SizedBox(
      height: 38.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _SpeakerChip(title: "All", selected: true),
          _SpeakerChip(title: "Nutrition"),
          _SpeakerChip(title: "Research"),
          _SpeakerChip(title: "Pediatrics"),
          _SpeakerChip(title: "Panel"),
        ],
      ),
    );
  }
}

class _SpeakerChip extends StatelessWidget {
  final String title;
  final bool selected;

  const _SpeakerChip({required this.title, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: selected ? SpeakersPage.royalBlue : Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: selected ? SpeakersPage.royalBlue : const Color(0xFFE1E8F4)),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: selected ? Colors.white : const Color(0xFF6D7895), fontSize: 12.sp, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _SpeakerCard extends StatelessWidget {
  final String name;
  final String role;
  final String country;
  final String session;
  final String initials;
  final bool highlighted;

  const _SpeakerCard({required this.name, required this.role, required this.country, required this.session, required this.initials, this.highlighted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: highlighted ? SpeakersPage.gold.withOpacity(.7) : const Color(0xFFE1E8F4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.055), blurRadius: 18.r, offset: Offset(0, 8.h))],
      ),
      child: Row(
        children: [
          Container(
            width: 66.w,
            height: 66.w,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: highlighted ? [SpeakersPage.gold, SpeakersPage.cyan] : [SpeakersPage.cyan, SpeakersPage.royalBlue]),
            ),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFEAF3FF),
              child: Text(
                initials,
                style: TextStyle(color: SpeakersPage.royalBlue, fontSize: 18.sp, fontWeight: FontWeight.w900),
              ),
            ),
          ),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  highlighted ? "FEATURED SPEAKER" : "SPEAKER",
                  style: TextStyle(color: highlighted ? SpeakersPage.gold : SpeakersPage.royalBlue, fontSize: 9.sp, letterSpacing: .5, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 5.h),
                Text(
                  name,
                  style: TextStyle(color: SpeakersPage.textDark, fontSize: 15.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 4.h),
                Text(
                  role,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: const Color(0xFF6D7895), fontSize: 11.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 7.h),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: const Color(0xFF8B96B1), size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      country,
                      style: TextStyle(color: const Color(0xFF8B96B1), fontSize: 11.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(color: const Color(0xFFEAF3FF), borderRadius: BorderRadius.circular(12.r)),
                  child: Text(
                    session,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: SpeakersPage.royalBlue, fontSize: 10.sp, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          Column(
            children: [
              Icon(highlighted ? Icons.star_rounded : Icons.star_border_rounded, color: highlighted ? SpeakersPage.gold : const Color(0xFF8B96B1), size: 24.sp),
              SizedBox(height: 18.h),
              Icon(Icons.arrow_forward_ios_rounded, color: const Color(0xFF8B96B1), size: 15.sp),
            ],
          ),
        ],
      ),
    );
  }
}

class SpeakersBackgroundPainter extends CustomPainter {
  const SpeakersBackgroundPainter();

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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
