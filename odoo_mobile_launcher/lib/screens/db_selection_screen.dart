import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_widgets.dart';
import 'login_screen.dart';

class DbSelectionScreen extends StatefulWidget {
  const DbSelectionScreen({Key? key}) : super(key: key);

  @override
  _DbSelectionScreenState createState() => _DbSelectionScreenState();
}

class _DbSelectionScreenState extends State<DbSelectionScreen> {
  String? _selectedDb;
  List<String> _databases = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDatabases();
  }

  Future<void> _fetchDatabases() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final dbs = await authProvider.fetchDatabases();
    
    if (mounted) {
      if (dbs.isEmpty && authProvider.error != null) {
          showErrorDialog(context, 'Error', authProvider.error!);
      }
      setState(() {
        _databases = dbs;
        if (dbs.isNotEmpty) {
           _selectedDb = dbs[0];
        }
        _isLoading = false;
      });
    }
  }

  Future<void> _submit() async {
    if (_selectedDb == null) {
        showErrorDialog(context, 'Selection Required', 'Please select a database');
        return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.selectDatabase(_selectedDb!);

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
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
                  'Choose Database',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                if (_databases.isEmpty)
                   const Text('No databases found or connection error.', textAlign: TextAlign.center, style: TextStyle(color: Colors.red)),

                if (_databases.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedDb,
                        isExpanded: true,
                        items: _databases.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedDb = newValue;
                          });
                        },
                      ),
                    ),
                  ),

                const SizedBox(height: 24),

                if (_databases.isNotEmpty)
                  PrimaryButton(
                    text: 'Next',
                    onPressed: _submit,
                  ),

                if (_databases.isEmpty)
                   TextButton(
                       onPressed: _fetchDatabases,
                       child: const Text("Retry")
                   )
              ],
            ),
          ),
    );
  }
}
