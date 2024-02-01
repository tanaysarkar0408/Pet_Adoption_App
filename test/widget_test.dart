import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_app_bloc/home_page.dart';
import 'package:pet_app_bloc/Bloc/pet_bloc.dart';

void main() {
  testWidgets('HomePage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => PetBloc(),
          child: HomePage(),
        ),
      ),
    );

    // Verify that we have a list of pets.
    expect(find.byType(ListTile), findsWidgets);

    // Tap on the first pet in the list.
    await tester.tap(find.byType(ListTile).first);
    await tester.pump();

    // Verify that the DetailsPage is opened.
    expect(find.text('Pet Details'), findsOneWidget);
    expect(find.text('Adopt Me'), findsOneWidget);
  });
}
