import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

void main() {
  group('ThermometerWidget Tests', () {
    testWidgets(
        'Renders ThermometerWidget with Celsius and Fahrenheit defaults',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ThermometerWidget(
                celsius: 25,
                width: 220,
                height: 420,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ThermometerWidget), findsOneWidget);
      expect(find.byIcon(Icons.wb_sunny_rounded), findsOneWidget);
    });

    testWidgets('Supports custom fluid theme and minor labels toggle',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ThermometerWidget(
                celsius: -10,
                fluidTheme: ThermometerFluidTheme.cryoBlue,
                showMinorLabels: true,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ThermometerWidget), findsOneWidget);
    });

    testWidgets('Supports interaction drag on thermometer',
        (WidgetTester tester) async {
      double? updatedTemp;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ThermometerWidget(
                celsius: 20,
                interactive: true,
                onChanged: (val) {
                  updatedTemp = val;
                },
              ),
            ),
          ),
        ),
      );

      // Drag up/down on the widget
      final center = tester.getCenter(find.byType(ThermometerWidget));
      await tester.dragFrom(center, const Offset(0, -50));
      await tester.pumpAndSettle();

      expect(updatedTemp, isNotNull);
    });

    testWidgets('Supports hiding Fahrenheit or Celsius scales',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                Expanded(
                  child: ThermometerWidget(
                    celsius: 30,
                    showFahrenheit: false, // Only Celsius
                  ),
                ),
                Expanded(
                  child: ThermometerWidget(
                    celsius: 15,
                    showCelsius: false, // Only Fahrenheit
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ThermometerWidget), findsNWidgets(2));
    });

    testWidgets(
        'Adapts responsively to parent container constraints without fixed width/height',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 180,
              height: 380,
              child: ThermometerWidget(
                celsius: 28,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ThermometerWidget), findsOneWidget);
    });

    testWidgets('Supports ThermometerReadoutStyle options and ThermometerWheelReadout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: ThermometerWidget(
                    celsius: 24.5,
                    readoutStyle: ThermometerReadoutStyle.circularWheel,
                  ),
                ),
                ThermometerWheelReadout(
                  celsius: 24.5,
                  unit: '°C',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ThermometerWidget), findsOneWidget);
      expect(find.byType(ThermometerWheelReadout), findsOneWidget);
      expect(find.text('24.5°C'), findsOneWidget);
      expect(find.text('26°'), findsOneWidget); // +1 faded tick
      expect(find.text('24°'), findsOneWidget); // -1 faded tick
    });
  });
}
