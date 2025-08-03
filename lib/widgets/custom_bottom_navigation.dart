import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/views/home/home_page.dart';
import 'package:indoor_object_detection/views/settings/settings_page.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int currentIndex = 0;

  final List _screen = [const HomePage(), const SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: lightBoxShadow,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25.0),
            topLeft: Radius.circular(25.0),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 80.0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0),
                topLeft: Radius.circular(25.0),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedFontSize: fontSizeS,
                unselectedFontSize: fontSizeS,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey.shade300,
                selectedLabelStyle: TextStyle(
                  fontFamily: GoogleFonts.kanit().fontFamily,
                  color: Colors.black,
                ),
                unselectedLabelStyle: TextStyle(
                  fontFamily: GoogleFonts.kanit().fontFamily,
                  color: Colors.grey.shade300,
                ),
                currentIndex: currentIndex,
                onTap: (index) {
                  currentIndex = index;
                  setState(() {});
                },
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      currentIndex == 0
                          ? 'assets/icons/home_filled_icon.svg'
                          : 'assets/icons/home_icon.svg',
                      height: 25.0,
                      width: 25.0,
                      fit: BoxFit.fitHeight,
                      color:
                          currentIndex == 0 ? Colors.black : Colors.grey.shade300,
                    ),
                    label: 'Home Page',
                    tooltip: '',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      currentIndex == 1
                          ? 'assets/icons/settings_filled_icon.svg'
                          : 'assets/icons/settings_icon.svg',
                      height: 30.0,
                      width: 30.0,
                      fit: BoxFit.fitHeight,
                      color:
                          currentIndex == 1 ? Colors.black : Colors.grey.shade300,
                    ),
                    label: 'Settings',
                    tooltip: '',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
