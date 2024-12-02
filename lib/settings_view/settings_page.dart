import 'package:flutter/material.dart';
import 'package:tt_36/main_view/action_history_page.dart';
import 'package:tt_36/styles/app_theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.surface,
                      border: Border.all(
                        color: const Color.fromRGBO(45, 45, 51, 1),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppTheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            // График настроения

            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Rectangle 525.png'),
                      fit: BoxFit.cover)),
            ),

            const SizedBox(
              height: 20,
            ),
            Text(
              "Vote for our app",
              style: AppTheme.bodyLarge
                  .copyWith(color: const Color.fromARGB(78, 252, 248, 239)),
            ),
            const SizedBox(
              height: 10,
            ),
            // Текст настроения и кнопка добавления
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TO MAKE US\nBETTER',
                  style: AppTheme.displayLarge
                      .copyWith(color: AppTheme.onBackground),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.surface,
                      border: Border.all(
                        color: const Color.fromRGBO(45, 45, 51, 1),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: AppTheme.onSurface,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Terms of use',
                  style: AppTheme.bodyMedium
                      .copyWith(color: AppTheme.onBackground),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color.fromARGB(255, 92, 92, 92),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),

            Divider(
              color: const Color.fromARGB(255, 63, 63, 63),
              height: 1,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Privacy Policy',
                  style: AppTheme.bodyMedium
                      .copyWith(color: AppTheme.onBackground),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color.fromARGB(255, 92, 92, 92),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),

            Divider(
              color: const Color.fromARGB(255, 63, 63, 63),
              height: 1,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Support page',
                  style: AppTheme.bodyMedium
                      .copyWith(color: AppTheme.onBackground),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color.fromARGB(255, 92, 92, 92),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),

            Divider(
              color: const Color.fromARGB(255, 63, 63, 63),
              height: 1,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Version',
                  style: AppTheme.bodyMedium
                      .copyWith(color: AppTheme.onBackground),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color.fromARGB(255, 92, 92, 92),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),

            Divider(
              color: const Color.fromARGB(255, 63, 63, 63),
              height: 1,
            )
          ],
        ),
      )),
    );
  }
}
