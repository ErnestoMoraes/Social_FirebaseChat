import 'package:flutter/material.dart';
import 'package:projeto_chat_firebase/app/components/list_tile_component.dart';

class DrawerComponent extends StatelessWidget {
  final void Function() onProfileTap;
  final void Function() onSignOutTap;

  const DrawerComponent({
    super.key,
    required this.onProfileTap,
    required this.onSignOutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              ListTileComponent(
                icon: Icons.home,
                text: 'H O M E',
                onTap: () => Navigator.pop(context),
              ),
              ListTileComponent(
                icon: Icons.person,
                text: 'P R O F I L E',
                onTap: onProfileTap,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: ListTileComponent(
              icon: Icons.logout_outlined,
              text: 'L O G O U T',
              onTap: onSignOutTap,
            ),
          ),
        ],
      ),
    );
  }
}
