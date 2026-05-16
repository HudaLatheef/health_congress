import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  static const navyDark = Color(0xFF06163F);
  static const navy = Color(0xFF082B7A);
  static const royalBlue = Color(0xFF084BDB);
  static const cyan = Color(0xFF20C7F7);
  static const gold = Color(0xFFFFC857);
  static const textDark = Color(0xFF102A5E);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final organizationController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool acceptedTerms = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    organizationController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _createAccount() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!_formKey.currentState!.validate()) return;

    if (!acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please accept the terms and conditions")));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account created successfully")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CreateAccountPage.navyDark,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [CreateAccountPage.navyDark, CreateAccountPage.navy, Color(0xFF021653)]),
                ),
              ),

              const Positioned.fill(child: CustomPaint(painter: CreateAccountBackgroundPainter())),

              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 24.h),
                  child: Column(
                    children: [
                      _topBar(context),

                      SizedBox(height: 26.h),

                      _brandHeader(),

                      SizedBox(height: 24.h),

                      _registerCard(),

                      SizedBox(height: 20.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.white.withOpacity(.85), fontSize: 13.sp, fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              FocusScope.of(context).unfocus();
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(color: CreateAccountPage.gold, fontSize: 13.sp, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 14.h),
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

  Widget _topBar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
          },
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
            "Create Account",
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
          child: Icon(Icons.person_add_alt_1_rounded, color: CreateAccountPage.gold, size: 23.sp),
        ),
      ],
    );
  }

  Widget _brandHeader() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            border: Border.all(color: CreateAccountPage.gold.withOpacity(.85), width: 1.2),
            gradient: LinearGradient(colors: [Colors.white.withOpacity(.12), Colors.white.withOpacity(.03)]),
          ),
          child: Text(
            "NESTLÉ MEDICAL CONGRESS",
            style: TextStyle(color: Colors.white, fontSize: 11.sp, letterSpacing: 1.2, fontWeight: FontWeight.w700),
          ),
        ),

        SizedBox(height: 20.h),

        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "Join the\n",
                style: TextStyle(color: Colors.white, fontSize: 34.sp, height: 1, fontWeight: FontWeight.w900),
              ),
              TextSpan(
                text: "NESTLÉ CONGRESS",
                style: TextStyle(color: CreateAccountPage.gold, fontSize: 38.sp, height: 1.1, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),

        SizedBox(height: 10.h),

        Text(
          "Create your attendee profile and access\nsessions, resources, voting and Q&A.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(.78), fontSize: 13.sp, height: 1.4, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _registerCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.96),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.white.withOpacity(.7), width: 1.3),
        boxShadow: [
          BoxShadow(color: CreateAccountPage.cyan.withOpacity(.20), blurRadius: 25.r, offset: Offset(0, -3.h)),
          BoxShadow(color: Colors.black.withOpacity(.20), blurRadius: 28.r, offset: Offset(0, 14.h)),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _RegisterTextField(
              controller: nameController,
              hint: "Full name",
              icon: Icons.person_outline_rounded,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter your full name";
                }
                return null;
              },
            ),

            SizedBox(height: 14.h),

            _RegisterTextField(
              controller: emailController,
              hint: "Email address",
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter email";
                }
                if (!value.contains("@")) {
                  return "Enter a valid email";
                }
                return null;
              },
            ),

            SizedBox(height: 14.h),

            _RegisterTextField(
              controller: organizationController,
              hint: "Hospital / Organization",
              icon: Icons.apartment_rounded,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter organization";
                }
                return null;
              },
            ),

            SizedBox(height: 14.h),

            _RegisterTextField(
              controller: passwordController,
              hint: "Create password",
              icon: Icons.lock_outline_rounded,
              obscureText: obscurePassword,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
                child: Icon(obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: const Color(0xFF8B96B1), size: 20.sp),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter password";
                }
                if (value.length < 6) {
                  return "Password should be at least 6 characters";
                }
                return null;
              },
            ),

            SizedBox(height: 16.h),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      acceptedTerms = !acceptedTerms;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 22.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      color: acceptedTerms ? CreateAccountPage.royalBlue : Colors.white,
                      borderRadius: BorderRadius.circular(7.r),
                      border: Border.all(color: acceptedTerms ? CreateAccountPage.royalBlue : const Color(0xFFC8D3E6)),
                    ),
                    child: acceptedTerms ? Icon(Icons.check_rounded, color: Colors.white, size: 16.sp) : null,
                  ),
                ),

                SizedBox(width: 10.w),

                Expanded(
                  child: Text(
                    "I agree to the congress terms, privacy policy and attendee guidelines.",
                    style: TextStyle(color: const Color(0xFF6D7895), fontSize: 11.sp, height: 1.4, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            SizedBox(height: 22.h),

            GestureDetector(
              onTap: _createAccount,
              child: Container(
                height: 54.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.r),
                  gradient: const LinearGradient(colors: [CreateAccountPage.cyan, CreateAccountPage.royalBlue]),
                  boxShadow: [BoxShadow(color: CreateAccountPage.royalBlue.withOpacity(.28), blurRadius: 16.r, offset: Offset(0, 8.h))],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add_alt_1_rounded, color: Colors.white, size: 21.sp),
                    SizedBox(width: 9.w),
                    Text(
                      "Create Account",
                      style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 18.h),

            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey.shade300)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    "OR SIGN UP WITH",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 10.sp, fontWeight: FontWeight.w800, letterSpacing: .4),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey.shade300)),
              ],
            ),

            SizedBox(height: 14.h),

            Row(
              children: [
                Expanded(child: _socialButton("G", Colors.blue.shade600)),
                SizedBox(width: 12.w),
                Expanded(child: _socialButton("", Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(String text, Color color) {
    return Container(
      height: 46.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFDDE5F3)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: color, fontSize: 22.sp, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

class _RegisterTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _RegisterTextField({required this.controller, required this.hint, required this.icon, this.obscureText = false, this.suffixIcon, this.keyboardType, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(color: CreateAccountPage.textDark, fontSize: 14.sp, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: const Color(0xFF8B96B1), fontSize: 13.sp, fontWeight: FontWeight.w500),
        prefixIcon: Container(
          margin: EdgeInsets.all(9.w),
          decoration: const BoxDecoration(color: Color(0xFFEFF5FF), shape: BoxShape.circle),
          child: Icon(icon, color: CreateAccountPage.royalBlue, size: 20.sp),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        errorStyle: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: const BorderSide(color: Color(0xFFDDE5F3), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: const BorderSide(color: CreateAccountPage.cyan, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: const BorderSide(color: Color(0xFFE53935), width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: const BorderSide(color: Color(0xFFE53935), width: 1.4),
        ),
      ),
    );
  }
}

class CreateAccountBackgroundPainter extends CustomPainter {
  const CreateAccountBackgroundPainter();

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
      ..moveTo(-90.w, size.height * .72)
      ..quadraticBezierTo(size.width * .18, size.height * .62, size.width * .62, size.height * .74);

    canvas.drawPath(goldPath, goldPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
