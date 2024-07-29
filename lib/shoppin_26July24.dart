import 'dart:io';

class Product {
  String name;
  String description;
  double price;
  double discount;
  int quantity;

  Product(this.name, this.description, this.price, this.discount, this.quantity);
}


class Visitor {
  String name;
  String email;
  ShoppingCart cart;

  Visitor(this.name, this.email) : cart = ShoppingCart();
}


class ShoppingCart {
  List<Product> selectedProducts = [];

  void addProduct(Product product) {
    selectedProducts.add(product);
  }

  void removeProduct(String productName) {
    selectedProducts.removeWhere((product) {
      return product.name == productName;
    });
  }

  double totalPrice() {
    double total = 0;
    for (var i = 0; i < selectedProducts.length; i++) {
      total += selectedProducts[i].price;
    }
    return total;
  }

  double totalAfterDiscount() {
    double total = 0;
    for (var i = 0; i < selectedProducts.length; i++) {
      total += (selectedProducts[i].price - selectedProducts[i].discount);
    }
    return total;
  }
}


class Website {
  List<Product> products = [];
  List<Visitor> visitors = [];

  void addVisitor(String name, String email) {
    visitors.add(Visitor(name, email));
  }

  void addProductToWebsite(Product product) {
    products.add(product);
  }

  void removeProduct(String productName) {
    products.removeWhere((product) {
      return product.name == productName;
    });
  }

  int searchByProductName(String productName) {
    for (int i = 0; i < products.length; i++) {
      if (products[i].name == productName) {
        return i;
      }
    }
    return -1;
  }

  List<Product> searchByPrice(double price) {
    List<Product> result = [];
    for (var i = 0; i < products.length; i++) {
      if (products[i].price == price) {
        result.add(products[i]);
      }
    }
    return result;
  }
}


void main() {
  var website = Website();

  website.addProductToWebsite(Product("Fish", "Fresh fish", 10.0, 1.0, 50));
  website.addProductToWebsite(Product("Milk", "Dairy milk", 2.0, 0.2, 100));
  website.addProductToWebsite(Product("Meat", "Fresh meat", 15.0, 1.5, 30));

  Visitor? currentVisitor;

  while (true) {
    if (currentVisitor == null) {
      print("1. Register a new visitor");
      print("2. Log in as an existing visitor");

      var choice = stdin.readLineSync();
      if (choice == '1') {
        print("Enter your name:");
        var name = stdin.readLineSync()!;
        print("Enter your email:");
        var email = stdin.readLineSync()!;
        website.addVisitor(name, email);
        print("Visitor registered. Please log in.");
      } else if (choice == '2') {
        print("Enter your email:");
        var email = stdin.readLineSync()!;
        for (var visitor in website.visitors) {
          if (visitor.email == email) {
            currentVisitor = visitor;
            break;
          }
        }
        if (currentVisitor == null) {
          print("Visitor not found. Please register first.");
        } else {
          print("Logged in as ${currentVisitor.name}");
        }
      } else {
        print("Invalid choice. Please try again.");
      }
    } else {
      print("1. Add a product to cart");
      print("2. Remove a product from cart by name");
      print("3. Show total price of products in cart");
      print("4. Show total price after discount");
      print("5. Add a product to website");
      print("6. Remove a product from website by name");
      print("7. Search product by name");
      print("8. Search product by price");

      var choice = stdin.readLineSync();
      if (choice == '1') {
        print("Enter the name of the product to add:");
        var productName = stdin.readLineSync()!;
        var productIndex = website.searchByProductName(productName);
        if (productIndex != -1) {
          currentVisitor.cart.addProduct(website.products[productIndex]);
          print("Product added to cart.");
        } else {
          print("Product not found. Please add the product to the website first.");
        }
      } else if (choice == '2') {
        print("Enter the name of the product to remove:");
        var productName = stdin.readLineSync()!;
        currentVisitor.cart.removeProduct(productName);
        print("Product removed from cart.");
      } else if (choice == '3') {
        print("Total price: ${currentVisitor.cart.totalPrice()}");
      } else if (choice == '4') {
        print("Total after discount: ${currentVisitor.cart.totalAfterDiscount()}");
      } else if (choice == '5') {
        print("Enter product name:");
        var name = stdin.readLineSync()!;
        print("Enter product description:");
        var description = stdin.readLineSync()!;
        print("Enter product price:");
        var price = double.parse(stdin.readLineSync()!);
        print("Enter product discount:");
        var discount = double.parse(stdin.readLineSync()!);
        print("Enter product quantity:");
        var quantity = int.parse(stdin.readLineSync()!);
        website.addProductToWebsite(Product(name, description, price, discount, quantity));
        print("Product added to website.");
      } else if (choice == '6') {
        print("Enter the name of the product to remove:");
        var productName = stdin.readLineSync()!;
        website.removeProduct(productName);
        print("Product removed from website.");
      } else if (choice == '7') {
        print("Enter the name of the product to search:");
        var productName = stdin.readLineSync()!;
        var index = website.searchByProductName(productName);
        if (index != -1) {
          print("Product found: ${website.products[index].name}");
        } else {
          print("Product not found.");
        }
      } else if (choice == '8') {
        print("Enter the price to search for:");
        var price = double.parse(stdin.readLineSync()!);
        var products = website.searchByPrice(price);
        if (products.isNotEmpty) {
          print("Products with price $price:");
          for (var product in products) {
            print(product.name);
          }
        } else {
          print("No products found with that price.");
        }
      } else {
        print("Invalid choice. Please try again.");
      }
    }
  }
}
