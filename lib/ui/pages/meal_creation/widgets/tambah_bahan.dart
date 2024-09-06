import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(title: 'Mindful Pantry'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List of ingredients
  List<Map<String, String>> ingredients = [
    {'name': 'Semangka', 'quantity': '1', 'weight': '600 gram', 'expiryDate': '20/06/24'},
    {'name': 'Buah Naga', 'quantity': '1', 'weight': '150 gram', 'expiryDate': '20/06/24'},
    {'name': 'Sirsak', 'quantity': '1', 'weight': '200 gram', 'expiryDate': '20/06/24'},
    {'name': 'Yakult', 'quantity': '2', 'weight': '160 gram', 'expiryDate': '20/06/24'},
  ];

  // Function to delete an ingredient
  void deleteIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Add your functionality for the button press here
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  backgroundColor: Color(0xFF0A6847),
                ),
                child: Text(
                  'Tambah bahan yang anda miliki',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
              ),
            ),
            // List of ingredients
            Column(
              children: List.generate(ingredients.length, (index) {
                return IngredientItem(
                  name: ingredients[index]['name']!,
                  quantity: ingredients[index]['quantity']!,
                  weight: ingredients[index]['weight']!,
                  expiryDate: ingredients[index]['expiryDate']!,
                  onDelete: () => deleteIngredient(index), // Pass the delete function
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 90.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0A6847),
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text(
                  'BUAT RESEP',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 16, // Optional: adjust the font size
                    fontWeight: FontWeight.bold, // Optional: adjust the font weight
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IngredientItem extends StatelessWidget {
  final String name;
  final String quantity;
  final String weight;
  final String expiryDate;
  final VoidCallback onDelete; // Callback for delete action

  IngredientItem({
    required this.name,
    required this.quantity,
    required this.weight,
    required this.expiryDate,
    required this.onDelete, // Include the onDelete callback
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Jumlah: $quantity',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                Text(
                  'Berat: $weight',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                Text(
                  'Kadaluarsa: $expiryDate',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {}, // Add edit functionality here if needed
            icon: Icon(Icons.edit),
            color: Color(0xFF0A6847),
          ),
          IconButton(
            onPressed: onDelete, // Delete the ingredient on press
            icon: Icon(Icons.delete),
            color: Color(0xFF0A6847),
          ),
        ],
      ),
    );
  }
}