import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:plus_movies/main.dart' as app;
import 'package:plus_movies/modules/movies/presentation/widgets/molecules/molecules.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("end to end test", () {
    testWidgets("Should show movie details when selecting a movie",
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text("Ação"), findsWidgets);

      final Finder moviePoster = find.byType(MoviePosterMolecule);

      await tester.tap(moviePoster.first);

      await tester.pumpAndSettle();

      expect(find.text("Título Original: "), findsOneWidget);
    });
  });
}
