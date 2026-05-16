import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:health_congress/screens/quick_access/agenda/agenda.dart';
import 'package:health_congress/screens/profile/profilepage.dart';
import 'package:health_congress/screens/quick_access/speakers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const navyDark = Color(0xFF06163F);
  static const navy = Color(0xFF082B7A);
  static const cyan = Color(0xFF20C7F7);
  static const gold = Color(0xFFFFC857);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _pageController.animateToPage(index, duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNav(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [HomeContent(), ProfilePage()],
      ),
    );
  }

  Widget _bottomNav() {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF06163F),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.25), blurRadius: 20.r, offset: Offset(0, -6.h))],
      ),
      child: Row(
        children: [
          Expanded(
            child: _NavItem(icon: Icons.home_rounded, label: "Home", selected: _selectedIndex == 0, onTap: () => _onTabChanged(0)),
          ),
          Expanded(
            child: _NavItem(icon: Icons.person_outline_rounded, label: "Profile", selected: _selectedIndex == 1, onTap: () => _onTabChanged(1)),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        padding: EdgeInsets.symmetric(vertical: 0.h),
        decoration: BoxDecoration(
          color: selected ? HomePage.cyan.withOpacity(.16) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: selected ? Border.all(color: HomePage.cyan.withOpacity(.35)) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selected ? HomePage.cyan : Colors.white54, size: 26.sp),
            SizedBox(height: 5.h),
            Text(
              label,
              style: TextStyle(color: selected ? Colors.white : Colors.white54, fontSize: 12.sp, fontWeight: selected ? FontWeight.w800 : FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeBackgroundPainter extends CustomPainter {
  const HomeBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(.045)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final cyanPaint = Paint()
      ..color = const Color(0xFF20C7F7).withOpacity(.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (int i = 0; i < 5; i++) {
      final path = Path()
        ..moveTo(-80, size.height * (.18 + i * .04))
        ..quadraticBezierTo(size.width * .25, size.height * (.12 + i * .035), size.width * .75, size.height * (.22 + i * .025));
      canvas.drawPath(path, linePaint);
    }

    final curve = Path()
      ..moveTo(size.width * .45, -40)
      ..quadraticBezierTo(size.width * .75, size.height * .16, size.width + 60, size.height * .06);

    canvas.drawPath(curve, cyanPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [HomePage.navyDark, HomePage.navy, Color(0xFF021653)]),
          ),
        ),

        const Positioned.fill(child: CustomPaint(painter: HomeBackgroundPainter())),

        SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(22.w, 20.h, 22.w, 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topBar(context),
                const SizedBox(height: 26),

                const Text(
                  "Welcome Back,\nDr. Testing 👋",
                  style: TextStyle(color: Colors.white, fontSize: 30, height: 1.15, fontWeight: FontWeight.w900),
                ),

                const SizedBox(height: 22),
                _searchBar(),

                const SizedBox(height: 26),
                _featuredEvent(),

                const SizedBox(height: 28),
                _sectionHeader("Quick Access"),
                const SizedBox(height: 16),
                _quickAccessGrid(),

                const SizedBox(height: 28),
                _sectionHeader("Upcoming Sessions"),
                const SizedBox(height: 16),

                _sessionCard(time: "08:30\nAM", title: "Opening Ceremony", speaker: "Main Auditorium"),
                _sessionCard(time: "09:30\nAM", title: "Welcome & Introduction", speaker: "Dr. Hassan Ali"),
                _sessionCard(time: "10:30\nAM", title: "Future of Pediatric Nutrition", speaker: "Dr. Sarah Johnson"),

                const SizedBox(height: 24),
                _profileBanner(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _topBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            /// Back Button
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                FocusScope.of(context).unfocus();
              },
              child: Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.10),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(.12)),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
              ),
            ),

            const SizedBox(width: 16),

            /// Title
            const Text(
              "NESTLÉ MEDICAL CONGRESS",
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 1.1),
            ),
          ],
        ),

        /// Notification
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white.withOpacity(.10), shape: BoxShape.circle),
              child: const Icon(Icons.notifications_none_rounded, color: Colors.white),
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(color: Color(0xFFFF4D5A), shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(.18)),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: Colors.white.withOpacity(.75)),
          const SizedBox(width: 12),
          Expanded(
            child: Text("Search sessions, speakers, topics...", style: TextStyle(color: Colors.white.withOpacity(.55), fontSize: 14)),
          ),
          Container(
            padding: const EdgeInsets.all(9),
            decoration: const BoxDecoration(color: HomePage.cyan, shape: BoxShape.circle),
            child: const Icon(Icons.tune_rounded, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _featuredEvent() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.08),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(.20)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: HomePage.gold),
                    ),
                    child: const Text(
                      "FEATURED EVENT",
                      style: TextStyle(color: HomePage.gold, fontSize: 11, fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "The Next Era of\nNutrition & Health",
                    style: TextStyle(color: Colors.white, fontSize: 24, height: 1.15, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 14),
                  Text("May 22 - 23, 2026  •  Riyadh, KSA", style: TextStyle(color: Colors.white.withOpacity(.75), fontSize: 13)),
                ],
              ),
            ),
            Container(
              height: 96,
              width: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [HomePage.cyan.withOpacity(.65), HomePage.cyan.withOpacity(.12), Colors.transparent]),
              ),
              child: const Icon(Icons.spa_rounded, color: Colors.white, size: 52),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const Text(
          "View All  ›",
          style: TextStyle(color: HomePage.cyan, fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _quickAccessGrid() {
    final items = [
      [Icons.calendar_month_rounded, "Agenda"],
      [Icons.groups_rounded, "Speakers"],
      [Icons.badge_outlined, "Name Tag"],
      [Icons.location_on_outlined, "Venue"],
      [Icons.bar_chart_rounded, "Voting"],
      [Icons.chat_bubble_outline_rounded, "Ask Q&A"],
      [Icons.folder_open_rounded, "Resources"],
      [Icons.business_center_outlined, "Exhibitors"],
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 14, crossAxisSpacing: 12, childAspectRatio: .86),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SpeakersPage()));
          },

          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.09),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withOpacity(.12)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(items[index][0] as IconData, color: HomePage.cyan, size: 30),
                const SizedBox(height: 10),
                Text(
                  items[index][1] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sessionCard({required String time, required String title, required String speaker}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(.10)),
      ),
      child: Row(
        children: [
          Text(
            time,
            textAlign: TextAlign.center,
            style: const TextStyle(color: HomePage.cyan, fontSize: 15, height: 1.25, fontWeight: FontWeight.w800),
          ),
          Container(height: 45, width: 1, margin: const EdgeInsets.symmetric(horizontal: 16), color: Colors.white.withOpacity(.22)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(color: HomePage.gold, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 7),
                    Text(speaker, style: TextStyle(color: Colors.white.withOpacity(.65), fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.bookmark_border_rounded, color: Colors.white.withOpacity(.65)),
        ],
      ),
    );
  }

  Widget _profileBanner() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(colors: [Color(0xFF0AA8FF), Color(0xFF2335E8), Color(0xFF6B22D8)]),
      ),
      child: Row(
        children: [
          const Text("🏆", style: TextStyle(fontSize: 42)),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Complete your profile",
                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 5),
                Text("Get the full experience", style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: const Text(
              "Update",
              style: TextStyle(color: Color(0xFF084BDB), fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
