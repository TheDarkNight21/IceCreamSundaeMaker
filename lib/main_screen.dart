import 'package:asst3/order_screen.dart';

import 'order.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'about_screen.dart';

enum FlavorLabel {
  // def enum for flavors dropdown menu, the color is attatched to the string to when the
  //string is chosen, the color of the app gets changed accordingly.
  vanilla('Vanilla', Colors.white),
  chocolate('Chocolate', Colors.brown),
  strawberry('Strawberry', Colors.redAccent);

  const FlavorLabel(this.label, this.color);

  final String label;
  final Color color;
}

enum SizeLabel {
  // similar to the flavor, except I attach a size here, so the font weight for the dropdown menu can change
  // based on the size chosen.
  small('Small', 16),
  medium('Medium', 20),
  large('Large', 24);

  const SizeLabel(this.label, this.size);

  final String label;
  final int size;
}

class Topping {
  // defined a topping class, which has the topping name and whether it is checked or not.
  final String name;
  bool isChecked;

  Topping(this.name, this.isChecked);
}

// Initialize a list of toppings
List<Topping> toppings = [
  Topping("Peanuts", false),
  Topping("M&Ms", false),
  Topping("Almonds", false),
  Topping("Brownies", false),
  Topping("Strawberries", false),
  Topping("Oreos", false),
  Topping("Gummy Bears", false),
  Topping("Marshmallows", false),
];

// define text style for buttons at bottom of app.
TextStyle buttonStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

