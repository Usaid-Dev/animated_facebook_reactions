import 'package:animated_facebook_reactions/constants.dart';
import 'package:animated_facebook_reactions/emoji_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const ReactionScreen(),
    );
  }
}

class ReactionScreen extends StatefulWidget {
  const ReactionScreen({super.key});

  @override
  State<ReactionScreen> createState() => _ReactionScreenState();
}

class _ReactionScreenState extends State<ReactionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int curretHoveredEmoji = 100;
  double currentHoverPosition = 0;

  final List<Emoji> emojis = [
    Emoji(path: 'assets/like.json', scale: 1.7),
    Emoji(path: 'assets/love.json', scale: 1.5),
    Emoji(path: 'assets/care.json', scale: 0.7),
    Emoji(path: 'assets/laughing.json', scale: 0.8),
    Emoji(path: 'assets/wow.json', scale: 0.85),
    Emoji(path: 'assets/crying.json', scale: 0.85),
    Emoji(path: 'assets/angry.json', scale: 0.85),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: roundGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < emojis.length; i++)
                  Transform.scale(
                    scale:
                        emojis[i].scale + (curretHoveredEmoji == i ? 0.7 : 0),
                    child: Lottie.asset(
                      emojis[i].path,
                      controller: curretHoveredEmoji == i ? _controller : null,
                      height: 45,
                      animate: false,
                      fit: BoxFit.cover,
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onLongPress: () => _controller.repeat(),
            onLongPressEnd: (_) {
              setState(() {
                curretHoveredEmoji = 100;
              });
              _controller.stop();
              _controller.reset();
            },
            onLongPressDown: (details) {
              setState(() {
                curretHoveredEmoji = 2;
              });
              currentHoverPosition = details.localPosition.dx;
            },
            onLongPressMoveUpdate: (details) {
              final dragDifference =
                  details.localPosition.dx - currentHoverPosition;
              if (dragDifference.abs() > 40) {
                dragDifference > 0 ? nextEmoji() : previousEmoji();
                currentHoverPosition = details.localPosition.dx;
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              decoration: roundGrey,
              child: const Text(
                "Like",
                style: likeButtonTextStyle,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text("LONG PRESS THE LIKE BUTTON")
        ],
      ),
    );
  }

  void nextEmoji() {
    if (curretHoveredEmoji < emojis.length - 1) {
      setState(() {
        curretHoveredEmoji++;
      });
    }
  }

  void previousEmoji() {
    if (curretHoveredEmoji > 0) {
      setState(() {
        curretHoveredEmoji--;
      });
    }
  }
}
