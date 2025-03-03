import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showRain = false;
  bool _showSun = false;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // First column with rain image and umbrella button
                Column(
                  children: [
                    // Rain image with fade-in effect
                    AnimatedOpacity(
                      opacity: _showRain ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeIn,
                      child: Container(
                        height: 150,
                        width: 150,
                        child: _showRain ? Image.asset(
                          'images/rain.jpg',
                          fit: BoxFit.cover,
                        ) : SizedBox(height: 150, width: 150),
                      ),
                    ),
                    SizedBox(height: 16), // Space between image and button
                    // Umbrella IconButton
                    IconButton(
                      icon: Icon(Icons.umbrella, size: 30),
                      onPressed: () {
                        setState(() {
                          _showRain = !_showRain;
                         
                        });
                      },
                    ),
                  ],
                ),
                
                // Second column with sun image and eco button
                Column(
                  children: [
                    // Sun image with fade-in effect
                    AnimatedOpacity(
                      opacity: _showSun ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeIn,
                      child: Container(
                        height: 150,
                        width: 150,
                        child: _showSun ? Image.network(
                          'https://th.bing.com/th/id/OIP.Qh_6jnGZN78aiu-lgvktswHaD_?w=302&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7',
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ) : SizedBox(height: 150, width: 150),
                      ),
                    ),
                    SizedBox(height: 16), // Space between image and button
                    // Eco IconButton
                    IconButton(
                      icon: Icon(Icons.eco, size: 30),
                      onPressed: () {
                        setState(() {
                          _showSun = !_showSun;
                          
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
