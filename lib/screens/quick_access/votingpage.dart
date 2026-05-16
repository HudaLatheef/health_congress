import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VotingPage extends StatefulWidget {
  const VotingPage({super.key});

  static const navyDark = Color(0xFF06163F);
  static const navy = Color(0xFF082B7A);
  static const royalBlue = Color(0xFF084BDB);
  static const cyan = Color(0xFF20C7F7);
  static const gold = Color(0xFFFFC857);
  static const textDark = Color(0xFF102A5E);

  @override
  State<VotingPage> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  final PageController _pageController = PageController();

  int currentPoll = 0;
  final Map<int, int> selectedAnswers = {};
  final Set<int> submittedPolls = {};

  final List<PollModel> polls = [
    PollModel(question: "Which topic was most valuable for you today?", session: "Live Session Poll", options: ["Pediatric Nutrition", "Clinical Research", "Digital Health", "Panel Discussion"], votes: [42, 28, 18, 12]),
    PollModel(question: "How would you rate the current session?", session: "Audience Feedback", options: ["Excellent", "Very Good", "Good", "Needs Improvement"], votes: [55, 30, 10, 5]),
    PollModel(question: "Which session should we extend tomorrow?", session: "Agenda Voting", options: ["Expert Panel Q&A", "Nutrition Workshop", "Clinical Case Studies", "Networking Session"], votes: [35, 25, 27, 13]),
  ];

  void _submitVote() {
    if (selectedAnswers[currentPoll] == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select an option first")));
      return;
    }

    setState(() {
      submittedPolls.add(currentPoll);
      final selectedIndex = selectedAnswers[currentPoll]!;
      polls[currentPoll].votes[selectedIndex]++;
    });
  }

  void _nextPoll() {
    if (currentPoll < polls.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
    }
  }

  void _previousPoll() {
    if (currentPoll > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final poll = polls[currentPoll];
    final isSubmitted = submittedPolls.contains(currentPoll);

    return Scaffold(
      backgroundColor: VotingPage.navyDark,
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [VotingPage.navyDark, VotingPage.navy, Color(0xFF021653)]),
              ),
            ),

            const Positioned.fill(child: CustomPaint(painter: VotingBackgroundPainter())),

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
                          _pollIndicator(),

                          SizedBox(height: 18.h),

                          Expanded(
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: polls.length,
                              onPageChanged: (index) {
                                setState(() {
                                  currentPoll = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                return _pollCard(poll: polls[index], pollIndex: index);
                              },
                            ),
                          ),

                          SizedBox(height: 14.h),

                          _bottomActions(isSubmitted: isSubmitted, poll: poll),

                          SizedBox(height: 20.h),
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
            "Live Voting",
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
          child: Icon(Icons.how_to_vote_rounded, color: VotingPage.gold, size: 23.sp),
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
              gradient: const LinearGradient(colors: [VotingPage.gold, Color(0xFFFF9F1C)]),
            ),
            child: Icon(Icons.bar_chart_rounded, color: Colors.white, size: 34.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Audience Interaction",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Swipe polls, choose answers, and submit your vote",
                  style: TextStyle(color: Colors.white.withOpacity(.72), fontSize: 12.sp, height: 1.35, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pollIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        polls.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: currentPoll == index ? 24.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(color: currentPoll == index ? VotingPage.royalBlue : const Color(0xFFD6DEEE), borderRadius: BorderRadius.circular(20.r)),
        ),
      ),
    );
  }

  Widget _pollCard({required PollModel poll, required int pollIndex}) {
    final selectedIndex = selectedAnswers[pollIndex];
    final isSubmitted = submittedPolls.contains(pollIndex);
    final totalVotes = poll.votes.fold<int>(0, (sum, vote) => sum + vote);

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(.055), blurRadius: 18.r, offset: Offset(0, 8.h))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _liveBadge(poll.session, isSubmitted),

            SizedBox(height: 18.h),

            Text(
              poll.question,
              style: TextStyle(color: VotingPage.textDark, fontSize: 21.sp, height: 1.25, fontWeight: FontWeight.w900),
            ),

            SizedBox(height: 10.h),

            Text(
              isSubmitted ? "$totalVotes total votes" : "Select one option below",
              style: TextStyle(color: const Color(0xFF8B96B1), fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 22.h),

            ...List.generate(poll.options.length, (optionIndex) {
              final isSelected = selectedIndex == optionIndex;
              final voteCount = poll.votes[optionIndex];
              final percent = totalVotes == 0 ? 0.0 : voteCount / totalVotes;

              return _voteOption(
                title: poll.options[optionIndex],
                selected: isSelected,
                submitted: isSubmitted,
                percent: percent,
                voteCount: voteCount,
                onTap: () {
                  if (isSubmitted) return;

                  setState(() {
                    selectedAnswers[pollIndex] = optionIndex;
                  });
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _liveBadge(String title, bool submitted) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 6.h),
          decoration: BoxDecoration(color: submitted ? VotingPage.gold.withOpacity(.18) : VotingPage.cyan.withOpacity(.14), borderRadius: BorderRadius.circular(30.r)),
          child: Row(
            children: [
              Container(
                width: 7.w,
                height: 7.w,
                decoration: BoxDecoration(color: submitted ? VotingPage.gold : VotingPage.cyan, shape: BoxShape.circle),
              ),
              SizedBox(width: 7.w),
              Text(
                submitted ? "VOTED" : "LIVE",
                style: TextStyle(color: submitted ? VotingPage.gold : VotingPage.royalBlue, fontSize: 10.sp, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            title,
            style: TextStyle(color: const Color(0xFF6D7895), fontSize: 12.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget _voteOption({required String title, required bool selected, required bool submitted, required double percent, required int voteCount, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: selected ? VotingPage.cyan.withOpacity(.10) : const Color(0xFFF4F7FB),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: selected ? VotingPage.royalBlue : const Color(0xFFE1E8F4), width: selected ? 1.5 : 1),
        ),
        child: Column(
          children: [
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? VotingPage.royalBlue : Colors.white,
                    border: Border.all(color: selected ? VotingPage.royalBlue : const Color(0xFFC8D3E6)),
                  ),
                  child: selected ? Icon(Icons.check_rounded, color: Colors.white, size: 16.sp) : null,
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: VotingPage.textDark, fontSize: 14.sp, fontWeight: selected ? FontWeight.w900 : FontWeight.w700),
                  ),
                ),

                if (submitted)
                  Text(
                    "${(percent * 100).round()}%",
                    style: TextStyle(color: VotingPage.royalBlue, fontSize: 13.sp, fontWeight: FontWeight.w900),
                  ),
              ],
            ),

            if (submitted) ...[
              SizedBox(height: 12.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: LinearProgressIndicator(value: percent, minHeight: 8.h, backgroundColor: const Color(0xFFE1E8F4), color: selected ? VotingPage.gold : VotingPage.cyan),
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "$voteCount votes",
                  style: TextStyle(color: const Color(0xFF8B96B1), fontSize: 11.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _bottomActions({required bool isSubmitted, required PollModel poll}) {
    return Row(
      children: [
        GestureDetector(
          onTap: _previousPoll,
          child: Container(
            width: 54.w,
            height: 54.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: const Color(0xFFE1E8F4)),
            ),
            child: Icon(Icons.arrow_back_rounded, color: currentPoll == 0 ? const Color(0xFFB8C2D6) : VotingPage.royalBlue, size: 23.sp),
          ),
        ),

        SizedBox(width: 12.w),

        Expanded(
          child: GestureDetector(
            onTap: isSubmitted ? _nextPoll : _submitVote,
            child: Container(
              height: 54.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                gradient: const LinearGradient(colors: [Color(0xFF20C7F7), Color(0xFF084BDB)]),
              ),
              child: Center(
                child: Text(
                  isSubmitted
                      ? currentPoll == polls.length - 1
                            ? "Completed"
                            : "Next Poll"
                      : "Submit Vote",
                  style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: 12.w),

        GestureDetector(
          onTap: _nextPoll,
          child: Container(
            width: 54.w,
            height: 54.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: const Color(0xFFE1E8F4)),
            ),
            child: Icon(Icons.arrow_forward_rounded, color: currentPoll == polls.length - 1 ? const Color(0xFFB8C2D6) : VotingPage.royalBlue, size: 23.sp),
          ),
        ),
      ],
    );
  }
}

class PollModel {
  final String question;
  final String session;
  final List<String> options;
  final List<int> votes;

  PollModel({required this.question, required this.session, required this.options, required this.votes});
}

class VotingBackgroundPainter extends CustomPainter {
  const VotingBackgroundPainter();

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
