import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bloc/main/main_bloc.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({
    super.key,
    required this.levelController,
    required this.typeController,
    required this.langController,
    required this.catController,
    required this.titleController,
    required this.descController,
    required this.languages,
    required this.levels,
    required this.categories,
    required this.types,
  });

  final List<DropdownMenuEntry> languages;
  final List<DropdownMenuEntry> levels;
  final List<DropdownMenuEntry> categories;
  final List<DropdownMenuEntry> types;

  final TextEditingController levelController;
  final TextEditingController typeController;
  final TextEditingController langController;
  final TextEditingController catController;
  final TextEditingController titleController;
  final TextEditingController descController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: TextField(
              controller: titleController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  hintText: 'Названия',
                  hintStyle: const TextStyle(fontWeight: FontWeight.w400)
              ),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: TextField(
              controller: descController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  hintText: 'Описание',
                  hintStyle: const TextStyle(fontWeight: FontWeight.w400)
              ),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: DropdownMenu(
              controller: levelController,
              width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width / 10,
              hintText: 'Уровень образования',
              dropdownMenuEntries: levels,
              menuStyle: const MenuStyle(surfaceTintColor: MaterialStatePropertyAll(Colors.white)),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: DropdownMenu(
              controller: typeController,
              width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width / 10,
              hintText: 'Тип',
              dropdownMenuEntries: types,
              menuStyle: const MenuStyle(surfaceTintColor: MaterialStatePropertyAll(Colors.white)),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: DropdownMenu(
              controller: catController,
              width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width / 10,
              hintText: 'Категория',
              dropdownMenuEntries: categories,
              menuStyle: const MenuStyle(surfaceTintColor: MaterialStatePropertyAll(Colors.white)),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: DropdownMenu(
              controller: langController,
              width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width / 10,
              hintText: 'Язык',
              dropdownMenuEntries: languages,
              menuStyle: const MenuStyle(surfaceTintColor: MaterialStatePropertyAll(Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: FilledButton(
              onPressed: () {
                try{
                  BlocProvider.of<MainBloc>(context).add(
                    Filter(
                        category_id: categoryId(catController.text),
                        search_by_name: titleController.text,
                        search_by_desc: descController.text,
                        type_id: typeId(typeController.text),
                        level_id: levelId(levelController.text),
                        language_id: languageId(langController.text),
                        page: null,
                        newFilter: true
                    ),
                  );
                }catch(e){
                  Fluttertoast.showToast(msg: 'Failed to load');
                }
                Navigator.pop(context);
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xff4a78c0)),
                fixedSize: MaterialStatePropertyAll(Size(300, 25)),
              ),
              child: const Text('Отправить'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  int? categoryId(String name){
    int? id;
    for (var value in categories) {
      if(value.label == name) id = value.value;
    }
    return id;
  }
  int? levelId(String name){
    int? id;
    for (var value in levels) {
      if(value.label == name) id = value.value;
    }
    return id;
  }
  int? languageId(String name){
    int? id;
    for (var value in languages) {
      if(value.label == name) id = value.value;
    }
    return id;
  }
  int? typeId(String name){
    int? id;
    for (var value in types) {
      if(value.label == name) id = value.value;
    }
    return id;
  }
}
