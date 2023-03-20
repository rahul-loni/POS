class Getcategory {
  Getcategory({
    required this.title,
    required this.categories,
    required this.companyInfo,
    required this.totalPageNumber,
  });
  late final String title;
  late final List<Categories> categories;
  late final List<CompanyInfo> companyInfo;
  late final int totalPageNumber;

  Getcategory.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    categories = List.from(json['categories'])
        .map((e) => Categories.fromJson(e))
        .toList();
    companyInfo = List.from(json['company_info'])
        .map((e) => CompanyInfo.fromJson(e))
        .toList();
    totalPageNumber = json['total_page_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['categories'] = categories.map((e) => e.toJson()).toList();
    _data['company_info'] = companyInfo.map((e) => e.toJson()).toList();
    _data['total_page_number'] = totalPageNumber;
    return _data;
  }
}

class Categories {
  Categories({
    required this.id,
    required this.name,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int status;

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['status'] = status;
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
