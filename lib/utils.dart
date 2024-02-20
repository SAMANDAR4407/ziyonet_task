import 'package:flutter/material.dart';


int? categoryId(String name, List<DropdownMenuEntry> list) {
  int? id;
  for (var value in list) {
    if (value.label == name) id = value.value;
  }
  return id;
}

int? levelId(String name, List<DropdownMenuEntry> list) {
  int? id;
  for (var value in list) {
    if (value.label == name) id = value.value;
  }
  return id;
}

int? languageId(String name, List<DropdownMenuEntry> list) {
  int? id;
  for (var value in list) {
    if (value.label == name) id = value.value;
  }
  return id;
}

int? typeId(String name, List<DropdownMenuEntry> list) {
  int? id;
  for (var value in list) {
    if (value.label == name) id = value.value;
  }
  return id;
}
