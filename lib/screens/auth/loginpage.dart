import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_congress/screens/home/homepage.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});

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
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [navyDark, navy, Color(0xFF021653)]),
                ),
              ),

              const Positioned.fill(child: CustomPaint(painter: LuxuryBackgroundPainter())),

              Positioned(
                top: -120.h,
                right: -100.w,
                child: _glowCircle(size: 260.w, color: cyan.withOpacity(.35)),
              ),

              Positioned(
                bottom: 90.h,
                left: -120.w,
                child: _glowCircle(size: 230.w, color: gold.withOpacity(.22)),
              ),

              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),

                      /// Badge
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.r),
                          border: Border.all(color: gold.withOpacity(.85), width: 1.2),
                          gradient: LinearGradient(colors: [Colors.white.withOpacity(.12), Colors.white.withOpacity(.03)]),
                        ),
                        child: Text(
                          "NESTLÉ MEDICAL CONGRESS",
                          style: TextStyle(color: Colors.white, fontSize: 11.sp, letterSpacing: 1.2, fontWeight: FontWeight.w700),
                        ),
                      ),

                      SizedBox(height: 22.h),

                      /// Title
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "NESTLÉ\n",
                              style: TextStyle(fontSize: 38.sp, height: 1, fontWeight: FontWeight.w900, color: Colors.white),
                            ),
                            TextSpan(
                              text: "CONGRESS",
                              style: TextStyle(fontSize: 40.sp, height: 1, fontWeight: FontWeight.w900, color: gold),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10.h),

                      Container(
                        width: 52.w,
                        height: 2.h,
                        decoration: BoxDecoration(color: gold, borderRadius: BorderRadius.circular(10.r)),
                      ),

                      SizedBox(height: 10.h),

                      Text(
                        "The Next Era of\nNutrition & Health",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white.withOpacity(.88), fontSize: 16.sp, height: 1.3, fontWeight: FontWeight.w500),
                      ),

                      SizedBox(height: 22.h),

                      /// Login Card
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 18.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.96),
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(color: Colors.white.withOpacity(.7), width: 1.3),
                            boxShadow: [
                              BoxShadow(color: cyan.withOpacity(.20), blurRadius: 25.r, offset: Offset(0, -3.h)),
                              BoxShadow(color: Colors.black.withOpacity(.20), blurRadius: 28.r, offset: Offset(0, 14.h)),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Header
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Welcome Back",
                                          style: TextStyle(color: textDark, fontSize: 24.sp, fontWeight: FontWeight.w900),
                                        ),

                                        Text(
                                          "Sign in to continue your congress experience",
                                          style: TextStyle(color: const Color(0xFF6D7895), fontSize: 12.sp, height: 1.35, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    width: 54.w,
                                    height: 54.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      gradient: const LinearGradient(colors: [Color(0xFF35A7FF), Color(0xFF063BCE)]),
                                    ),
                                    child: Icon(Icons.health_and_safety_rounded, color: Colors.white, size: 30.sp),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20.h),

                              _PremiumTextField(hint: "Enter your email", icon: Icons.person_outline_rounded),

                              SizedBox(height: 12.h),

                              _PremiumTextField(hint: "Enter your password", icon: Icons.lock_outline_rounded, obscureText: true),

                              SizedBox(height: 18.h),

                              SizedBox(
                                width: double.infinity,
                                height: 52.h,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.r),
                                    gradient: const LinearGradient(colors: [Color(0xFF1017C9), Color(0xFF0078FF), Color(0xFF22C8F7)]),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(CupertinoPageRoute(builder: (_) => HomePage()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Sign In",
                                          style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800),
                                        ),
                                        SizedBox(width: 14.w),
                                        Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 21.sp),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 14.h),

                              Row(
                                children: [
                                  Expanded(child: Divider(color: Colors.grey.shade300)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Text(
                                      "OR CONTINUE WITH",
                                      style: TextStyle(color: Colors.grey.shade600, fontSize: 10.sp, fontWeight: FontWeight.w700, letterSpacing: .4),
                                    ),
                                  ),
                                  Expanded(child: Divider(color: Colors.grey.shade300)),
                                ],
                              ),

                              SizedBox(height: 12.h),

                              Row(
                                children: [
                                  Expanded(
                                    child: _SocialButton(text: "G", color: Colors.blue.shade600),
                                  ),
                                  SizedBox(width: 12.w),
                                  const Expanded(
                                    child: _SocialButton(text: "", color: Colors.black),
                                  ),
                                ],
                              ),

                              SizedBox(height: 10.h),

                              Center(
                                child: TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.lock_outline_rounded, size: 17.sp, color: royalBlue),
                                  label: Text(
                                    "Forgot password?",
                                    style: TextStyle(color: royalBlue, fontSize: 13.sp, fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account? ",
                            style: TextStyle(color: Colors.white.withOpacity(.9), fontSize: 13.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Create Account →",
                            style: TextStyle(color: gold, fontSize: 13.sp, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),

                      SizedBox(height: 12.h),

                      /// Bottom Benefits
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.08),
                          borderRadius: BorderRadius.circular(22.r),
                          border: Border.all(color: Colors.white.withOpacity(.16)),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: _BenefitItem(icon: Icons.groups_rounded, title: "Global\nExperts", color: cyan),
                            ),
                            _VerticalLine(),
                            Expanded(
                              child: _BenefitItem(icon: Icons.event_available_rounded, title: "Knowledge\nSessions", color: cyan),
                            ),
                            _VerticalLine(),
                            Expanded(
                              child: _BenefitItem(icon: Icons.star_border_rounded, title: "Networking\nOpportunities", color: gold),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _glowCircle({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withOpacity(.05), Colors.transparent]),
      ),
    );
  }
}

