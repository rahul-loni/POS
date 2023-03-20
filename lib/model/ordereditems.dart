class OrderItem {
  OrderItem({
    required this.id,
    required this.user,
    required this.item,
    required this.ordered,
    required this.product,
    required this.productId,
     this.note,
    required this.price,
    required this.quantity,
    required this.orderedDate,
    required this.extraProduts,
  });
  late final int id;
  late final int user;
  late final int item;
  late final bool ordered;
  late final String product;
  late final int productId;
  late final Null note;
  late final double price;
  late final int quantity;
  late final String orderedDate;
  late final List<dynamic> extraProduts;
  
  OrderItem.fromJson(Map<String, dynamic> json){
    id = json['id'];
    user = json['user'];
    item = json['item'];
    ordered = json['ordered'];
    product = json['product'];
    productId = json['product_id'];
    note = null;
    price = json['price'];
    quantity = json['quantity'];
    orderedDate = json['ordered_date'];
    extraProduts = List.castFrom<dynamic, dynamic>(json['extra_produts']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user'] = user;
    _data['item'] = item;
    _data['ordered'] = ordered;
    _data['product'] = product;
    _data['product_id'] = productId;
    _data['note'] = note;
    _data['price'] = price;
    _data['quantity'] = quantity;
    _data['ordered_date'] = orderedDate;
    _data['extra_produts'] = extraProduts;
    return _data;
  }
}