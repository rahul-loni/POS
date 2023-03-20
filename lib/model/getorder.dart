class Getorder {
  Getorder({
    required this.title,
    required this.orders,
    required this.companyInfo,
    required this.totalPageNumber,
  });
  late final String title;
  late final List<Orders> orders;
  late final List<CompanyInfo> companyInfo;
  late final int totalPageNumber;

  Getorder.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    orders = List.from(json['orders']).map((e) => Orders.fromJson(e)).toList();
    companyInfo = List.from(json['company_info'])
        .map((e) => CompanyInfo.fromJson(e))
        .toList();
    totalPageNumber = json['total_page_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['orders'] = orders.map((e) => e.toJson()).toList();
    _data['company_info'] = companyInfo.map((e) => e.toJson()).toList();
    _data['total_page_number'] = totalPageNumber;
    return _data;
  }
}

class Orders {
  Orders({
    required this.id,
    required this.enteredBy,
    required this.financialYear,
    required this.billNo,
    required this.transactionId,
    required this.customerName,
    required this.customerPan,
    required this.amount,
    required this.discount,
    required this.taxableAmount,
    required this.taxAmount,
    required this.serviceAmount,
    required this.totalAmount,
    required this.paymentMethod,
    required this.ordered,
    required this.createdAt,
    required this.orderedDate,
    required this.isRealtime,
    required this.vatRefundAmount,
    required this.salesReturn,
    required this.salesReturnReason,
    required this.printedTime,
    required this.syncWithIrd,
    required this.isBillPrinted,
    required this.isBillActive,
    required this.table,
    required this.items,
  });
  late final int id;
  late final String enteredBy;
  late final String financialYear;
  late final String billNo;
  late final String transactionId;
  late final String customerName;
  late final String customerPan;
  late final double amount;
  late final double discount;
  late final double taxableAmount;
  late final double taxAmount;
  late final double serviceAmount;
  late final double totalAmount;
  late final String paymentMethod;
  late final bool ordered;
  late final String createdAt;
  late final String orderedDate;
  late final bool isRealtime;
  late final double vatRefundAmount;
  late final bool salesReturn;
  late final String salesReturnReason;
  late final String printedTime;
  late final bool syncWithIrd;
  late final bool isBillPrinted;
  late final bool isBillActive;
  late final Table table;
  late final List<Items> items;

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enteredBy = json['entered_by'];
    financialYear = json['financial_year'];
    billNo = json['bill_no'];
    transactionId = json['transaction_id'];
    customerName = json['customer_name'];
    customerPan = json['customer_pan'];
    amount = json['amount'];
    discount = json['discount'];
    taxableAmount = json['taxable_amount'];
    taxAmount = json['tax_amount'];
    serviceAmount = json['service_amount'];
    totalAmount = json['total_amount'];
    paymentMethod = json['payment_method'];
    ordered = json['ordered'];
    createdAt = json['created_at'];
    orderedDate = json['ordered_date'];
    isRealtime = json['is_realtime'];
    vatRefundAmount = json['vat_refund_amount'];
    salesReturn = json['sales_return'];
    salesReturnReason = json['sales_return_reason'];
    printedTime = json['printed_time'];
    syncWithIrd = json['sync_with_ird'];
    isBillPrinted = json['is_bill_printed'];
    isBillActive = json['is_bill_active'];
    table = Table.fromJson(json['table']);
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['entered_by'] = enteredBy;
    _data['financial_year'] = financialYear;
    _data['bill_no'] = billNo;
    _data['transaction_id'] = transactionId;
    _data['customer_name'] = customerName;
    _data['customer_pan'] = customerPan;
    _data['amount'] = amount;
    _data['discount'] = discount;
    _data['taxable_amount'] = taxableAmount;
    _data['tax_amount'] = taxAmount;
    _data['service_amount'] = serviceAmount;
    _data['total_amount'] = totalAmount;
    _data['payment_method'] = paymentMethod;
    _data['ordered'] = ordered;
    _data['created_at'] = createdAt;
    _data['ordered_date'] = orderedDate;
    _data['is_realtime'] = isRealtime;
    _data['vat_refund_amount'] = vatRefundAmount;
    _data['sales_return'] = salesReturn;
    _data['sales_return_reason'] = salesReturnReason;
    _data['printed_time'] = printedTime;
    _data['sync_with_ird'] = syncWithIrd;
    _data['is_bill_printed'] = isBillPrinted;
    _data['is_bill_active'] = isBillActive;
    _data['table'] = table.toJson();
    _data['items'] = items.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Table {
  Table({
    required this.id,
    required this.name,
    required this.capacity,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int capacity;
  late final int status;

  Table.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    capacity = json['capacity'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['capacity'] = capacity;
    _data['status'] = status;
    return _data;
  }
}

class Items {
  Items({
    required this.id,
    required this.user,
    required this.item,
    required this.ordered,
    required this.product,
    required this.productId,
    required this.note,
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
  late final String note;
  late final double price;
  late final int quantity;
  late final String orderedDate;
  late final List<dynamic> extraProduts;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    item = json['item'];
    ordered = json['ordered'];
    product = json['product'];
    productId = json['product_id'];
    note = json['note'];
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

class CompanyInfo {
  CompanyInfo({
    required this.id,
    required this.logo,
    required this.name,
    required this.address,
    required this.phone,
    required this.panNo,
    required this.message,
    required this.Tax,
    required this.serviceCharge,
    required this.currency,
    required this.fiscalYear,
    required this.irdUsername,
    required this.irdPassword,
    required this.syncIrd,
  });
  late final int id;
  late final String logo;
  late final String name;
  late final String address;
  late final String phone;
  late final String panNo;
  late final String message;
  late final String Tax;
  late final String serviceCharge;
  late final String currency;
  late final String fiscalYear;
  late final String irdUsername;
  late final String irdPassword;
  late final bool syncIrd;

  CompanyInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    panNo = json['pan_no'];
    message = json['message'];
    Tax = json['Tax'];
    serviceCharge = json['service_charge'];
    currency = json['currency'];
    fiscalYear = json['fiscal_year'];
    irdUsername = json['ird_username'];
    irdPassword = json['ird_password'];
    syncIrd = json['sync_ird'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['logo'] = logo;
    _data['name'] = name;
    _data['address'] = address;
    _data['phone'] = phone;
    _data['pan_no'] = panNo;
    _data['message'] = message;
    _data['Tax'] = Tax;
    _data['service_charge'] = serviceCharge;
    _data['currency'] = currency;
    _data['fiscal_year'] = fiscalYear;
    _data['ird_username'] = irdUsername;
    _data['ird_password'] = irdPassword;
    _data['sync_ird'] = syncIrd;
    return _data;
  }
}
