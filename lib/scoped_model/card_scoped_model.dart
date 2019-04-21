import 'package:scoped_model/scoped_model.dart';
import 'package:food_delivery/model/food_model.dart';

class CartScopedModel extends Model {
  int _counter = 1;
  bool _isLoginEnabled = false;

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

  String getCartDetails() {
     var total = 0;
      _cartList.forEach((item) {
        print(item.price.runtimeType);
        print(item.price);
        total += item.price;
      });
      return  '${_cartList.length} items\nRs.$total';
  }

  void updateItemCount(int index, bool increase) {
    if (increase)
      _cartList[index].count += 1;
    else
      _cartList[index].count -= 1;

    if (_cartList[index].count == 0) {
      _cartList.removeAt(index);
    }
    notifyListeners();
  }
}
