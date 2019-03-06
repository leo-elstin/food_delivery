import 'package:scoped_model/scoped_model.dart';
import 'package:food_delivery/model/food_model.dart';

class CartScopedModel extends Model {
  int _counter = 1;
  bool _isLoginEnabled =false;

  List<Food> _cartList = [];

  List<Food> get cartItems => _cartList;

  int get counter => _counter;

  bool get loginEnabled => _isLoginEnabled;

  void setLogin({bool enable}) {
    _isLoginEnabled = enable;
    notifyListeners();
  }

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    if (_counter < 2) return;
    _counter--;
    notifyListeners();
  }

  void addToCart(Food food) {
    _counter = 1;
    _cartList.add(food);
    notifyListeners();
  }
}
