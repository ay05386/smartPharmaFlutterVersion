
import 'dart:io';

void main() {
  List productNames = ['Sugar', 'Rice', 'Meat', 'Fish'];
  List productPrices = [10, 30, 200, 150];
  List cartProducts = [];
  List cartQuantities = [];
  bool continueShopping = true;
  while (continueShopping) {
    print('Product Menu:');
    for (int i = 0; i < productNames.length; i++) {
      print('${i + 1}. ${productNames[i]}: ${productPrices[i]}');
    }
    print('Enter the number of the product you want to buy:');
    int productIndex = int.parse(stdin.readLineSync()!) - 1;

    if (productIndex >= 0 && productIndex < productNames.length) {
      print('Enter the quantity:');
      int quantity = int.parse(stdin.readLineSync()!);
      cartProducts.add(productNames[productIndex]);
      cartQuantities.add(quantity);

      print('Do you want to buy another product?');
      String? response = stdin.readLineSync();

      if (response == null || response.toLowerCase() != 'yes') {
        continueShopping = false;
      }
    } else {
      print('Invalid product number. Please try again.');
    }
  }

  print('Receipt:');
  int totalPrice = 0;
  for (int i = 0; i < cartProducts.length; i++) {
    String product = cartProducts[i];
    int quantity = cartQuantities[i];
    int price = productPrices[productNames.indexOf(product)];
    int total = price * quantity;
    totalPrice += total;
    print('$product x $quantity = $total');
  }
  print('Total Price: $totalPrice');
}
