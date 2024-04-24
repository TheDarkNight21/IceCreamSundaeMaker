class Order {
  String _size;
  String _flavor;
  String _cost;
  String _time;

  Order(this._size, this._flavor, this._cost, this._time);

  @override
  String toString() { // format for order screen
    return "Date: ${this._time} \n Flavor: ${this._flavor} \n Size: ${this._size} \n Cost: ${this._cost}";


  }

}