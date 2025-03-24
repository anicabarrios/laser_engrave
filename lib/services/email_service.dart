import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  // EmailJS credentials
  static const String _serviceId = 'service_xnp5lkc';
  static const String _templateId = 'template_bqvyctg';
  static const String _userId = 'IC555p7Y3JunsIvhe';

  // Initialize email service
  static void init() {
    // Method kept for interface consistency
  }

  // Send an email using EmailJS API
  static Future<void> sendEmail({
    required String name,
    required String email,
    String? phone,
    String? service,
    String? budget,
    String? preferredDate,
    required String message,
  }) async {
    try {
      // Create the template parameters
      final Map<String, dynamic> templateParams = {
        'from_name': name,
        'from_email': email,
        'phone': phone ?? 'Not provided',
        'service': service ?? 'Not specified',
        'budget': budget ?? 'Not specified',
        'preferred_date': preferredDate ?? 'Not specified',
        'message': message,
      };

      // Prepare the payload according to EmailJS API requirements
      final payload = json.encode({
        'service_id': _serviceId,
        'template_id': _templateId,
        'user_id': _userId,
        'template_params': templateParams,
      });

      // Send the request to EmailJS API
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost', 
        },
        body: payload,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send email: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}