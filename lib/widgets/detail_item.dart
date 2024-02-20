import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

import '../models/book_detail_response.dart';
import '../pages/pdf_page.dart';

class DetailItem extends StatefulWidget {
  const DetailItem({super.key, required this.model});

  final Book model;

  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {

  var path = "";
  var hasPdf = false;

  Future<void> checkPdf() async {
    final dir = await getApplicationDocumentsDirectory();
    path = "${dir.path}/${widget.model.title}";
    final file = File(path);
    hasPdf = await file.exists();
    setState(() {});
  }

  Future<void> onDownload() async {
    if (hasPdf) {
      return;
    }
    Fluttertoast.showToast(msg: 'File downloading');
    await Dio().download(
      widget.model.file!,
      path,
      onReceiveProgress: (count, total) {
        setState(() {});
      },
    );
    hasPdf = true;
    setState(() {});
  }

  @override
  void initState() {
    checkPdf();
    super.initState();
  }

  bool likePressed = false;
  bool dislikePressed = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: CupertinoColors.systemGrey5,
      surfaceTintColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Column(
            children: [
              Material(
                color: Colors.white,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    widget.model.title!,
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: CachedNetworkImage(
                  imageUrl: widget.model.cover!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Image.asset('assets/images/placeholder.png'),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onDownload,
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff017e72),
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: hasPdf
                            ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                        )
                            : const Icon(
                          Icons.file_download_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, CupertinoPageRoute(builder: (context) => PdfPage(url: widget.model.file!, hasPdf: hasPdf, path: path)));
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff017e72),
                      clipBehavior: Clip.antiAlias,
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(30),
                            child: Center(
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Чтобы пожаловаться необходимо авторизоваться'),
                                      const SizedBox(height: 10),
                                      FilledButton(
                                        onPressed: () {},
                                        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0x334a78c0))),
                                        child: const Text('Войти', style: TextStyle(color: Colors.blue)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffff8900),
                      clipBehavior: Clip.antiAlias,
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: const Text('Уровень:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17))),
                Expanded(child: Text(widget.model.level!, maxLines: 3, style: const TextStyle(fontSize: 17))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: const Text('Тип:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17))),
                Expanded(child: Text(widget.model.type!, style: const TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: const Text('Автор:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17))),
                Expanded(
                  child: Text(
                    widget.model.author!,
                    style: const TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis),
                    maxLines: 10,
                  ),
                ),
              ],
            ),
          ),
          widget.model.publishedAt!.isNotEmpty ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: const Text('Год издания:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17))),
                Expanded(child: Text(widget.model.publishedAt!, style: const TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis))),
              ],
            ),
          ) : const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: const Text('Номер УДК:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17))),
                Expanded(child: Text(widget.model.udk!, style: const TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: const Text('Дата создания:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17))),
                Expanded(child: Text(widget.model.createdAt!, style: const TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis))),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(30),
                        child: Center(
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Чтобы проголосовать необходимо авторизоваться'),
                                  const SizedBox(height: 10),
                                  FilledButton(
                                    onPressed: () {},
                                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0x334a78c0))),
                                    child: const Text('Войти', style: TextStyle(color: Colors.blue)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.thumb_up_alt_outlined,
                  size: 40,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(30),
                        child: Center(
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Чтобы проголосовать необходимо авторизоваться'),
                                  const SizedBox(height: 10),
                                  FilledButton(
                                    onPressed: () {},
                                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0x334a78c0))),
                                    child: const Text('Войти', style: TextStyle(color: Colors.blue)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.thumb_down_alt_outlined, size: 40, color: Colors.blueAccent),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width*0.45,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (__, _) => const SizedBox(width: 10),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Icon(
                        CupertinoIcons.star_fill,
                        color: widget.model.rating! >= index && widget.model.rating != 0 ? Colors.orange : CupertinoColors.systemGrey2,
                      );
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.deepOrange, shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(widget.model.rating.toString(), style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              widget.model.description!,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