class _PremiumTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscureText;

  const _PremiumTextField({required this.hint, required this.icon, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      child: TextField(
        obscureText: obscureText,
        style: TextStyle(color: const Color(0xFF102A5E), fontSize: 14.sp, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: const Color(0xFF8B96B1), fontSize: 13.sp, fontWeight: FontWeight.w500),
          prefixIcon: Container(
            margin: EdgeInsets.all(9.w),
            decoration: const BoxDecoration(color: Color(0xFFEFF5FF), shape: BoxShape.circle),
            child: Icon(icon, color: const Color(0xFF0647C8), size: 20.sp),
          ),
          suffixIcon: obscureText ? Icon(Icons.visibility_off_outlined, color: const Color(0xFF8B96B1), size: 20.sp) : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.r),
            borderSide: const BorderSide(color: Color(0xFFDDE5F3), width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.r),
            borderSide: const BorderSide(color: Color(0xFF20C7F7), width: 1.4),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String text;
  final Color color;

  const _SocialButton({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFDDE5F3)),
      ),
      child: Center(
        child: text == "G"
            ? Text(
                text,
                style: TextStyle(color: color, fontSize: 22.sp, fontWeight: FontWeight.w900),
              )
            : Icon(Icons.apple),
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _BenefitItem({required this.icon, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 34.w,
          width: 34.w,
          decoration: BoxDecoration(
            color: color.withOpacity(.14),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: color.withOpacity(.45)),
          ),
          child: Icon(icon, color: color, size: 18.sp),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 10.sp, height: 1.15, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _VerticalLine extends StatelessWidget {
  const _VerticalLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      width: 1.w,
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      color: Colors.white.withOpacity(.14),
    );
  }
}

class LuxuryBackgroundPainter extends CustomPainter {
  const LuxuryBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    /// Soft White Curves
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(.045)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    /// Gold Accent Curve
    final goldPaint = Paint()
      ..color = const Color(0xFFFFC857).withOpacity(.10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    /// Cyan Accent Curve
    final cyanPaint = Paint()
      ..color = const Color(0xFF20C7F7).withOpacity(.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    /// Top White Curves
    for (int i = 0; i < 5; i++) {
      final path = Path()
        ..moveTo(-120.w, size.height * (.18 + i * .035))
        ..quadraticBezierTo(size.width * .20, size.height * (.10 + i * .04), size.width * .65, size.height * (.20 + i * .025));

      canvas.drawPath(path, linePaint);
    }

    /// Right Side Cyan Curve
    final cyanPath = Path()
      ..moveTo(size.width * .55, -50.h)
      ..quadraticBezierTo(size.width * .85, size.height * .12, size.width + 60.w, size.height * .04);

    canvas.drawPath(cyanPath, cyanPaint);

    /// Bottom Gold Curve
    final goldPath = Path()
      ..moveTo(-100.w, size.height * .78)
      ..quadraticBezierTo(size.width * .18, size.height * .66, size.width * .58, size.height * .74);

    canvas.drawPath(goldPath, goldPaint);

    /// Top Left Dot Pattern
    final dotPaint = Paint()
      ..color = Colors.white.withOpacity(.10)
      ..style = PaintingStyle.fill;

    for (int x = 0; x < 4; x++) {
      for (int y = 0; y < 5; y++) {
        canvas.drawCircle(Offset(10.w + x * 14.w, 40.h + y * 14.h), 1.5.r, dotPaint);
      }
    }

    /// Bottom Right Dot Pattern
    for (int x = 0; x < 4; x++) {
      for (int y = 0; y < 5; y++) {
        canvas.drawCircle(Offset(size.width - 60.w + x * 14.w, size.height - 220.h + y * 14.h), 1.4.r, dotPaint);
      }
    }

    /// Large Transparent Circle
    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(.025)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * .82, size.height * .18), 120.r, glowPaint);

    /// Small Bottom Circle
    canvas.drawCircle(Offset(size.width * .12, size.height * .82), 80.r, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
