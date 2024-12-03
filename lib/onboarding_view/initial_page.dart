import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fraze_pocket/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:fraze_pocket/onboarding_view/onboarding_page.dart';
import 'package:fraze_pocket/service/mixins/network_mixin.dart';
import 'package:fraze_pocket/settings_view/more_info_page.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:is_first_run/is_first_run.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> with NetworkMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
    super.initState();
  }

  Future<void> _init() async {
    await checkConnection(
      onError: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const InitialScreen()),
      ),
    );

    final isFirstRun = await IsFirstRun.isFirstRun();

    if (isFirstRun) {
      InAppReview.instance.requestReview();
    }

    if (!canNavigate) {
      if (isFirstRun) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => const OnboardingScreen(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => const CustomNavigationBar(),
          ),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => const MoreInfoPage(),
          ),
        );
    }
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
