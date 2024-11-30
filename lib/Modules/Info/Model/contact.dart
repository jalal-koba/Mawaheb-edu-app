class Contact {
    final String whatsapp;
    final String facebook;
    final String telegram;
    final String youtube;
    final String instagram;
    final String email;
    final String phone;

    Contact({
        required this.whatsapp,
        required this.facebook,
        required this.telegram,
        required this.youtube,
        required this.instagram,
        required this.email,
        required this.phone,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        whatsapp: json["whatsapp"],
        facebook: json["facebook"],
        telegram: json["telegram"],
        youtube: json["youtube"],
        instagram: json["instagram"],
        email: json["email"],
        phone: json["phone"],
    );
 
}
