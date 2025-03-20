import 'package:flutter/material.dart';
import '../utils/animations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  final List<Map<String, dynamic>> contactInfo = [
    {
      'icon': Icons.person,
      'label': 'Name',
      'value': 'Waseem Qamar',
    },
    {
      'icon': Icons.location_on,
      'label': 'Address',
      'value': 'Pakistan, Swabi',
    },
    {
      'icon': Icons.email,
      'label': 'Email',
      'value': 'imwasim902@gmail.com',
    },
    {
      'icon': Icons.phone,
      'label': 'Phone',
      'value': '+92 3428169902',
    },
  ];

  final List<Map<String, dynamic>> socialLinks = [
    {
      'platform': 'Facebook',
      'icon': Icons.facebook,
      'url': 'https://www.facebook.com/waseem902',
      'color': Colors.blue,
    },
    {
      'platform': 'LinkedIn',
      'icon': Icons.business,
      'url': 'https://linkedin.com/in/waseem-qamar/',
      'color': Colors.blue.shade700,
    },
    {
      'platform': 'Fiverr',
      'icon': Icons.work,
      'url': 'https://fiverr.com/s/ljgz69Q',
      'color': Colors.green,
    },
    {
      'platform': 'GitHub',
      'icon': Icons.code,
      'url': 'https://github.com/waseemqamardev',
      'color': Colors.grey.shade800,
    },
  ];

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await http.post(
          Uri.parse('https://formspree.io/f/mrbpedkk'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'name': _nameController.text,
            'email': _emailController.text,
            'message': _messageController.text,
          }),
        );

        if (response.statusCode >= 200 && response.statusCode < 300) {
          // Success case
          _showSuccessDialog();
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
          _formKey.currentState!.reset();
        } else {
          // Error case
          print('Form submission failed: ${response.body}');
          _showErrorDialog('Failed to send message. Status: ${response.statusCode}');
        }
      } catch (e) {
        print('Error sending form: $e');
        _showErrorDialog('An error occurred: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              const Text('Success'),
            ],
          ),
          content: const Text('Your message has been sent successfully. I will get back to you soon!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 8),
              const Text('Error'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 24.0),
      child: isMobile
          ? Column(
              children: [_buildContactInfo(), const SizedBox(height: 40), _buildContactForm()],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildContactInfo()),
                const SizedBox(width: 40),
                Expanded(child: _buildContactForm()),
              ],
            ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ...contactInfo.map((info) => Column(
            children: [
              _buildContactItem(info['icon'], info['label'], info['value']),
              if (info != contactInfo.last) const Divider(height: 24),
            ],
          )).toList(),
          
          const SizedBox(height: 32),
          
          Text(
            'Connect With Me',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: socialLinks
                .map((social) => _buildSocialButton(
                      social['platform'],
                      social['icon'],
                      social['url'],
                      social['color'],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, double animationValue, child) {
          return Transform.scale(
            scale: 0.95 + (0.05 * animationValue),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    blurRadius: 8 * animationValue,
                    offset: Offset(0, 2 * animationValue),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          value,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSocialButton(String label, IconData icon, String url, Color color) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, double value, child) {
          return Transform.scale(
            scale: 0.95 + (0.05 * value),
            child: Material(
              elevation: 4 * value,
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => launchUrl(Uri.parse(url)),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        icon,
                        size: 24,
                        color: color,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 14,
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.email),
              ),
              validator: (value) => value == null || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]+$').hasMatch(value)
                  ? 'Please enter a valid email'
                  : null,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.message),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              validator: (value) => value == null || value.isEmpty ? 'Please enter your message' : null,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitForm,
              child: _isLoading ? const CircularProgressIndicator() : const Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}