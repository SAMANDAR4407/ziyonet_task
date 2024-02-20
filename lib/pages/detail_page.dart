import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziyonet_task/bloc/detail/detail_bloc.dart';
import 'package:ziyonet_task/bloc/main/main_bloc.dart';
import 'package:ziyonet_task/widgets/detail_item.dart';

import 'main_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.bookId});

  final int bookId;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    BlocProvider.of<DetailBloc>(context).add(GetDetails(widget.bookId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: const Color(0xff4a78c0),
        scrolledUnderElevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state.status == EnumStatus.loading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xff4a78c0)));
          }
          if (state.status == EnumStatus.fail) {
            return Center(
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(state.message, style: const TextStyle(color: Colors.red)),
                ),
              ),
            );
          }
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(12),
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemCount: 2,
            itemBuilder: (c, i) {
              final model = state.books[0];
              if (i == 0) {
                return DetailItem(model: model);
              } else {
                return SizedBox(
                  height: 1400,
                  child: Material(
                    color: Colors.white,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.antiAlias,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const Divider(height: 1, indent: 10, endIndent: 10),
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        final data = state.data[index];
                        return InkWell(
                          onTap: (){
                            final query = {'category_id' : data.id};
                            Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => MainPage(query: query)), (route) => false);
                          },
                          child: SizedBox(
                            height: 40,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text(data.name!, style: const TextStyle(fontWeight: FontWeight.w500))),
                                    Text(data.total!.toString(), style: const TextStyle(fontWeight: FontWeight.w500, color: CupertinoColors.systemBlue)),
                                    const SizedBox(width: 10),
                                    const Icon(Icons.keyboard_arrow_right_rounded)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
