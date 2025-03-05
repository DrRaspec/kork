class EventDetailModel {
  final String id;
  final String date;
  final String title;
  final String location;
  final String time;
  final String image;
  final int member;
  final String firstMember;
  final String secondMember;
  final String thirdMember;
  final String street;
  final String organizer;
  final String organizerProfile;
  final List<Map<String, dynamic>> ticket;
  final String contact;
  final String aboutEvent;
  final String price;

  EventDetailModel({
    required this.id,
    required this.date,
    required this.title,
    required this.location,
    required this.time,
    required this.image,
    required this.member,
    required this.firstMember,
    required this.secondMember,
    required this.thirdMember,
    required this.street,
    required this.organizer,
    required this.organizerProfile,
    required this.ticket,
    required this.contact,
    required this.aboutEvent,
    required this.price,
  });

  /// Factory constructor to create an object from a Map
  factory EventDetailModel.fromMap(Map<String, dynamic> map) {
    return EventDetailModel(
      id: map['id'] ?? '',
      date: map['date'] ?? '',
      title: map['title'] ?? '',
      location: map['location'] ?? '',
      time: map['time'] ?? '',
      image: map['image'] ?? '',
      member: map['member'] ?? 0,
      firstMember: map['firstMember'] ?? '',
      secondMember: map['secondMember'] ?? '',
      thirdMember: map['thirdMember'] ?? '',
      street: map['street'] ?? '',
      organizer: map['organizer'] ?? '',
      organizerProfile: map['organizer_profile'] ?? '',
      ticket: List<Map<String, dynamic>>.from(map['event_type'] ?? []),
      contact: map['contact'] ?? '',
      aboutEvent: map['about_event'] ?? '',
      price: map['price'] ?? '',
    );
  }

  /// Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'location': location,
      'time': time,
      'image': image,
      'member': member,
      'firstMember': firstMember,
      'secondMember': secondMember,
      'thirdMember': thirdMember,
      'street': street,
      'organizer': organizer,
      'organizer_profile': organizerProfile,
      'event_type': ticket,
      'contact': contact,
      'about_event': aboutEvent,
      'price': price,
    };
  }
}
