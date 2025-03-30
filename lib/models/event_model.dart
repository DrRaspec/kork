import 'package:google_maps_flutter/google_maps_flutter.dart';

class Event {
  final int id;
  final String eventName;
  final String eventType;
  final String description;
  final LatLng location;
  final String posterUrl;
  final DateTime startDate;
  final DateTime endDate;
  final String startTime;
  final String endTime;
  final User user;
  final List<dynamic> attendees;
  final List<Ticket> tickets;

  Event({
    required this.id,
    required this.eventName,
    required this.eventType,
    required this.description,
    required this.location,
    required this.posterUrl,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.user,
    required this.attendees,
    required this.tickets,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    LatLng? parsedLocation;

    if (json['location'].contains(',')) {
      try {
        List<String> coords = json['location'].split(',');
        double lat = double.parse(coords[0].trim());
        double lng = double.parse(coords[1].trim());
        parsedLocation = LatLng(lat, lng);
      } catch (e) {
        print("Invalid location format: ${json['location']}");
      }
    }

    return Event(
      id: json['id'],
      eventName: json['event_name'],
      eventType: json['event_type'],
      description: json['description'],
      location: parsedLocation ?? LatLng(0, 0),
      posterUrl: json['poster_url'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      startTime: json['start_time'],
      endTime: json['end_time'],
      user: User.fromJson(json['user']),
      attendees: json['attendees'] ?? [],
      tickets:
          (json['tickets'] as List).map((e) => Ticket.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_name': eventName,
      'event_type': eventType,
      'description': description,
      'location': '${location.latitude}, ${location.longitude}',
      'poster_url': posterUrl,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'start_time': startTime,
      'end_time': endTime,
      'user': user.toJson(),
      'attendees': attendees,
      'tickets': tickets.map((e) => e.toJson()).toList(),
    };
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? profileUrl;
  final String dob;
  final String phoneNumber;
  final String nationality;
  final String gender;
  final String location;
  final List<PaymentMethod> paymentMethods;
  final String? token;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profileUrl,
    required this.dob,
    required this.phoneNumber,
    required this.nationality,
    required this.gender,
    required this.location,
    required this.paymentMethods,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<PaymentMethod> payments = [];
    if (json['payment_methods'] != null) {
      payments = (json['payment_methods'] as List)
          .map((e) => PaymentMethod.fromJson(e))
          .toList();
    }

    return User(
      id: json['id'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      profileUrl: json['profile_url'],
      dob: json['dob'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      nationality: json['nationality'] ?? '',
      gender: json['gender'] ?? '',
      location: json['location'] ?? '',
      paymentMethods: payments,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'profile_url': profileUrl,
      'dob': dob,
      'phone_number': phoneNumber,
      'nationality': nationality,
      'gender': gender,
      'location': location,
      'payment_methods': paymentMethods.map((e) => e.toJson()).toList(),
    };

    if (token != null) {
      data['token'] = token;
    }

    return data;
  }
}

class PaymentMethod {
  final int id;
  final int cardNumber;
  final String cardHolderName;
  final String expiredDate;
  final int cvv;

  PaymentMethod({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiredDate,
    required this.cvv,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      cardNumber: json['card_number'],
      cardHolderName: json['card_holder_name'],
      expiredDate: json['expired_date'],
      cvv: json['cvv'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'card_number': cardNumber,
      'card_holder_name': cardHolderName,
      'expired_date': expiredDate,
      'cvv': cvv,
    };
  }
}

class Ticket {
  final int id;
  final int eventId;
  final String ticketType;
  final int qty;
  final int availableQty;
  final int soldQty;
  final double price;

  Ticket({
    required this.id,
    required this.eventId,
    required this.ticketType,
    required this.qty,
    required this.availableQty,
    required this.soldQty,
    required this.price,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      eventId: json['event_id'],
      ticketType: json['ticket_type'],
      qty: json['qty'],
      availableQty: json['available_qty'],
      soldQty: json['sold_qty'],
      price: double.parse(json['price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'ticket_type': ticketType,
      'qty': qty,
      'available_qty': availableQty,
      'sold_qty': soldQty,
      'price': price.toString(),
    };
  }
}
