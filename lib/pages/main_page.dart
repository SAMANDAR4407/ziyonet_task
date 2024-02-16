import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ziyonet_task/bloc/main/main_bloc.dart';
import 'package:ziyonet_task/widgets/filter_bottomsheet.dart';
import 'package:ziyonet_task/widgets/main_item.dart';

import 'detail_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final levelController = TextEditingController();
  final typeController = TextEditingController();
  final catController = TextEditingController();
  final langController = TextEditingController();
  final descController = TextEditingController();
  final titleController = TextEditingController();

  final scrollController = ScrollController();

  List<DropdownMenuEntry> languages = [];
  List<DropdownMenuEntry> levels = [];
  List<DropdownMenuEntry> categories = [];
  List<DropdownMenuEntry> types = [];

  int page = 1;

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

  
  @override
  void initState() {
    BlocProvider.of<MainBloc>(context).add(LoadInfo());
    scrollController.addListener(() {
      final position = scrollController.offset;
      final maxExtent = scrollController.position.maxScrollExtent;
      if (position / maxExtent > 0.99) {
        if(page == BlocProvider.of<MainBloc>(context).totalPage) {
          return;
        } else {
          BlocProvider.of<MainBloc>(context).add(
              Filter(
                  category_id: categoryId(catController.text),
                  search_by_name: titleController.text,
                  search_by_desc: descController.text,
                  type_id: typeId(typeController.text),
                  level_id: levelId(levelController.text),
                  language_id: languageId(langController.text),
                  page: ++page,
                  newFilter: false
              )
          );
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff4a78c0),
        scrolledUnderElevation: 0,
        title: SizedBox(
          width: 120,
          child: SvgPicture.network(
            'https://library.ziyonet.uz/images/logo/logo-white-ru.svg',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Material(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0x40ffffff),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    showDragHandle: true,
                    useSafeArea: true,
                    context: context,
                    builder: (context) {
                      return FilterBottomSheet(
                        levelController: levelController,
                        typeController: typeController,
                        langController: langController,
                        catController: catController,
                        titleController: titleController,
                        descController: descController,
                        languages: languages,
                        levels: levels,
                        categories: categories,
                        types: types,
                      );
                    },
                  );
                },
                splashColor: const Color(0xab4a78c0),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.asset('assets/icons/filter.png', color: Colors.white),
                      const SizedBox(width: 12),
                      const Text('Filter', style: TextStyle(color: Colors.white, height: 0, fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {

          for (var lang in state.languages) {
            languages.add(DropdownMenuEntry(value: lang.id, label: lang.name));
          }
          for (var level in state.levels) {
            levels.add(DropdownMenuEntry(value: level.id, label: level.name));
          }
          for (var type in state.types) {
            types.add(DropdownMenuEntry(value: type.id, label: type.name));
          }
          for (var category in state.categories) {
            categories.add(DropdownMenuEntry(value: category.id, label: category.name));
          }

          if (state.status == EnumStatus.initial) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Image.network('https://www.pngall.com/wp-content/uploads/14/Welcome.png'),
              ),
            );
          }
          if(state.status == EnumStatus.fail){
            return Center(
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(state.message, style: const TextStyle(color: Colors.red)),
                ),
              )
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: state.materials.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  itemBuilder: (c, i) {
                    final model = state.materials[i];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => DetailPage(book_id: model.id!)));
                      },
                      child: MainItem(model: model),
                    );
                  },
                ),
              ),
              state.status == EnumStatus.loading
                ? const Padding(
                    padding: EdgeInsets.all(15),
                    child: CircularProgressIndicator(color: Color(0xff4a78c0))
                  )
                : const SizedBox()
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    levelController.dispose();
    typeController.dispose();
    catController.dispose();
    langController.dispose();
    descController.dispose();
    titleController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
