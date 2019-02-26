import 'package:scoped_model/scoped_model.dart';

class CartScopedModel extends Model {
   int _counter = 0;

  int get counter => _counter;

    void increment() {
    // First, increment the counter
    _counter++;
    
    // Then notify all the listeners.
    notifyListeners();
  }

    void decrement() {
    // First, increment the counter
    _counter--;
    
    // Then notify all the listeners.
    notifyListeners();
  }
}

