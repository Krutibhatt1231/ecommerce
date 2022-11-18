class Cart {
  int? id;
  String? title;
  double? price;
  String? description;
  String? image;
  double? rate;
  int? qty;

  Cart(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.image,
      this.rate,
      this.qty});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'].toDouble();
    description = json['description'];
    image = json['image'];
    rate = json['rate'].toDouble();
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    data['rate'] = this.rate;
    data['qty'] = this.qty;
    return data;
  }

  getId() {
    return id ?? 0;
  }

  getTitle() {
    return title ?? '';
  }

  getPrice() {
    return price ?? 0.0;
  }

  getDescription() {
    return description;
  }

  getImage() {
    return image ?? '';
  }

  getRate() {
    return rate ?? 0.0;
  }

  getQty() {
    return qty ?? 0;
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'].toDouble();
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }

  getRate() {
    return rate ?? 0.0;
  }

  getCount() {
    return count ?? 0;
  }
}
