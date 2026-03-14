import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/app_state.dart';
import 'database_selection_screen.dart';

class ServerUrlInputScreen extends StatefulWidget {
  @override
  _ServerUrlInputScreenState createState() => _ServerUrlInputScreenState();
}

class _ServerUrlInputScreenState extends State<ServerUrlInputScreen> {
  final TextEditingController _urlController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _validateAndSaveUrl() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        String url = _urlController.text.trim();

        // Ensure URL has proper protocol
        if (!url.startsWith(RegExp(r'https?://'))) {
          url = 'https://' + url;
        }

        // Remove trailing slash
        if (url.endsWith('/')) {
          url = url.substring(0, url.length - 1);
        }

        final appState = Provider.of<AppState>(context, listen: false);
        bool isValid = await appState.validateServerUrl(url);

        if (isValid) {
          await appState.saveServerUrl(url);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => DatabaseSelectionScreen()),
          );
        } else {
          setState(() {
            _errorMessage = 'Invalid Odoo server URL. Please check and try again.';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to connect to server. Please check the URL and try again.';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Odoo Mobile ERP'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              Icon(
                Icons.link,
                size: 80,
                color: Colors.blue[700],
              ),
              SizedBox(height: 20),
              Text(
                'Enter Odoo Server URL',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Example: https://your-company.odoo.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 40),
              TextFormField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: 'Server URL',
                  hintText: 'https://your-company.odoo.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.web),
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a server URL';
                  }

                  // Basic URL validation
                  if (!RegExp(r'^https?://[^\s/$.?#].[^\s]*$').hasMatch(value)) {
                    return 'Please enter a valid URL';
                  }

                  return null;
                },
              ),
              SizedBox(height: 20),
              if (_errorMessage != null)
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: Colors.red),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _validateAndSaveUrl,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Proceed',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  final Uri url = Uri.parse('https://www.odoo.com/');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                child: Text(
                  'Need an Odoo account?',
                  style: TextStyle(color: Colors.blue[700]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}