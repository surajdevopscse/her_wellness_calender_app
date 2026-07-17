import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_mobile_nav.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('More tab selects the settings page index', (tester) async {
    var selectedIndex = -1;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Align(
            alignment: Alignment.bottomCenter,
            child: WellnessMobileNav(
              selectedPageIndex: 0,
              onSelected: (index) => selectedIndex = index,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('More'));

    expect(selectedIndex, 11);
  });
}
