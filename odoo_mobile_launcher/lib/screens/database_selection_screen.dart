import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'login_screen.dart';

class DatabaseSelectionScreen extends StatefulWidget {
  @override
  _DatabaseSelectionScreenState createState() => _DatabaseSelectionScreenState();
}

class _DatabaseSelectionScreenState extends State<DatabaseSelectionScreen> {
  bool _isLoading = false;
  String? _errorMessage;
  List<String> _databases = [];
  String? _selectedDatabase;

  @override
  void initState() {
    super.initState();
    _loadDatabases();
  }

  Future<void> _loadDatabases() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final appState = Provider.of<AppState>(context, listen: false);
      List<String> databases = await appState.getDatabaseList();

      if (databases.isNotEmpty) {
        setState(() {
          _databases = databases;
          _selectedDatabase = databases.first;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'No databases found on this server.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load database list. Please check your connection.';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveSelectedDatabase() async {
    if (_selectedDatabase == null) {
      setState(() {
        _errorMessage = 'Please select a database.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final appState = Provider.of<AppState>(context, listen: false);
      await appState.saveSelectedDatabase(_selectedDatabase!);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to save database selection. Please try again.';
        _isLoading = false;
      });
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),
            Icon(
              Icons.storage,
              size: 80,
              color: Colors.blue[700],
            ),
            SizedBox(height: 20),
            Text(
              'Select Database',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Choose the database to connect to',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 40),
            if (_isLoading)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.blue[700]),
                      SizedBox(height: 20),
                      Text('Loading databases...'),
                    ],
                  ),
                ),
              )
            else if (_errorMessage != null)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 60,
                        color: Colors.red,
                      ),
                      SizedBox(height: 20),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _loadDatabases,
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                ),
              )
            else ...[
              DropdownButtonFormField<String>(
                value: _selectedDatabase,
                decoration: InputDecoration(
                  labelText: 'Database',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.storage),
                ),
                items: _databases.map((String database) {
                  return DropdownMenuItem<String>(
                    value: database,
                    child: Text(database),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDatabase = newValue;
                  });
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
                onPressed: _isLoading ? null : _saveSelectedDatabase,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Next',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}