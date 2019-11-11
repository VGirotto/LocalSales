import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class AboutAppTab extends StatelessWidget {

  final String title;

  const AboutAppTab({
    Key key,
    @required this.title,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
              child: Text(title),
            )
        ),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main(){
  testWidgets('Teste de widget', (WidgetTester tester) async{
    await tester.pumpWidget(AboutAppTab(title: 'Página'));

    final titleFinder = find.text('Página');

    expect(titleFinder, findsOneWidget);
  });
}