import 'package:cv_flutter_precious/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('connexion puis navigation entre les rubriques', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CvApp());

    expect(find.text('Bienvenue'), findsOneWidget);
    expect(find.text('Se connecter'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(
      tester
          .widget<TextField>(
            find.descendant(
              of: find.byType(TextFormField).last,
              matching: find.byType(TextField),
            ),
          )
          .obscureText,
      isTrue,
    );

    await tester.enterText(find.byType(TextFormField).first, 'precious');
    await tester.enterText(find.byType(TextFormField).last, '1234');
    await tester.tap(find.text('Se connecter'));
    await tester.pumpAndSettle();

    expect(find.text('Mon CV'), findsWidgets);
    expect(find.text('Precious Muhindo'), findsOneWidget);

    await tester.tap(find.text('Ma famille').last);
    await tester.pumpAndSettle();
    expect(find.text('Les personnes qui comptent'), findsOneWidget);

    await tester.tap(find.text('Contact').last);
    await tester.pumpAndSettle();
    expect(find.text('Restons en contact'), findsOneWidget);
    expect(find.text('precious.muhindo@example.com'), findsOneWidget);
  });
}
