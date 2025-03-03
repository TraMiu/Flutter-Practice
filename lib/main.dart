import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          displayLarge: GoogleFonts.dosis(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.dosis(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
          // Merriweather pairs well with Dosis for body text - creates a nice contrast
          bodyMedium: GoogleFonts.schoolbell(
            fontSize: 16,
          ),
          // Keep Pacifico for accents/display text
          displaySmall: GoogleFonts.pacifico(),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

// Replace the stateless MyHomePage with a stateful one
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Style states for each element
  bool _isText1Bold = false;
  bool _isText2Italic = false;
  bool _isText3Large = false;
  bool _isBoxColorful = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First row with 3 texts and 1 decorative box
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Text 1
                Text(
                  'Text One',
                  style: TextStyle(
                    fontWeight: _isText1Bold ? FontWeight.bold : FontWeight.normal,
                    fontSize: 18,
                  ),
                ),
                // Text 2
                Text(
                  'Text Two',
                  style: TextStyle(
                    fontStyle: _isText2Italic ? FontStyle.italic : FontStyle.normal,
                    fontSize: 18,
                  ),
                ),
                // Text 3
                Text(
                  'Text Three',
                  style: TextStyle(
                    fontSize: _isText3Large ? 24 : 18,
                  ),
                ),
                // Decorative box
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _isBoxColorful ? Colors.amber : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: _isBoxColorful
                        ? [BoxShadow(color: Colors.amberAccent, blurRadius: 5, spreadRadius: 1)]
                        : null,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 40), // Spacer
            
            // Second row with 4 buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Button 1 for Text 1
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isText1Bold = !_isText1Bold;
                    });
                  },
                  child: Text('Toggle Bold'),
                ),
                // Button 2 for Text 2
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isText2Italic = !_isText2Italic;
                    });
                  },
                  child: Text('Toggle Italic'),
                ),
                // Button 3 for Text 3
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isText3Large = !_isText3Large;
                    });
                  },
                  child: Text('Toggle Size'),
                ),
                // Button 4 for Box
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isBoxColorful = !_isBoxColorful;
                    });
                  },
                  child: Text('Toggle Box'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
