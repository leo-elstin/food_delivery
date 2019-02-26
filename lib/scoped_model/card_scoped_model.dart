import 'package:scoped_model/scoped_model.dart';

class CartScopedModel extends Model {
   int _counter = 1;

  int get counter => _counter;

    void increment() {
    _counter++;
    notifyListeners();
  }

    void decrement() {
     if(_counter < 2) return;
    _counter--;
    notifyListeners();
  }
}

