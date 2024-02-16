import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key, required this.url, required this.hasPdf, required this.path});

  final bool hasPdf;
  final String url;
  final String path;

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: widget.hasPdf
          ? SfPdfViewer.file(File(widget.path))
          : SfPdfViewer.network(widget.url),
      ),
    );
  }
}
