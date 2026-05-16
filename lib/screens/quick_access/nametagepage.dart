import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NameTagPage extends StatelessWidget {
  const NameTagPage({super.key});

  static const navyDark = Color(0xFF06163F);
  static const navy = Color(0xFF082B7A);
  static const royalBlue = Color(0xFF084BDB);
  static const cyan = Color(0xFF20C7F7);
  static const gold = Color(0xFFFFC857);
  static const textDark = Color(0xFF102A5E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: navyDark,
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          children: [
            /// Background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [navyDark, navy, Color(0xFF021653)]),
              ),
            ),

            const Positioned.fill(child: CustomPaint(painter: NameTagBackgroundPainter())),

            SafeArea(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 0), child: _topBar(context)),

                  SizedBox(height: 26.h),

                  /// Badge Card
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(22.w, 0, 22.w, 20.h),

                      child: Container(
                        width: double.infinity,

                        padding: EdgeInsets.all(22.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(36.r),
                          boxShadow: [BoxShadow(color: cyan.withOpacity(.18), blurRadius: 30.r, offset: Offset(0, 12.h))],
                        ),
                        child: Column(
                          children: [
                            /// Top Strip
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [Color(0xFF20C7F7), Color(0xFF084BDB)]),
                                borderRadius: BorderRadius.circular(22.r),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "NESTLÉ MEDICAL",
                                    style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w900, letterSpacing: 1),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "CONGRESS 2026",
                                    style: TextStyle(color: gold, fontSize: 13.sp, fontWeight: FontWeight.w800, letterSpacing: .8),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 10.h),

                            /// Avatar
                            Container(
                              width: 110.w,
                              height: 110.w,
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(colors: [gold, cyan]),
                              ),
                              child: CircleAvatar(
                                backgroundColor: const Color(0xFFEAF3FF),
                                child: Text(
                                  "HL",
                                  style: TextStyle(color: royalBlue, fontSize: 34.sp, fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),

                            SizedBox(height: 10.h),

                            /// Name
                            Text(
                              "Huda Latheef",
                              style: TextStyle(color: textDark, fontSize: 28.sp, fontWeight: FontWeight.w900),
                            ),

                            Text(
                              "Flutter Developer • Attendee",
                              style: TextStyle(color: const Color(0xFF6D7895), fontSize: 14.sp, fontWeight: FontWeight.w600),
                            ),

                            // SizedBox(height: 22.h),

                            /// Divider
                            Row(
                              children: [
                                Expanded(child: Divider(color: const Color(0xFFE1E8F4), thickness: 1)),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Icon(Icons.workspace_premium_rounded, color: gold, size: 24.sp),
                                ),
                                Expanded(child: Divider(color: const Color(0xFFE1E8F4), thickness: 1)),
                              ],
                            ),

                            SizedBox(height: 10.h),

                            /// Info
                            _infoTile(icon: Icons.badge_outlined, title: "Badge ID", value: "NMC-2026-001"),

                            SizedBox(height: 10.h),

                            _infoTile(icon: Icons.location_on_outlined, title: "Location", value: "Dubai, UAE"),

                            SizedBox(height: 10.h),

                            _infoTile(icon: Icons.calendar_month_rounded, title: "Congress Date", value: "22 - 23 May 2026"),

                            SizedBox(height: 10.h),

                            /// QR
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(color: const Color(0xFFF4F7FB), borderRadius: BorderRadius.circular(22.r)),
                              child: Column(
                                children: [
                                  Container(
                                    width: 130.w,
                                    height: 130.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18.r),
                                      border: Border.all(color: const Color(0xFFE1E8F4)),
                                    ),
                                    child: Icon(Icons.qr_code_2_rounded, size: 100.sp, color: textDark),
                                  ),

                                  SizedBox(height: 14.h),

                                  Text(
                                    "Scan for attendee verification",
                                    style: TextStyle(color: const Color(0xFF6D7895), fontSize: 12.sp, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 24.h),

                            /// Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: _actionButton(icon: Icons.download_rounded, title: "Download", dark: false),
                                ),
                                SizedBox(width: 14.w),
                                Expanded(
                                  child: _actionButton(icon: Icons.share_rounded, title: "Share", dark: true),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
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
            "My Name Tag",
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
          child: Icon(Icons.print_rounded, color: gold, size: 23.sp),
        ),
      ],
    );
  }

  Widget _infoTile({required IconData icon, required String title, required String value}) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(color: const Color(0xFFF4F7FB), borderRadius: BorderRadius.circular(18.r)),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(color: cyan.withOpacity(.12), borderRadius: BorderRadius.circular(14.r)),
            child: Icon(icon, color: royalBlue, size: 22.sp),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: const Color(0xFF8B96B1), fontSize: 11.sp, fontWeight: FontWeight.w700),
                ),

                Text(
                  value,
                  style: TextStyle(color: textDark, fontSize: 14.sp, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({required IconData icon, required String title, required bool dark}) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        gradient: dark ? const LinearGradient(colors: [Color(0xFF20C7F7), Color(0xFF084BDB)]) : null,
        color: dark ? null : const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: dark ? Colors.white : royalBlue, size: 21.sp),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(color: dark ? Colors.white : royalBlue, fontSize: 14.sp, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class NameTagBackgroundPainter extends CustomPainter {
  const NameTagBackgroundPainter();

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
        ..moveTo(-100.w, size.height * (.15 + i * .04))
        ..quadraticBezierTo(size.width * .25, size.height * (.08 + i * .035), size.width * .75, size.height * (.22 + i * .025));

      canvas.drawPath(path, linePaint);
    }

    final goldPath = Path()
      ..moveTo(-90.w, size.height * .72)
      ..quadraticBezierTo(size.width * .18, size.height * .62, size.width * .62, size.height * .74);

    canvas.drawPath(goldPath, goldPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
