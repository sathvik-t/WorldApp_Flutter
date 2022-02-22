import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data: ModalRoute.of(context)?.settings.arguments as Map;
    //The as Map helps in keeping the type Object into the Map type
    //? is used for null safety

    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700] as Color;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
              child: Column(
        children: <Widget>[
              TextButton.icon(
                onPressed: () async{
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'time' : result['time'],
                      'location' : result['location'],
                      'isDaytime': result['isDayTime'],
                      'flag': result['flag']
                    };
                  });
                },
                icon: Icon(
                    Icons.edit_location,
                  size: 30.0,
                  color: Colors.grey[300]
                ),
                label: Text(
                    'Edit Location',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 15.0
                  )
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      letterSpacing: 2.0
                    ),
                  )
                ],
              ),
            const SizedBox(height: 20.0),
            Text(
              data['time'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 66.0
              )
            )
        ],
      ),
            ),
          ))
    );
  }
}
