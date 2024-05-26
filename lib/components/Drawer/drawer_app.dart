import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import '../DarkTheme/darktheme_provider_app.dart';

class DrawerComponent extends StatefulWidget {
  const DrawerComponent({super.key});

  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Drawer(
            child: Container(
              color: notifier.isDark
                  ? AppTheme.secondaryColor
                  : AppTheme.primaryColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        GFAvatar(
                          backgroundColor: notifier.isDark
                              ? AppTheme.secondaryColor
                              : AppTheme.primaryColor,
                          radius: 80.0,
                          backgroundImage: AssetImage(
                            "assets/gasoline.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    trailing: Switch(
                      activeColor: Colors.black,
                      inactiveTrackColor: Colors.white,
                      value: notifier.isDark,
                      onChanged: (value) => notifier.changeTheme(),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
