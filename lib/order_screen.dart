import 'package:flutter/material.dart';
import 'order.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key, required this.orders}) : super(key: key);
  final List<Order>
      orders; // declare list so we can output it in the order screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF6D6A4),
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF6D6A4),
          child: Center(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                // Return ListTile for each item
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container( // puts border around orders
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: ListTile(
                      // contains orders
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      title: Text(
                        orders[index].toString(),
                        // order.tostring returns order in proper format of the order screen
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
