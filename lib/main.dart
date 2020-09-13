import 'package:flutter/material.dart';
import 'configFile.dart' as cf;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ripple Animation',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    if(_controller != null){
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cf.Size.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Ripple Animation"),
      ),
      body: Container(
        height: cf.Size.screenHeight,
        width: cf.Size.screenWidth,
        child: _buildBody()
      )
    );
  }

  Widget _buildBody() {
    cf.Size.init(context);
    return AnimatedBuilder(
      animation: CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildContainer(150 * _controller.value),
            _buildContainer(200 * _controller.value),
            _buildContainer(250 * _controller.value),
            _buildContainer(300 * _controller.value),
            _buildContainer(350 * _controller.value),
            Align(
                child: CircleAvatar(
                  child: Text(
                    "RG",
                    style: TextStyle(fontSize: 30),
                  ),
                  backgroundColor: Colors.deepOrange,
                  radius: 40,
                )
            ),
          ],
        );
      },
    );
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.amber.withOpacity(1 - _controller.value),
      ),
    );
  }
}
