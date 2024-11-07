import 'package:flutter/material.dart';
import 'package:pexel/data/menu_item.dart';

class MenuItems {

  static const List<MenuItem> menus = [
    gridView,
    listView
  ];

  static const gridView = MenuItem(
      text: "Grid View",
      icon: Icons.grid_on_outlined
  );

  static const listView = MenuItem(
      text: "List View",
      icon: Icons.view_list
  );
}