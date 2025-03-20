import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DownloadUtils {
  static Future<void> downloadCV(BuildContext context) async {
    // Direct download link from Google Drive
    final Uri directUrl = Uri.parse('https://drive.google.com/uc?export=download&id=1IeiMVXVNyVAtHdQPRFFMmh9-wyynkoUO');
    
    // Viewer URL as backup
    final Uri viewerUrl = Uri.parse('https://drive.google.com/file/d/1IeiMVXVNyVAtHdQPRFFMmh9-wyynkoUO/view');

    try {
      final Uri urlToUse = kIsWeb ? viewerUrl : directUrl;
      
      if (!context.mounted) return;

      try {
        bool launched = await launchUrl(
          urlToUse,
          mode: kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication,
          webOnlyWindowName: kIsWeb ? '_blank' : null,
        );

        if (launched && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Opening CV...'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          _showErrorDialog(context, urlToUse, viewerUrl);
        }
      } catch (e) {
        debugPrint('Error launching URL: $e');
        if (context.mounted) {
          _showErrorDialog(context, urlToUse, viewerUrl);
        }
      }
    } catch (e) {
      debugPrint('Error parsing URL: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to process the CV link. Please try again.'),
            backgroundColor: Colors.red[700],
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  static void _showErrorDialog(BuildContext context, Uri primaryUrl, Uri backupUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Download Failed'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Please try one of these options:'),
            const SizedBox(height: 16),
            _buildLinkOption(
              '1. View in Google Drive',
              backupUrl,
              context,
            ),
            const SizedBox(height: 16),
            _buildLinkOption(
              '2. Direct Download',
              primaryUrl,
              context,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  static Widget _buildLinkOption(String label, Uri url, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            try {
              final launched = await launchUrl(
                url,
                mode: kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication,
                webOnlyWindowName: kIsWeb ? '_blank' : null,
              );
              if (launched && context.mounted) {
                Navigator.pop(context);
              }
            } catch (e) {
              debugPrint('Error launching URL: $e');
            }
          },
          child: Text(
            url.toString(),
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
} 