import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AskQAPage extends StatefulWidget {
  const AskQAPage({super.key});

  static const navyDark = Color(0xFF06163F);
  static const navy = Color(0xFF082B7A);
  static const royalBlue = Color(0xFF084BDB);
  static const cyan = Color(0xFF20C7F7);
  static const gold = Color(0xFFFFC857);
  static const textDark = Color(0xFF102A5E);

  @override
  State<AskQAPage> createState() => _AskQAPageState();
}

class _AskQAPageState extends State<AskQAPage> {
  final TextEditingController _questionController = TextEditingController();

  int selectedCategory = 0;
  int selectedFilter = 0;

  final List<String> categories = ["General", "Nutrition", "Research", "Clinical"];

  final List<String> filters = ["Popular", "Recent", "Answered"];

  final List<QuestionModel> questions = [
    QuestionModel(question: "How can pediatric nutrition plans be personalized for children with different growth patterns?", author: "Dr. Ahmed", category: "Nutrition", votes: 24, answered: true),
    QuestionModel(question: "What are the latest clinical guidelines for early-life nutritional intervention?", author: "Dr. Sara", category: "Clinical", votes: 18, answered: false),
    QuestionModel(question: "Can digital tools improve patient adherence in long-term nutrition programs?", author: "Dr. Khalid", category: "Research", votes: 13, answered: true),
  ];

  void _submitQuestion() {
    final text = _questionController.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please type your question")));
      return;
    }

    setState(() {
      questions.insert(0, QuestionModel(question: text, author: "You", category: categories[selectedCategory], votes: 0, answered: false));

      _questionController.clear();
      selectedFilter = 1;
    });

