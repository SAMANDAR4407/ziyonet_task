import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziyonet_task/bloc/detail/detail_bloc.dart';
import 'package:ziyonet_task/bloc/main/main_bloc.dart';
import 'package:ziyonet_task/widgets/detail_item.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.book_id});

  final int book_id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    BlocProvider.of<DetailBloc>(context).add(GetDetails(widget.book_id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            itemCount: state.books.length,
            itemBuilder: (c, i) {
              final model = state.books[i];
              return DetailItem(model: model);
            },
          );
        },
      )
    );
  }
}
