// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class Countries {
//   Countries._();
//   static const String _baseUrl = 'https://restcountries.com/v3.1/all';

//   static Future<List<dynamic>> fetchCountries() async {
//     try {
//       final response = await http.get(
//         Uri.parse(_baseUrl),
//       );

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception();
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// }

// class CountryInfo {
//   final String name;
//   final String flag;
//   final String phoneCode;
//   final String countryCode;

//   CountryInfo({
//     required this.name,
//     required this.flag,
//     required this.phoneCode,
//     required this.countryCode,
//   });

//   factory CountryInfo.fromJson(Map<String, dynamic> data) {
//     final name = data['name']['common'] as String;
//     final flag = data['flags']?['svg'] ?? '';
//     final countryCode = data['cca2'] ?? ''; // Extract "cca2"

//     final idd = data['idd'];
//     String phoneCode = '';
//     if (idd != null) {
//       final root = idd['root'] as String?;
//       final suffixes = idd['suffixes'] as List<dynamic>?;
//       if (root != null && suffixes != null && suffixes.isNotEmpty) {
//         phoneCode = '$root${suffixes[0]}';
//       }
//     }

//     return CountryInfo(
//       name: name,
//       flag: flag,
//       phoneCode: phoneCode,
//       countryCode: countryCode,
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/services.dart';

class CountryInfo {
  final String name;
  final String flag; // Local flag path
  final String phoneCode;
  final String countryCode;

  CountryInfo({
    required this.name,
    required this.flag,
    required this.phoneCode,
    required this.countryCode,
  });

  factory CountryInfo.fromJson(Map<String, dynamic> data) {
    final name = data['name'] ?? '';
    final countryCode = data['alpha2Code'] ?? data['cca2'] ?? '';

    // Convert flag URL to local assets path
    final flag = 'assets/image/flags/${countryCode.toLowerCase()}.svg';

    // Extract phone code
    String phoneCode = '';
    if (data['callingCodes'] != null &&
        data['callingCodes'] is List &&
        data['callingCodes'].isNotEmpty) {
      phoneCode = '+${data['callingCodes'][0]}';
    }

    return CountryInfo(
      name: name,
      flag: flag,
      phoneCode: phoneCode,
      countryCode: countryCode,
    );
  }
}

class Countries {
  Countries._();

  static Future<List<CountryInfo>> fetchCountries() async {
    try {
      String data = await rootBundle.loadString('assets/countriesV2.json');
      List<dynamic> jsonList = jsonDecode(data);
      return jsonList.map((json) => CountryInfo.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error loading countries: $e');
    }
  }
}