    FocusManager.instance.primaryFocus?.unfocus();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Question submitted successfully")));
  }

  void _upvoteQuestion(int index) {
    setState(() {
      questions[index].votes++;
      questions[index].liked = true;
    });
  }

  List<QuestionModel> get filteredQuestions {
    final list = List<QuestionModel>.from(questions);

    if (selectedFilter == 0) {
      list.sort((a, b) => b.votes.compareTo(a.votes));
    } else if (selectedFilter == 2) {
      return list.where((e) => e.answered).toList();
    }

    return list;
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayQuestions = filteredQuestions;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AskQAPage.navyDark,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AskQAPage.navyDark, AskQAPage.navy, Color(0xFF021653)]),
                ),
              ),

              const Positioned.fill(child: CustomPaint(painter: AskQABackgroundPainter())),

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
                            _askCard(),

                            SizedBox(height: 18.h),

                            _filterChips(),

                            SizedBox(height: 16.h),

                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.only(bottom: 22.h),
                                itemCount: displayQuestions.length,
                                itemBuilder: (context, index) {
                                  final question = displayQuestions[index];

                                  return _questionCard(
                                    question: question,
                                    onVote: () {
                                      final originalIndex = questions.indexOf(question);
                                      _upvoteQuestion(originalIndex);
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
            "Ask Q&A",
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
          child: Icon(Icons.question_answer_rounded, color: AskQAPage.gold, size: 23.sp),
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
              gradient: const LinearGradient(colors: [AskQAPage.cyan, AskQAPage.royalBlue]),
            ),
            child: Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 34.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ask the Experts",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Submit your questions and vote for top discussions",
                  style: TextStyle(color: Colors.white.withOpacity(.72), fontSize: 12.sp, height: 1.35, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _askCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.055), blurRadius: 16.r, offset: Offset(0, 8.h))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Write your question",
            style: TextStyle(color: AskQAPage.textDark, fontSize: 17.sp, fontWeight: FontWeight.w900),
          ),

          SizedBox(height: 12.h),

          TextField(
            controller: _questionController,
            maxLines: 3,
            minLines: 2,
            textInputAction: TextInputAction.newline,
            style: TextStyle(color: AskQAPage.textDark, fontSize: 13.sp, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: "Type your question for the speaker...",
              hintStyle: TextStyle(color: const Color(0xFF8B96B1), fontSize: 13.sp, fontWeight: FontWeight.w500),
              filled: true,
              fillColor: const Color(0xFFF4F7FB),
              contentPadding: EdgeInsets.all(14.w),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.r),
                borderSide: const BorderSide(color: Color(0xFFE1E8F4)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.r),
                borderSide: const BorderSide(color: AskQAPage.cyan, width: 1.4),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          SizedBox(
            height: 36.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final selected = selectedCategory == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.only(right: 9.w),
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    decoration: BoxDecoration(
                      color: selected ? AskQAPage.royalBlue : const Color(0xFFF4F7FB),
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: selected ? AskQAPage.royalBlue : const Color(0xFFE1E8F4)),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(color: selected ? Colors.white : const Color(0xFF6D7895), fontSize: 12.sp, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 14.h),

          GestureDetector(
            onTap: _submitQuestion,
            child: Container(
              height: 52.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                gradient: const LinearGradient(colors: [AskQAPage.cyan, AskQAPage.royalBlue]),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    "Submit Question",
                    style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChips() {
    return Row(
      children: List.generate(filters.length, (index) {
        final selected = selectedFilter == index;

        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 42.h,
              margin: EdgeInsets.only(right: index == filters.length - 1 ? 0 : 10.w),
              decoration: BoxDecoration(
                color: selected ? AskQAPage.gold : Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: selected ? AskQAPage.gold : const Color(0xFFE1E8F4)),
              ),
              child: Center(
                child: Text(
                  filters[index],
                  style: TextStyle(color: selected ? AskQAPage.textDark : const Color(0xFF6D7895), fontSize: 12.sp, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _questionCard({required QuestionModel question, required VoidCallback onVote}) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: question.answered ? AskQAPage.gold.withOpacity(.55) : const Color(0xFFE1E8F4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.045), blurRadius: 14.r, offset: Offset(0, 7.h))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: question.liked ? null : onVote,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 46.w,
              padding: EdgeInsets.symmetric(vertical: 9.h),
              decoration: BoxDecoration(
                color: question.liked ? AskQAPage.cyan.withOpacity(.16) : const Color(0xFFF4F7FB),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: question.liked ? AskQAPage.cyan : const Color(0xFFE1E8F4)),
              ),
              child: Column(
                children: [
                  Icon(Icons.keyboard_arrow_up_rounded, color: question.liked ? AskQAPage.royalBlue : const Color(0xFF8B96B1), size: 24.sp),
                  Text(
                    question.votes.toString(),
                    style: TextStyle(color: question.liked ? AskQAPage.royalBlue : AskQAPage.textDark, fontSize: 13.sp, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _smallBadge(question.category),
                    SizedBox(width: 8.w),
                    if (question.answered) _smallBadge("Answered", color: AskQAPage.gold, textColor: AskQAPage.textDark),
                  ],
                ),

                SizedBox(height: 10.h),

                Text(
                  question.question,
                  style: TextStyle(color: AskQAPage.textDark, fontSize: 14.sp, height: 1.35, fontWeight: FontWeight.w800),
                ),

                SizedBox(height: 12.h),

                Row(
                  children: [
                    CircleAvatar(
                      radius: 12.r,
                      backgroundColor: AskQAPage.cyan.withOpacity(.15),
                      child: Text(
                        question.author.substring(0, 1),
                        style: TextStyle(color: AskQAPage.royalBlue, fontSize: 10.sp, fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(width: 7.w),
                    Text(
                      question.author,
                      style: TextStyle(color: const Color(0xFF8B96B1), fontSize: 11.sp, fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    Icon(Icons.reply_rounded, color: const Color(0xFF8B96B1), size: 17.sp),
                    SizedBox(width: 4.w),
                    Text(
                      "Reply",
                      style: TextStyle(color: const Color(0xFF8B96B1), fontSize: 11.sp, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallBadge(String text, {Color color = const Color(0xFFEAF3FF), Color textColor = AskQAPage.royalBlue}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20.r)),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 9.sp, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class QuestionModel {
  final String question;
  final String author;
  final String category;
  int votes;
  bool answered;
  bool liked;

  QuestionModel({required this.question, required this.author, required this.category, required this.votes, required this.answered, this.liked = false});
}

class AskQABackgroundPainter extends CustomPainter {
  const AskQABackgroundPainter();

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
