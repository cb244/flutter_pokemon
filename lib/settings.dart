import 'package:flutter/material.dart';
import 'package:pokemon/utils/theme_mode.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(
      builder: (context, mode, child) => ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lightbulb),
            title: const Text('Dark/Light Mode'),
            trailing: Text((mode.mode == ThemeMode.system)
                ? 'System'
                : (mode.mode == ThemeMode.dark)
                    ? 'Dark'
                    : 'Light'),
            onTap: () async {
              var ret = await Navigator.of(context).push<ThemeMode>(
                MaterialPageRoute(
                  builder: (context) => ThemeModeSelectionPage(mode: mode.mode),
                ),
              );
              mode.update(ret!);
            },
          ),
          SwitchListTile(
            title: const Text('Switch'),
            value: true,
            onChanged: (yes) => {},
          ),
          CheckboxListTile(
            title: const Text('Checkbox'),
            value: true,
            onChanged: (yes) => {},
          ),
          RadioListTile(
            title: const Text('Radio'),
            value: true,
            groupValue: true,
            onChanged: (yes) => {},
          )
        ],
      ),
    );
  }
}

class ThemeModeSelectionPage extends StatefulWidget {
  final ThemeMode mode;
  const ThemeModeSelectionPage({
    Key? key,
    required this.mode,
  }) : super(key: key);

  @override
  _ThemeModeSelectionPageState createState() => _ThemeModeSelectionPageState();
}

class _ThemeModeSelectionPageState extends State<ThemeModeSelectionPage> {
  late ThemeMode _current;
  @override
  void initState() {
    super.initState();
    _current = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop<ThemeMode>(context, _current),
              ),
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.system,
              groupValue: _current,
              title: const Text('System'),
              onChanged: (val) => {setState(() => _current = val!)},
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.light,
              groupValue: _current,
              title: const Text('Light'),
              onChanged: (val) => {setState(() => _current = val!)},
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: _current,
              title: const Text('Dark'),
              onChanged: (val) => {setState(() => _current = val!)},
            ),
          ],
        ),
      ),
    );
  }
}
