import 'package:flutter_test/flutter_test.dart';
import 'package:bucket_game/main.dart';

void main() {
  testWidgets('App runs without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const BucketCollectGame());
    // Just verifying the app builds is a good first test
  });
}