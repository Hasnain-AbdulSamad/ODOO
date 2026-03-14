import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_widgets.dart';
import 'db_selection_screen.dart';

class UrlInputScreen extends StatefulWidget {
  const UrlInputScreen({Key? key}) : super(key: key);

  @override
  _UrlInputScreenState createState() => _UrlInputScreenState();
}

class _UrlInputScreenState extends State<UrlInputScreen> {
  final TextEditingController _urlController = TextEditingController();

  Future<void> _submit() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      showErrorDialog(context, 'Error', 'Please enter a server URL');
      return;
    }

    // Basic format check, allow user to type "example.com" and append https://
    String formattedUrl = url;
    if (!url.startsWith('http')) {
        formattedUrl = 'https://$url';
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.setServerUrl(formattedUrl);

    if (!mounted) return;

    if (authProvider.error != null) {
      showErrorDialog(context, 'Connection Failed', authProvider.error!);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const DbSelectionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/logo.png'),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 24),
            const Text(
              'Enter Odoo Server URL',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'e.g. https://company.odoo.com',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomTextField(
              controller: _urlController,
              label: 'Server URL',
              icon: Icons.link,
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Proceed',
              onPressed: _submit,
              isLoading: authProvider.isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
