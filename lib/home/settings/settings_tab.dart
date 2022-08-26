import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/home/providers/settings_provider.dart';
import 'package:to_do_app/home/settings/language_bottom_sheet.dart';
import 'package:to_do_app/home/settings/theme_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.language,
              style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          SizedBox(
            height: 4,
          ),
          InkWell(
            onTap: () {
              showLanguageBottomSheet();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1),
                    color: settingsProvider.isDarkMode()
                        ? Color(0xFF141922)
                        : Colors.white,
                  ),
                  child: Text(
                    settingsProvider.currentLang == 'en'
                        ? 'English'
                        : 'العربية',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  )),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(AppLocalizations.of(context)!.theme,
              style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          SizedBox(
            height: 4,
          ),
          InkWell(
            onTap: () {
              showThemeBottomSheet();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1),
                    color: settingsProvider.isDarkMode()
                        ? Color(0xFF141922)
                        : Colors.white,
                  ),
                  child: Text(
                      settingsProvider.isDarkMode()
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20))),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (buildContext) {
        return LanguageBottomSheet();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), topLeft: Radius.circular(25)),
      ),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (buildContext) {
        return ThemeBottomSheet();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), topLeft: Radius.circular(25)),
      ),
    );
  }
}
