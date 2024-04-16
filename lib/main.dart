import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hesap Makinesi',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.black),
        ),
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _result = '0';
  bool _showResult = true;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == 'C') {
        _clearInput();
      } else if (buttonText == '⌫') {
        _backspace();
      } else if (buttonText == '.') {
        _fixDecimal();
      } else if (buttonText == 'PS') {
        _onPSButtonPressed();
      } else if (buttonText == '(' || buttonText == ')') {
        _handleParenthesis(buttonText);
      } else if (_isOperator(buttonText)) {
        _handleOperator(buttonText);
      } else {
        _handleInput(buttonText);
      }
    });
  }

  void _calculateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_input.replaceAll('×', '*').replaceAll('÷', '/'));
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        _result = result.toString();
        _input = _result;
        _showResult = true;
      });
    } catch (e) {
      setState(() {
        _result = 'lanet olsun çöktüm la (HATA)';
        _showResult = true;
      });
    }
  }

  void _clearInput() {
    setState(() {
      _input = '';
      _result = '0';
      _showResult = true;
    });
  }

  void _backspace() {
    setState(() {
      if (_input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
        _result = _input.isEmpty ? '0' : _input;
        _showResult = false;
      } else {
        _result = '0';
        _showResult = true;
      }
    });
  }

  void _fixDecimal() {
    setState(() {
      if (!_input.contains('.')) {
        _input += '.';
        _result = _input;
        _showResult = false;
      }
    });
  }

  void _handleInput(String buttonText) {
    if (_showResult || _result == 'Hata') {
      _input = buttonText;
      _result = _input;
      _showResult = false;
    } else {
      _input += buttonText;
      _result = _input;
    }
  }

  void _handleOperator(String operator) {
    setState(() {
      if (_showResult || _input.isEmpty) {
        _input += '0$operator';
        _result = '0$operator';
        _showResult = false;
      } else {
        _input += operator;
        _result = _input;
      }
    });
  }

  void _handleParenthesis(String parenthesis) {
    setState(() {
      _input += parenthesis;
      _showResult = false;
    });
  }

  bool _isOperator(String buttonText) {
    return buttonText == '+' || buttonText == '-' || buttonText == '×' || buttonText == '÷';
  }

  void _onPSButtonPressed() {
    if (_input.isNotEmpty && double.tryParse(_input) != null) {
      int plateCode = int.parse(_input);
      if (plateCode >= 0 && plateCode <= 81) {
        _checkPlateCode(plateCode);
      } else {
        _showError('Geçersiz Plaka Kodu');
      }
    } else {
      _showError('Geçersiz Plaka Kodu');
    }
  }

  void _checkPlateCode(int plateCode) {
    String cityName = _getCityName(plateCode);
    if (cityName != 'Geçersiz Plaka Kodu') {
      setState(() {
        _result = cityName;
        _showResult = true;
      });
    } else {
      _showError('Plaka Verileriyle Uyuşmuyor');
    }
  }

  void _showError(String errorText) {
    setState(() {
      _result = errorText;
      _showResult = true;
    });
  }

  String _getCityName(int plateCode) {
    switch (plateCode) {
      case 1:
        return 'Adana';
      case 2:
        return 'Adıyaman';
      case 3:
        return 'Afyon';
      case 4:
        return 'Ağrı';
      case 5:
        return 'Amasya';
      case 6:
        return 'Ankara';
      case 7:
        return 'Antalya';
      case 8:
        return 'Artvin';
      case 9:
        return 'Aydın';
      case 10:
        return 'Balıkesir';
      case 11:
        return 'Bilecik';
      case 12:
        return 'Bingöl';
      case 13:
        return 'Bitlis';
      case 14:
        return 'Bolu';
      case 15:
        return 'Burdur';
      case 16:
        return 'Bursa';
      case 17:
        return 'Çanakkale';
      case 18:
        return 'Çankırı';
      case 19:
        return 'Çorum';
      case 20:
        return 'Denizli';
      case 21:
        return 'Diyarbakır';
      case 22:
        return 'Edirne';
      case 23:
        return 'Elazığ';
      case 24:
        return 'Erzincan';
      case 25:
        return 'Erzurum';
      case 26:
        return 'Eskişehir';
      case 27:
        return 'Gaziantep';
      case 28:
        return 'Giresun';
      case 29:
        return 'Gümüşhane';
      case 30:
        return 'Hakkari';
      case 31:
        return 'Hatay';
      case 32:
        return 'Isparta';
      case 33:
        return 'Mersin';
      case 34:
        return 'İstanbul';
      case 35:
        return 'İzmir';
      case 36:
        return 'Kars';
      case 37:
        return 'Kastamonu';
      case 38:
        return 'Kayseri';
      case 39:
        return 'Kırklareli';
      case 40:
        return 'Kırşehir';
      case 41:
        return 'Kırıkkale';
      case 42:
        return 'Konya';
      case 43:
        return 'Kütahya';
      case 44:
        return 'Malatya';
      case 45:
        return 'Manisa';
      case 46:
        return 'Kahramanmaraş';
      case 47:
        return 'Mardin';
      case 48:
        return 'Muğla';
      case 49:
        return 'Muş';
      case 50:
        return 'Nevşehir';
      case 51:
        return 'Niğde';
      case 52:
        return 'Ordu';
      case 53:
        return 'Rize';
      case 54:
        return 'Sakarya';
      case 55:
        return 'Samsun';
      case 56:
        return 'Siirt';
      case 57:
        return 'Sinop';
      case 58:
        return 'Sivas';
      case 59:
        return 'Tekirdağ';
      case 60:
        return 'Tokat';
      case 61:
        return 'Trabzon';
      case 62:
        return 'Tunceli';
      case 63:
        return 'Şanlıurfa';
      case 64:
        return 'Uşak';
      case 65:
        return 'Van';
      case 66:
        return 'Yozgat';
      case 67:
        return 'Zonguldak';
      case 68:
        return 'Aksaray';
      case 69:
        return 'Bayburt';
      case 70:
        return 'Karaman';
      case 71:
        return 'Kırıkkale';
      case 72:
        return 'Batman';
      case 73:
        return 'Şırnak';
      case 74:
        return 'Bartın';
      case 75:
        return 'Ardahan';
      case 76:
        return 'Iğdır';
      case 77:
        return 'Yalova';
      case 78:
        return 'Karabük';
      case 79:
        return 'Kilis';
      case 80:
        return 'Osmaniye';
      case 81:
        return 'Düzce';
      default:
        return 'Geçersiz Plaka Kodu';
    }
  }

  Widget _buildButton(String buttonText) {
    return TextButton(
      onPressed: () {
        _onButtonPressed(buttonText);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 20.0 * 0.7), // %30 azaltıldı
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hesap Makinesi'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  _result,
                  style: TextStyle(fontSize: 24.0 * 0.7, color: Colors.black), // %30 azaltıldı
                ),
              ),
            ),
          ),
          Divider(height: 1, color: Colors.black),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              final buttonText = _buttonTexts[index];
              return _buildButton(buttonText);
            },
            itemCount: _buttonTexts.length,
          ),
          SizedBox(height: 16.0),
          Text(
            'TÜRKİYENİN ŞEHRİ OLAN SAKARYA’DA ÜRETİLDİ',
            style: TextStyle(fontSize: 18.0 * 0.7, color: Colors.red), 
          ),
          SizedBox(height: 8.0),
          Text(
            'Tüm hakları EBEDİYEN saklıdır',
            style: TextStyle(fontSize: 10.0 * 0.7, color: Color.fromARGB(255, 172, 172, 172)), 
          ),
          SizedBox(height: 8.0),
          Text(
            'YCŞ HOLDİNG’E AİTTİR!',
            style: TextStyle(fontSize: 8.0 * 0.7, color: Colors.black), 
          ),
        ],
      ),
    );
  }

  final List<String> _buttonTexts = [
    '7', '8', '9', '÷',
    '4', '5', '6', '×',
    '1', '2', '3', '-',
    '0', 'C', '=', '+',
    '⌫', '.', 'PS', '(', ')',
  ];
}
