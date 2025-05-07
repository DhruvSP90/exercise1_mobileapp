import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nike Shoes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class Shoe {
  final int id;
  final String name;
  final String category;
  final double price;
  final String imagePath;
  final List<String> sizes;
  final Color backgroundColor;

  Shoe({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imagePath,
    required this.sizes,
    required this.backgroundColor,
  });
}

class CartItem {
  final Shoe shoe;
  final String size;
  int quantity;

  CartItem({
    required this.shoe,
    required this.size,
    this.quantity = 1,
  });
}

final List<Shoe> shoes = [
  Shoe(
    id: 1,
    name: 'Sneakers',
    category: 'Nike',
    price: 100,
    imagePath: 'assets/red_shoe.jpg',
    sizes: ['40', '42', '44', '46'],
    backgroundColor: Colors.red,
  ),
  Shoe(
    id: 2,
    name: 'Sneakers',
    category: 'Nike',
    price: 120,
    imagePath: 'assets/blue_shoe.jpg',
    sizes: ['40', '42', '44', '46'],
    backgroundColor: Colors.blue,
  ),
  Shoe(
    id: 3,
    name: 'Sneakers',
    category: 'Nike',
    price: 140,
    imagePath: 'assets/white_shoe.jpg',
    sizes: ['40', '42', '44', '46'],
    backgroundColor: Colors.grey.shade200,
  ),
];

List<CartItem> cartItems = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartScreen(
          cartItems: cartItems,
          onCartUpdated: () => setState(() {}),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset('assets/logo.jpeg', height: 30),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.black),
                onPressed: _goToCart,
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${cartItems.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: shoes.length,
        itemBuilder: (context, index) {
          return _buildProductCard(context, shoes[index]);
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Shoe shoe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              shoe: shoe,
              onAddToCart: () => setState(() {}),
            ),
          ),
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 400;
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: shoe.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: isNarrow
                  ? _buildNarrowCard(shoe)
                  : _buildWideCard(shoe),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNarrowCard(Shoe shoe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // image on top
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset(
            shoe.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Center(
              child: Icon(Icons.broken_image, color: Colors.white, size: 40),
            ),
          ),
        ),

        // text below
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                shoe.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                shoe.category,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${shoe.price.toInt()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWideCard(Shoe shoe) {
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          // text panel
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shoe.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    shoe.category,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$${shoe.price.toInt()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // image panel
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.asset(
                shoe.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(Icons.broken_image, color: Colors.white, size: 50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailScreen extends StatefulWidget {
  final Shoe shoe;
  final VoidCallback onAddToCart;

  const ProductDetailScreen({
    Key? key,
    required this.shoe,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedSize = '42';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.shoe.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                widget.shoe.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.white.withOpacity(0.1),
                  child: const Icon(Icons.broken_image,
                      color: Colors.white, size: 50),
                ),
              ),
            ),

            // back button
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // bottom sheet
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.shoe.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Size',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.shoe.sizes.map((size) {
                        final isSelected = size == selectedSize;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => selectedSize = size),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border:
                              Border.all(color: Colors.white, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                size,
                                style: TextStyle(
                                  color: isSelected
                                      ? widget.shoe.backgroundColor
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          var exists = false;
                          for (var item in cartItems) {
                            if (item.shoe.id == widget.shoe.id &&
                                item.size == selectedSize) {
                              item.quantity++;
                              exists = true;
                              break;
                            }
                          }
                          if (!exists) {
                            cartItems.add(CartItem(
                                shoe: widget.shoe,
                                size: selectedSize));
                          }
                          widget.onAddToCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to cart!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Buy Now',
                          style: TextStyle(
                            color: widget.shoe.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final VoidCallback onCartUpdated;

  const CartScreen({
    Key? key,
    required this.cartItems,
    required this.onCartUpdated,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get totalAmount =>
      widget.cartItems.fold(0, (sum, item) => sum + item.shoe.price * item.quantity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Shopping Cart', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (ctx, i) {
                final item = widget.cartItems[i];
                return Dismissible(
                  key: Key('${item.shoe.id}-${item.size}'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    setState(() {
                      widget.cartItems.removeAt(i);
                      widget.onCartUpdated();
                    });
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      const SnackBar(content: Text('Item removed')),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: item.shoe.backgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Image.asset(
                                item.shoe.imagePath,
                                height: 60,
                                errorBuilder: (_, __, ___) =>
                                const Icon(Icons.broken_image, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.shoe.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text('Size: ${item.size}',
                                    style: TextStyle(color: Colors.grey[600])),
                                Text('\$${item.shoe.price.toInt()}',
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (item.quantity > 1) {
                                      item.quantity--;
                                    } else {
                                      widget.cartItems.removeAt(i);
                                    }
                                    widget.onCartUpdated();
                                  });
                                },
                              ),
                              Text('${item.quantity}',
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    item.quantity++;
                                    widget.onCartUpdated();
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5)),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('\$${totalAmount.toInt()}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.cartItems.clear();
                        widget.onCartUpdated();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order placed!')),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Checkout',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
