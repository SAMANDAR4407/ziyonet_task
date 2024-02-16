import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ziyonet_task/models/filtered_response.dart';
import 'package:ziyonet_task/pages/pdf_page.dart';

class MainItem extends StatefulWidget {
  const MainItem({super.key, required this.model});

  final MaterialBook model;

  @override
  State<MainItem> createState() => _MainItemState();
}

class _MainItemState extends State<MainItem> {

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

  bool likePressed = false;
  bool dislikePressed = false;

  bool star1 = false;
  bool star2 = false;
  bool star3 = false;
  bool star4 = false;
  bool star5 = false;

  @override
  void initState() {
    checkPdf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0x334a78c0),
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 200,
                  child: Image.network(widget.model.cover!, fit: BoxFit.cover),
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
                          ?const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                          )
                          :const Icon(
                            Icons.file_download_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) =>
                            PdfPage(url: widget.model.file!, hasPdf: hasPdf, path: path)));
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: const Text('Уровень:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17))),
                Expanded(child: Text(widget.model.level!, style: const TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis))),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: const Text('Тип:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17))),
                Expanded(child: Text(widget.model.type!, style: const TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis))),
              ],
            ),
            Row(
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: const Text('Год издания:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17))),
                Expanded(child: Text(widget.model.publishedAt!, style: const TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis))),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: const Text('Дата создания:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17))),
                Expanded(child: Text(widget.model.createdAt!, style: const TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis))),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      likePressed = !likePressed;
                      if (dislikePressed) {
                        dislikePressed = false;
                      }
                    });
                  },
                  child: Icon(
                    likePressed ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                    size: 40,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      dislikePressed = !dislikePressed;
                      if (likePressed) {
                        likePressed = false;
                      }
                    });
                  },
                  child: Icon(dislikePressed ? Icons.thumb_down : Icons.thumb_down_alt_outlined, size: 40, color: Colors.blueAccent),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    star1 = !star1;
                    star2 = false;
                    star3 = false;
                    star4 = false;
                    star5 = false;
                    setState(() {});
                  },
                  child: Icon(
                    CupertinoIcons.star_fill,
                    color: star1 ? Colors.orange : CupertinoColors.systemGrey2,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    star1 = true;
                    star2 = true;
                    if (star3 || star4 || star5) {
                      star3 = false;
                      star4 = false;
                      star5 = false;
                    }
                    setState(() {});
                  },
                  child: Icon(
                    CupertinoIcons.star_fill,
                    color: star2 ? Colors.orange : CupertinoColors.systemGrey2,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    star1 = true;
                    star2 = true;
                    star3 = true;
                    if (star4 || star5) {
                      star4 = false;
                      star5 = false;
                    }
                    setState(() {});
                  },
                  child: Icon(
                    CupertinoIcons.star_fill,
                    color: star3 ? Colors.orange : CupertinoColors.systemGrey2,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    star1 = true;
                    star2 = true;
                    star3 = true;
                    star4 = true;
                    if (star5) {
                      star5 = false;
                    }
                    setState(() {});
                  },
                  child: Icon(
                    CupertinoIcons.star_fill,
                    color: star4 ? Colors.orange : CupertinoColors.systemGrey2,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    star1 = true;
                    star2 = true;
                    star3 = true;
                    star4 = true;
                    star5 = true;
                    setState(() {});
                  },
                  child: Icon(
                    CupertinoIcons.star_fill,
                    color: star5 ? Colors.orange : CupertinoColors.systemGrey2,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: const BoxDecoration(color: Colors.deepOrange, shape: BoxShape.circle),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('0', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
