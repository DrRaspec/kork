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
  final List<Attendee> attendees;
  final List<Ticket> tickets;
  final bool bookmarkStatus;

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
    this.bookmarkStatus = false,
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
      attendees: (json['attendees'] as List?)
              ?.map((e) => Attendee.fromJson(e))
              .toList() ??
          [],
      tickets:
          (json['tickets'] as List).map((e) => Ticket.fromJson(e)).toList(),
      bookmarkStatus: json['bookmark_status'] ?? false,
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
      'attendees': attendees.map((e) => e.toJson()).toList(),
      'tickets': tickets.map((e) => e.toJson()).toList(),
      'bookmark_status': bookmarkStatus,
    };
  }

  Event copyWith({
    int? id,
    String? eventName,
    String? eventType,
    String? description,
    LatLng? location,
    String? posterUrl,
    DateTime? startDate,
    DateTime? endDate,
    String? startTime,
    String? endTime,
    User? user,
    List<Attendee>? attendees,
    List<Ticket>? tickets,
    bool? bookmarkStatus,
  }) {
    return Event(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      eventType: eventType ?? this.eventType,
      description: description ?? this.description,
      location: location ?? this.location,
      posterUrl: posterUrl ?? this.posterUrl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      user: user ?? this.user,
      attendees: attendees ?? this.attendees,
      tickets: tickets ?? this.tickets,
      bookmarkStatus: bookmarkStatus ?? this.bookmarkStatus,
    );
  }
}

class Attendee {
  final String firstName;
  final String lastName;
  final String email;
  final String? profileUrl;
  final TicketPurchase? vvip;
  final TicketPurchase? vip;
  final TicketPurchase? standard;
  final TicketPurchase? normal;
  final int totalQty;

  Attendee({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profileUrl,
    this.vvip,
    this.vip,
    this.standard,
    this.normal,
    required this.totalQty,
  });

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      profileUrl: json['profile_url'],
      vvip: json['vvip'] != null ? TicketPurchase.fromJson(json['vvip']) : null,
      vip: json['vip'] != null ? TicketPurchase.fromJson(json['vip']) : null,
      standard: json['standard'] != null
          ? TicketPurchase.fromJson(json['standard'])
          : null,
      normal: json['normal'] != null
          ? TicketPurchase.fromJson(json['normal'])
          : null,
      totalQty: json['qty'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'profile_url': profileUrl,
      'vvip': vvip?.toJson(),
      'vip': vip?.toJson(),
      'standard': standard?.toJson(),
      'normal': normal?.toJson(),
      'qty': totalQty,
    };
  }
}

class TicketPurchase {
  final int qty;
  final String? price;

  TicketPurchase({
    required this.qty,
    this.price,
  });

  factory TicketPurchase.fromJson(Map<String, dynamic> json) {
    return TicketPurchase(
      qty: json['qty'] ?? 0,
      price: json['price']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'qty': qty,
      'price': price,
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
  final double? price;

  Ticket({
    required this.id,
    required this.eventId,
    required this.ticketType,
    required this.qty,
    required this.availableQty,
    required this.soldQty,
    this.price,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] ?? 0,
      eventId: json['event_id'] ?? 0,
      ticketType: json['ticket_type'] ?? 'Unknown',
      qty: json['qty'] ?? 0,
      availableQty: json['available_qty'] ?? 0,
      soldQty: json['sold_qty'] ?? 0,
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
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
      'price': price?.toString(),
    };
  }
}

class BoughtTicket {
  final int id;
  final Event event;
  final Ticket ticket;
  final User user;
  final String ticketCode;
  final String price;
  final String paymentStatus;
  final DateTime purchaseDate;

  BoughtTicket({
    required this.id,
    required this.event,
    required this.ticket,
    required this.user,
    required this.ticketCode,
    required this.price,
    required this.paymentStatus,
    required this.purchaseDate,
  });

