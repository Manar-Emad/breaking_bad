class Quote {

  late String quote;
  Quote({ required this.quote});

  Quote.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quote'] = quote;
    return data;
  }
}