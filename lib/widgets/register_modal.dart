// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// import '../models/product.dart';

// class RegisterModal extends StatefulWidget {
//   const RegisterModal({super.key});

//   @override
//   State<RegisterModal> createState() => _RegisterModalState();
// }

// class _RegisterModalState extends State<RegisterModal> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();

//   List<Map<String, dynamic>> _items = [];
//   final _shoppingBox = Hive.box<Product>('shopping_box');

//   List<dynamic> _data = [];
//   @override
//   void initState() {
//     super.initState();
//     _refreshItems();
//   }

//   void _refreshItems() {
//     // final data = _shoppingBox.keys.map((key) {
//     //   final item = _shoppingBox.get(key);
//     //   return {"key": key, "name": item["name"], "quantity": item["quantity"]};
//     // }).toList();

//     List<Product> _data = _shoppingBox.values.toList().reversed.toList();

//     // setState(() {
//     //   _items = data.reversed.toList();
//     //   print(_items.length);
//     // });
//   }

//   Future<void> _createItem(Map<String, dynamic> newItem) async {
//     await _shoppingBox.add(newItem);
//     _refreshItems();
//   }

//   Future _updateItem(int itemKey, Map<String, dynamic> item) async {
//     await _shoppingBox.put(itemKey, item);
//     _refreshItems();
//   }

//   Future _deleteItem(int itemKey) async {
//     await _shoppingBox.delete(itemKey);
//     _refreshItems();

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("An item has been deleted"),
//       ),
//     );
//   }

//   void _showForm(BuildContext ctx, int? itemKey) async {
//     if (itemKey != null) {
//       final existingItem =
//           _items.firstWhere((element) => element["key"] == itemKey);
//       _nameController.text = existingItem["name"];
//       _quantityController.text = existingItem["quantity"].toString();
//     }
    
//     showModalBottomSheet(
//       context: ctx,
//       elevation: 5,
//       isScrollControlled: true,
//       builder: (_) => Container(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(ctx).viewInsets.bottom,
//           top: 15,
//           left: 15,
//           right: 15,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 hintText: "Name",
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _quantityController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 hintText: "Quantity",
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 if (itemKey == null) {
//                   _createItem({
//                     "name": _nameController.text,
//                     "quantity": _quantityController.text
//                   });
//                 } else {
//                   _updateItem(itemKey, {
//                     "name": _nameController.text.trim(),
//                     "quantity": _quantityController.text.trim()
//                   });
//                 }

//                 _nameController.clear();
//                 _quantityController.clear();

//                 Navigator.of(ctx).pop();
//               },
//               child: Text(itemKey == null ? "Create New" : "Update"),
//             ),
//             const SizedBox(height: 15),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Register Modal"),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => _showForm(context, null),
//           child: const Icon(Icons.add),
//         ),
//         body: ListView.builder(
//           itemCount: _data.length, //_items.length,
//           itemBuilder: (_, index) {
//             final currentItem = _data[index];
//             return Card(
//               color: Colors.orange.shade100,
//               margin: const EdgeInsets.all(10),
//               elevation: 5,
//               child: ListTile(
//                 title: Text(currentItem['name']),
//                 subtitle: Text(
//                   currentItem['quantity'].toString(),
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.edit),
//                       onPressed: () => _showForm(context, currentItem["key"]),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () => _deleteItem(currentItem["key"]),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ));
//   }
// }
