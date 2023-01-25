import 'package:flutter/foundation.dart';

class CounterProvider extends ChangeNotifier {
  
  int _counter = 0;
  int get getCounter => _counter;

  counterUp(){
    _counter++;
    notifyListeners();
  }

  counterDown(){
    _counter--;
    notifyListeners();
  }

}