  factory BoughtTicket.fromJson(Map<String, dynamic> json) {
    return BoughtTicket(
      id: json['id'],
      event: Event.fromJson(json['event']),
      ticket: Ticket.fromJson(json['ticket']),
      user: User.fromJson(json['user']),
      ticketCode: json['ticket_code'],
      price: json['price'],
      paymentStatus: json['payment_status'].toString(),
      purchaseDate: DateTime.parse(json['buy_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event': event.toJson(),
      'ticket': ticket.toJson(),
      'user': user.toJson(),
      'ticket_code': ticketCode,
      'price': price,
      'payment_status': paymentStatus,
      'buy_at': purchaseDate.toIso8601String(),
    };
  }

  BoughtTicket copyWith({
    int? id,
    Event? event,
    Ticket? ticket,
    User? user,
    String? ticketCode,
    String? price,
    String? paymentStatus,
    DateTime? purchaseDate,
  }) {
    return BoughtTicket(
      id: id ?? this.id,
      event: event ?? this.event,
      ticket: ticket ?? this.ticket,
      user: user ?? this.user,
      ticketCode: ticketCode ?? this.ticketCode,
      price: price ?? this.price,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      purchaseDate: purchaseDate ?? this.purchaseDate,
    );
  }

  // Helper methods
  bool get isPaid => paymentStatus == "1";

  int get eventId => event.id;

  int get ticketId => ticket.id;

  int get userId => user.id;

  String? get posterUrl => event.posterUrl;
}

class HostedEvent {
  final int id;
  final String eventName;
  final String eventType;
  final String description;
  final LatLng location;
  final String? posterUrl;
  final DateTime startDate;
  final DateTime endDate;
  final String startTime;
  final String endTime;
  final User host;
  final List<Attendee> attendees;
  final List<Ticket> tickets;
  final bool bookmarkStatus;

  HostedEvent({
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
    required this.host,
    required this.attendees,
    required this.tickets,
    this.bookmarkStatus = false,
  });

  factory HostedEvent.fromJson(Map<String, dynamic> json) {
    LatLng parsedLocation = const LatLng(0, 0);

    if (json['location'] != null && json['location'].contains(',')) {
      try {
        List<String> coords = json['location'].split(',');
        double lat = double.tryParse(coords[0].trim()) ?? 0;
        double lng = double.tryParse(coords[1].trim()) ?? 0;
        parsedLocation = LatLng(lat, lng);
      } catch (e) {
        print("Invalid location format: ${json['location']}");
      }
    }

    return HostedEvent(
      id: json['id'] ?? 0,
      eventName: json['event_name'] ?? 'Unknown Event',
      eventType: json['event_type'] ?? 'Unknown Type',
      description: json['description'] ?? '',
      location: parsedLocation,
      posterUrl: json['poster_url'],
      startDate: DateTime.tryParse(json['start_date'] ?? '') ?? DateTime.now(),
      endDate: DateTime.tryParse(json['end_date'] ?? '') ?? DateTime.now(),
      startTime: json['start_time'] ?? '00:00:00',
      endTime: json['end_time'] ?? '00:00:00',
      host: User.fromJson(json['user'] ?? {}),
      attendees: (json['attendees'] as List?)
              ?.map((e) => Attendee.fromJson(e))
              .toList() ??
          [],
      tickets: (json['tickets'] as List? ?? [])
          .map((e) => Ticket.fromJson(e))
          .toList(),
      bookmarkStatus: json['bookmark_status'] ?? false,
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
      'user': host.toJson(),
      'attendees': attendees.map((e) => e.toJson()).toList(),
      'tickets': tickets.map((e) => e.toJson()).toList(),
      'bookmark_status': bookmarkStatus,
    };
  }

  double get totalTicketValue {
    double total = 0.0;

    for (var ticket in tickets) {
      if (ticket.price != null) {
        total += ticket.price! * ticket.qty;
      }
    }

    return total;
  }

  double get soldTicketValue {
    double total = 0.0;

    for (var ticket in tickets) {
      if (ticket.price != null) {
        total += ticket.price! * ticket.soldQty;
      }
    }

    return total;
  }

  double get availableTicketValue {
    double total = 0.0;

    for (var ticket in tickets) {
      if (ticket.price != null) {
        total += ticket.price! * ticket.availableQty;
      }
    }

    return total;
  }

  int get totalTickets {
    int total = 0;
    for (var ticket in tickets) {
      total += ticket.qty;
    }
    return total;
  }

  int get soldTickets {
    int total = 0;
    for (var ticket in tickets) {
      total += ticket.soldQty;
    }
    return total;
  }

  int get availableTickets {
    int total = 0;
    for (var ticket in tickets) {
      total += ticket.availableQty;
    }
    return total;
  }

  bool get hasEnded {
    final now = DateTime.now();
    return endDate.isBefore(now) ||
        (endDate.day == now.day &&
            endDate.month == now.month &&
            endDate.year == now.year &&
            endTime.compareTo('${now.hour}:${now.minute}:${now.second}') < 0);
  }

  bool get isOngoing {
    final now = DateTime.now();
    return !hasEnded &&
        (startDate.isBefore(now) ||
            (startDate.day == now.day &&
                startDate.month == now.month &&
                startDate.year == now.year &&
                startTime
                        .compareTo('${now.hour}:${now.minute}:${now.second}') <=
                    0));
  }

  HostedEvent copyWith({
    int? id,
    String? eventName,
    String? eventType,
    String? description,
    LatLng? location,
    String? posterUrl,
    DateTime? startDate,
    DateTime? endDate,
    String? startTime,
    String? endTime,
    User? host,
    List<Attendee>? attendees,
    List<Ticket>? tickets,
    bool? bookmarkStatus,
  }) {
    return HostedEvent(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      eventType: eventType ?? this.eventType,
      description: description ?? this.description,
      location: location ?? this.location,
      posterUrl: posterUrl ?? this.posterUrl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      host: host ?? this.host,
      attendees: attendees ?? this.attendees,
      tickets: tickets ?? this.tickets,
      bookmarkStatus: bookmarkStatus ?? this.bookmarkStatus,
    );
  }
}
