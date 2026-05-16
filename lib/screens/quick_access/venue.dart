import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VenuePage extends StatelessWidget {
  const VenuePage({super.key});

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

            const Positioned.fill(child: CustomPaint(painter: VenueBackgroundPainter())),

            SafeArea(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 0), child: _topBar(context)),

                  SizedBox(height: 22.h),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(22.w, 0, 22.w, 24.h),
                      child: Column(
                        children: [
                          _venueHeroCard(),
                          SizedBox(height: 18.h),
                          _addressCard(),
                          SizedBox(height: 18.h),
                          _mapPreviewCard(),
                          SizedBox(height: 18.h),
                          _facilitiesSection(),
                          SizedBox(height: 18.h),
                          _transportCard(),
                          SizedBox(height: 18.h),
                          _actionButtons(),
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
            "Venue",
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
          child: Icon(Icons.navigation_rounded, color: gold, size: 23.sp),
        ),
      ],
    );
  }

  Widget _venueHeroCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.09),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.white.withOpacity(.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF20C7F7), Color(0xFF084BDB), Color(0xFF06163F)]),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -30.w,
                  top: -30.h,
                  child: Icon(Icons.location_city_rounded, size: 160.sp, color: Colors.white.withOpacity(.10)),
                ),
                Center(
                  child: Container(
                    width: 82.w,
                    height: 82.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.16),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(.28)),
                    ),
                    child: Icon(Icons.apartment_rounded, color: Colors.white, size: 45.sp),
                  ),
                ),
                Positioned(
                  left: 18.w,
                  bottom: 18.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                    decoration: BoxDecoration(color: gold, borderRadius: BorderRadius.circular(20.r)),
                    child: Text(
                      "MAIN VENUE",
                      style: TextStyle(color: textDark, fontSize: 11.sp, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 18.h),

          Text(
            "Dubai International Convention & Exhibition Center",
            style: TextStyle(color: Colors.white, fontSize: 22.sp, height: 1.2, fontWeight: FontWeight.w900),
          ),

          SizedBox(height: 8.h),

          Row(
            children: [
              Icon(Icons.calendar_month_rounded, color: cyan, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                "22 - 23 May 2026",
                style: TextStyle(color: Colors.white.withOpacity(.76), fontSize: 13.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _addressCard() {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24.r)),
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(color: cyan.withOpacity(.12), borderRadius: BorderRadius.circular(18.r)),
            child: Icon(Icons.location_on_rounded, color: royalBlue, size: 28.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Venue Address",
                  style: TextStyle(color: const Color(0xFF8B96B1), fontSize: 12.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 5.h),
                Text(
                  "World Trade Centre, Dubai, United Arab Emirates",
                  style: TextStyle(color: textDark, fontSize: 14.sp, height: 1.35, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapPreviewCard() {
    return Container(
      height: 190.h,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(26.r)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26.r),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFEAF3FF), Color(0xFFD7ECFF)])),
            ),

            Positioned.fill(child: CustomPaint(painter: FakeMapPainter())),

            Center(
              child: Container(
                width: 58.w,
                height: 58.w,
                decoration: BoxDecoration(
                  color: gold,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: gold.withOpacity(.45), blurRadius: 18.r)],
                ),
                child: Icon(Icons.location_on_rounded, color: textDark, size: 32.sp),
              ),
            ),

            Positioned(
              left: 16.w,
              top: 16.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
                child: Text(
                  "Map Preview",
                  style: TextStyle(color: textDark, fontSize: 12.sp, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _facilitiesSection() {
    final facilities = [
      [Icons.wifi_rounded, "Free Wi-Fi"],
      [Icons.local_parking_rounded, "Parking"],
      [Icons.restaurant_rounded, "Catering"],
      [Icons.accessible_rounded, "Accessible"],
    ];

    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Venue Facilities",
            style: TextStyle(color: textDark, fontSize: 18.sp, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: facilities.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12.h, crossAxisSpacing: 12.w, childAspectRatio: 2.8),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(color: const Color(0xFFF4F7FB), borderRadius: BorderRadius.circular(16.r)),
                child: Row(
                  children: [
                    Icon(facilities[index][0] as IconData, color: royalBlue, size: 22.sp),
                    SizedBox(width: 10.w),
                    Text(
                      facilities[index][1] as String,
                      style: TextStyle(color: textDark, fontSize: 12.sp, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _transportCard() {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.09),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Getting There",
            style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 14.h),
          _transportRow(icon: Icons.directions_car_rounded, title: "By Car", subtitle: "20 minutes from city center"),
          SizedBox(height: 12.h),
          _transportRow(icon: Icons.local_taxi_rounded, title: "Taxi / Ride-hailing", subtitle: "Available from airport and hotels"),
          SizedBox(height: 12.h),
          _transportRow(icon: Icons.flight_rounded, title: "Airport", subtitle: "Approx. 25 minutes from King Khalid Airport"),
        ],
      ),
    );
  }

  Widget _transportRow({required IconData icon, required String title, required String subtitle}) {
    return Row(
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(color: cyan.withOpacity(.14), borderRadius: BorderRadius.circular(14.r)),
          child: Icon(icon, color: cyan, size: 22.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 3.h),
              Text(
                subtitle,
                style: TextStyle(color: Colors.white.withOpacity(.65), fontSize: 11.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _actionButtons() {
    return Row(
      children: [
        Expanded(
          child: _venueButton(icon: Icons.directions_rounded, title: "Directions", dark: true),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: _venueButton(icon: Icons.share_location_rounded, title: "Share", dark: false),
        ),
      ],
    );
  }

  Widget _venueButton({required IconData icon, required String title, required bool dark}) {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        gradient: dark ? const LinearGradient(colors: [Color(0xFF20C7F7), Color(0xFF084BDB)]) : null,
        color: dark ? null : Colors.white.withOpacity(.10),
        borderRadius: BorderRadius.circular(18.r),
        border: dark ? null : Border.all(color: Colors.white.withOpacity(.18)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 21.sp),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class VenueBackgroundPainter extends CustomPainter {
  const VenueBackgroundPainter();

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

class FakeMapPainter extends CustomPainter {
  const FakeMapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white.withOpacity(.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.w
      ..strokeCap = StrokeCap.round;

    final smallRoadPaint = Paint()
      ..color = Colors.white.withOpacity(.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.w
      ..strokeCap = StrokeCap.round;

    final mainRoad = Path()
      ..moveTo(-20.w, size.height * .72)
      ..quadraticBezierTo(size.width * .35, size.height * .48, size.width + 20.w, size.height * .58);

    canvas.drawPath(mainRoad, roadPaint);

    final road2 = Path()
      ..moveTo(size.width * .10, -20.h)
      ..quadraticBezierTo(size.width * .38, size.height * .32, size.width * .25, size.height + 20.h);

    canvas.drawPath(road2, smallRoadPaint);

    final road3 = Path()
      ..moveTo(size.width * .70, -10.h)
      ..quadraticBezierTo(size.width * .55, size.height * .42, size.width * .90, size.height + 10.h);

    canvas.drawPath(road3, smallRoadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
