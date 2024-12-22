// Copyright 2024 EATING-OUT Ltd.

import 'package:flutter/material.dart' hide Theme;
import 'package:gartic/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '你畫我猜',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Theme _theme;
  late int _wordIndex;

  void _setTheme(Theme theme) {
    setState(() {
      _theme = theme;
      _theme.words.shuffle();
      _wordIndex = -1;
    });
  }

  @override
  void initState() {
    super.initState();
    _setTheme(themes.first);
  }

  Widget _drawer() {
    return Drawer(
      child: ListView.builder(
        itemCount: themes.length,
        itemBuilder: (context, index) {
          final theme = themes[index];

          return ListTile(
            title: Text(theme.name),
            onTap: () {
              _setTheme(theme);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  Widget _themeText() {
    return Text(
      '主題：${_theme.name}',
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w100,
        color: Colors.grey,
      ),
    );
  }

  Widget _wordText() {
    return Text(
      _wordIndex >= 0 && _wordIndex < _theme.words.length ? _theme.words[_wordIndex] : '',
      style: const TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _button() {
    final String text;
    final VoidCallback? onPressed;
    if (_wordIndex == -1) {
      text = '出題';
      onPressed = () {
        setState(() {
          _wordIndex = 0;
        });
      };
    } else if (_wordIndex < _theme.words.length) {
      text = '下一題';
      onPressed = () {
        setState(() {
          _wordIndex++;
        });
      };
    } else {
      text = '沒題目了';
      onPressed = null;
    }

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: _drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _themeText(),
            Flexible(child: _wordText()),
            _button(),
          ],
        ),
      ),
    );
  }
}
