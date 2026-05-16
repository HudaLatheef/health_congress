import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const navyDark = Color(0xFF06163F);
  static const navy = Color(0xFF082B7A);
  static const royalBlue = Color(0xFF084BDB);
  static const cyan = Color(0xFF20C7F7);
  static const gold = Color(0xFFFFC857);
  static const textDark = Color(0xFF102A5E);

  @override
  Widget build(BuildContext context) {
    Widget _logoutButton() {
      return InkWell(
        onTap: () {
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: 54.h,
          decoration: BoxDecoration(
            color: const Color(0xFFFFEEF0),
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: const Color(0xFFFFCDD2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_rounded, color: const Color(0xFFD32F2F), size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                "Logout",
                style: TextStyle(color: const Color(0xFFD32F2F), fontSize: 15.sp, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      );
    }

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

            const Positioned.fill(child: CustomPaint(painter: ProfileBackgroundPainter())),

            SafeArea(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 0), child: _topBar(context)),

                  SizedBox(height: 24.h),

                  _profileHeader(),

                  SizedBox(height: 24.h),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(22.w, 24.h, 22.w, 0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F8FC),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(34.r), topRight: Radius.circular(34.r)),
                      ),
                      child: ListView(
                        padding: EdgeInsets.only(bottom: 24.h),
                        children: [
                          _infoCard(),
                          SizedBox(height: 18.h),
                          _statsRow(),
                          SizedBox(height: 22.h),
                          _sectionTitle("Account"),
                          SizedBox(height: 12.h),
                          _menuCard(icon: Icons.person_outline_rounded, title: "Edit Profile", subtitle: "Update your personal information"),
                          _menuCard(icon: Icons.badge_outlined, title: "My Name Tag", subtitle: "View your congress badge"),
                          _menuCard(icon: Icons.bookmark_border_rounded, title: "Saved Sessions", subtitle: "Sessions you bookmarked"),
                          SizedBox(height: 16.h),
                          _sectionTitle("Congress"),
                          SizedBox(height: 12.h),
                          _menuCard(icon: Icons.event_available_rounded, title: "My Schedule", subtitle: "Your selected agenda sessions"),
                          _menuCard(icon: Icons.workspace_premium_outlined, title: "Certificates", subtitle: "Download attendance certificates"),
                          _menuCard(icon: Icons.notifications_none_rounded, title: "Notifications", subtitle: "Manage app alerts"),
                          SizedBox(height: 18.h),
                          _logoutButton(),
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
            "My Profile",
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
          child: Icon(Icons.settings_outlined, color: Colors.white, size: 23.sp),
        ),
      ],
    );
  }

  Widget _profileHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 104.w,
                height: 104.w,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(colors: [gold, cyan]),
                  boxShadow: [BoxShadow(color: cyan.withOpacity(.28), blurRadius: 24.r, offset: Offset(0, 10.h))],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    "HL",
                    style: TextStyle(color: royalBlue, fontSize: 32.sp, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Container(
                width: 34.w,
                height: 34.w,
                decoration: BoxDecoration(
                  color: gold,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3.w),
                ),
                child: Icon(Icons.edit_rounded, color: textDark, size: 16.sp),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          Text(
            "Huda Latheef",
            style: TextStyle(color: Colors.white, fontSize: 25.sp, fontWeight: FontWeight.w900),
          ),

          SizedBox(height: 5.h),

          Text(
            "Medical Congress Attendee",
            style: TextStyle(color: Colors.white.withOpacity(.75), fontSize: 13.sp, fontWeight: FontWeight.w600),
          ),

          SizedBox(height: 14.h),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.10),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(color: gold.withOpacity(.6)),
            ),
            child: Text(
              "ID: NMC-2026-001",
              style: TextStyle(color: gold, fontSize: 12.sp, fontWeight: FontWeight.w800, letterSpacing: .4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard() {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.055), blurRadius: 18.r, offset: Offset(0, 8.h))],
      ),
      child: Column(
        children: [
          _infoRow(icon: Icons.email_outlined, title: "Email", value: "huda@example.com"),
          Divider(height: 24.h, color: const Color(0xFFE1E8F4)),
          _infoRow(icon: Icons.phone_outlined, title: "Phone", value: "+971 56 283 4212"),
          Divider(height: 24.h, color: const Color(0xFFE1E8F4)),
          _infoRow(icon: Icons.location_on_outlined, title: "Location", value: "Dubai, UAE"),
        ],
      ),
    );
  }

  Widget _infoRow({required IconData icon, required String title, required String value}) {
    return Row(
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(color: cyan.withOpacity(.12), borderRadius: BorderRadius.circular(14.r)),
          child: Icon(icon, color: royalBlue, size: 21.sp),
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
              SizedBox(height: 3.h),
              Text(
                value,
                style: TextStyle(color: textDark, fontSize: 14.sp, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statsRow() {
    return Row(
      children: [
        Expanded(
          child: _statCard(count: "12", title: "Sessions", icon: Icons.event_note_rounded),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _statCard(count: "05", title: "Saved", icon: Icons.bookmark_rounded),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _statCard(count: "03", title: "Certificates", icon: Icons.workspace_premium_rounded),
        ),
      ],
    );
  }

  Widget _statCard({required String count, required String title, required IconData icon}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: const Color(0xFFE1E8F4)),
      ),
      child: Column(
        children: [
          Icon(icon, color: royalBlue, size: 25.sp),
          SizedBox(height: 8.h),
          Text(
            count,
            style: TextStyle(color: textDark, fontSize: 20.sp, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 3.h),
          Text(
            title,
            style: TextStyle(color: const Color(0xFF8B96B1), fontSize: 11.sp, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: textDark, fontSize: 18.sp, fontWeight: FontWeight.w900),
    );
  }

  Widget _menuCard({required IconData icon, required String title, required String subtitle}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFE1E8F4)),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(color: const Color(0xFFEAF3FF), borderRadius: BorderRadius.circular(15.r)),
            child: Icon(icon, color: royalBlue, size: 22.sp),
          ),
          SizedBox(width: 13.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: textDark, fontSize: 14.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(color: const Color(0xFF8B96B1), fontSize: 11.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, color: const Color(0xFF8B96B1), size: 15.sp),
        ],
      ),
    );
  }
}

class ProfileBackgroundPainter extends CustomPainter {
  const ProfileBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(.045)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    final goldPaint = Paint()
      ..color = const Color(0xFFFFC857).withOpacity(.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (int i = 0; i < 5; i++) {
      final path = Path()
        ..moveTo(-100.w, size.height * (.16 + i * .04))
        ..quadraticBezierTo(size.width * .25, size.height * (.08 + i * .035), size.width * .75, size.height * (.22 + i * .025));

      canvas.drawPath(path, linePaint);
    }

    final goldPath = Path()
      ..moveTo(-80.w, size.height * .52)
      ..quadraticBezierTo(size.width * .25, size.height * .42, size.width * .65, size.height * .52);

    canvas.drawPath(goldPath, goldPaint);

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
