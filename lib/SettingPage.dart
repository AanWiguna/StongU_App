import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _smsNotifications = false;
  bool _darkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0392FB),
                  Color(0xFF50BDF5),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFF0392FB)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Notification Settings',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        _buildSwitchTile(
                          title: 'Push Notification',
                          value: _pushNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              _pushNotifications = value;
                            });
                          },
                          activeColor: Color(0xFF0392FB),
                        ),
                        _buildSwitchTile(
                          title: 'Email Notification',
                          value: _emailNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              _emailNotifications = value;
                            });
                          },
                          activeColor: Color(0xFF0392FB),
                        ),
                        _buildSwitchTile(
                          title: 'SMS Notification',
                          value: _smsNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              _smsNotifications = value;
                            });
                          },
                          activeColor: Color(0xFF0392FB),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Preferences',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        _buildSwitchTile(
                          title: 'Dark Mode',
                          value: _darkMode,
                          onChanged: (bool value) {
                            setState(() {
                              _darkMode = value;
                            });
                          },
                          activeColor: Color(0xFF0392FB),
                        ),
                        ListTile(
                          title: Text('Language'),
                          trailing: Text(_language),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Privacy Settings',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        ListTile(
                          title: Text('App Permission'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Privacy Policy'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Terms of Service'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('About',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        ListTile(
                          title: Text('App Version : 1.0.0'),
                        ),
                        ListTile(
                          title: Text('About App'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('FAQ'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Rate the App'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color activeColor,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.trailing,
      activeColor: activeColor,
    );
  }
}