var _fudge = 1.0; // init progress of fudge seekbar to 1.

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Order> _orders = []; // init list of orders
  FlavorLabel?
      flavorLabel; // define flavorLabel, an instance of FlavorLabel enum.
  SizeLabel? sizeLabel; // define sizeLabel, an instance of SizeLabel enum.

  void initState() {
    super.initState();
    flavorLabel = FlavorLabel.vanilla; // Initialize flavorLabel to vanilla
    sizeLabel = SizeLabel.small; // init sizelabel to small
    updateCost(); // update UI to reflect that
  }

  void goToAboutScreen() {
    // func to go to about screen
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AboutScreen(),
        ));
  }

  void goToOrderScreen() {
    // func to go to order screen
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderScreen(
            orders: _orders,
          ),
        ));
  }

  void handleClick(String value) {
    // handles selecting menu in app bar
    switch (value) {
      case 'Order History':
        goToOrderScreen();
      case 'About':
        goToAboutScreen();
    }
  }

  double _total = 0.00; // init total cost to 0

  void updateCost() {
    // updates cost (textview) based on users order.
    _total = 0.00;
    if (sizeLabel == SizeLabel.small) {
      _total += 2.99;
    } else if (sizeLabel == SizeLabel.medium) {
      _total += 3.99;
    } else {
      _total += 4.99;
    }

    for (int i = 0; i < toppings.length; i++) {
      Topping current = toppings[i];
      if (current.isChecked) {
        if (current.name == "Peanuts" ||
            current.name == "Almonds" ||
            current.name == "Marshmallows") {
          _total += 0.15;
        } else if (current.name == "Brownies" ||
            current.name == "Strawberries" ||
            current.name == "Gummy Bears" ||
            current.name == "Oreos") {
          _total += 0.20;
        } else {
          _total += 0.25;
        }
      }
    }

    if (_fudge == 1.0)
      _total += 0.15;
    else if (_fudge == 2.0)
      _total += 0.25;
    else if (_fudge == 3.0)
      _total += 0.30;
    else
      _total += 0.0;
  }

  void theWorks() {
    // function for the works button
    sizeLabel = SizeLabel.large;
    for (int i = 0; i < toppings.length; i++) {
      toppings[i].isChecked = true;
    }
    _fudge = 3.0;
    updateCost();
  }

  void resetOrder() {
    // function to reset the order
    sizeLabel = SizeLabel.small;
    flavorLabel = FlavorLabel.vanilla;
    for (int i = 0; i < toppings.length; i++) {
      toppings[i].isChecked = false;
    }
    _fudge = 1.0;
    updateCost();
  }

  void handleOrder() {
    // function to handle order
    Fluttertoast.showToast(
        msg: "Your order has been placed! Thank you!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
    final now = DateTime.now();
    _orders.add(Order(
        // adding customers order to list of orders, so it can display on the orders screen.
        sizeLabel!.label.toString(),
        flavorLabel!.label.toString(),
        '\$' + _total.toStringAsFixed(2),
        now.toString()));
    resetOrder();
  }

  Widget build(BuildContext context) {
    TextStyle sizeStyle = TextStyle(
        fontSize: sizeLabel?.size.toDouble(),
        color: Colors.black,
        fontWeight: FontWeight.bold);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ice Cream Sundae',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: flavorLabel?.color,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Order History', 'About'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Expanded(
            child: Container(
              color: flavorLabel?.color,
              child: Center(
                child: Column(
                  children: [
                    Row( // contains title of application (2 ice cream icons and sundae maker title)
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.icecream_sharp,
                          color: Colors.blueAccent,
                          size: 40,
                        ),
                        Text(
                          'Sundae Maker',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.icecream_sharp,
                          color: Colors.blueAccent,
                          size: 40,
                        ),
                      ],
                    ),
                    SizedBox(height: 27), // sized box to seperate between total cost and title
                    Row( // contains money icon and total cost
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.attach_money_rounded,
                          color: Colors.greenAccent,
                          size: 36,
                        ),
                        Text(
                          '${_total.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox( // another box
                      height: 12.0,
                    ),
                    Row( // size label and drop down menu
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Size:', style: sizeStyle),
                        SizedBox(width: 17),
                        DropdownButton<SizeLabel>(
                          style: sizeStyle,
                          value: sizeLabel,
                          onChanged: (SizeLabel? newValue) {
                            setState(() {
                              sizeLabel = newValue; // updates val, calls updatecost to update UI
                              updateCost();
                            });
                          },
                          items: SizeLabel.values.map((size) {
                            return DropdownMenuItem<SizeLabel>(
                              child: Text(size.label),
                              value: size,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Row( // has flavor label and drop down menu
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Flavor:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(width: 17),
                        DropdownButton<FlavorLabel>(
                          value: flavorLabel,
                          onChanged: (FlavorLabel? newValue) {
                            setState(() {
                              flavorLabel = newValue;
                            });
                          },
                          items: FlavorLabel.values.map((flavor) {
                            return DropdownMenuItem<FlavorLabel>(
                              child: Text(flavor.label,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              value: flavor,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row( // has toppings title
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Toppings!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 27),
                        )
                      ],
                    ),
                    Icon( // cake icon under toppings title
                      Icons.cake_sharp,
                      color: const Color(0xFFD8BFA5),
                      size: 30,
                    ),
                    SizedBox(height: 25),
                    Expanded( // builds listview of toppings, with maximum space left.
                      child: ListView.builder(
                        itemCount: toppings.length ~/ 2, // make it into 2 columns, so each column has length of length/2
                        itemBuilder: (BuildContext context, int index) {
                          // Calculate the index for the second column
                          int secondColumnIndex = index + toppings.length ~/ 2; // index of second one starts at end of first one until total num of toppings.
                          return Row( // returns 2 toppings, side by side.
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    title: Text(
                                      toppings[index].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    value: toppings[index].isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        toppings[index].isChecked = value!; // updates class bool val of topping
                                        updateCost(); // updates UI
                                      });
                                    }),
                              ),
                              Expanded( // same here
                                child: CheckboxListTile(
                                  contentPadding: EdgeInsets.only(right: 10),
                                  title: Text(
                                    toppings[secondColumnIndex].name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  value: toppings[secondColumnIndex].isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      toppings[secondColumnIndex].isChecked =
                                          value!;
                                      updateCost();
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Row( // contains fudge slider, with labels
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Fudge: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Slider(
                              value: _fudge,
                              label: _fudge.round().toString(),
                              max: 3, // max oz of fudge
                              divisions: 3, // max amt of slots user can choose
                              onChanged: (double value) {
                                setState(() {
                                  _fudge = value;
                                  updateCost();
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${_fudge.toInt()} OZ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 25),
                    Row( // contains 3 buttons at the buttom, spaced around
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue.shade900),
                            ),
                            onPressed: () {
                              setState(() {
                                theWorks(); // calls buttons respective function
                              });
                            },
                            child: Text(
                              'The Works!',
                              style: buttonStyle,
                            )),
                        TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue.shade900),
                            ),
                            onPressed: () {
                              setState(() {
                                handleOrder(); // calls buttons respective function
                              });
                            },
                            child: Text(
                              'Order',
                              style: buttonStyle,
                            )),
                        TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue.shade900),
                            ),
                            onPressed: () {
                              setState(() {
                                resetOrder(); // calls buttons respective function
                              });
                            },
                            child: Text(
                              'Reset',
                              style: buttonStyle,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
