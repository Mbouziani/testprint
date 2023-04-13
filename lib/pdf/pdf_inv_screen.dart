import 'package:flutter/material.dart';
import 'package:manager_app/pdf/pdflogic.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class MyPdfInvScreen extends StatefulWidget {
  const MyPdfInvScreen({Key? key, required this.data}) : super(key: key);
  final String data;

  @override
  State<MyPdfInvScreen> createState() => _MyPdfInvScreenState();
}

class _MyPdfInvScreenState extends State<MyPdfInvScreen> {
  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    if (mounted) {
      super.setState(fn);
    }
  }

  PdfPageFormat _pdfPageFormat = PdfPageFormat.roll80;

  static const _defaultPageFormats = <String, PdfPageFormat>{
    'A4': PdfPageFormat.a4,
    'A5': PdfPageFormat.a5,
    'A6': PdfPageFormat.a6,
    'roll57': PdfPageFormat.roll57,
    'roll80': PdfPageFormat.roll80,
    'Letter': PdfPageFormat.letter,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: PdfPreview(
            pageFormats: _defaultPageFormats,
            initialPageFormat: _pdfPageFormat,
            canChangeOrientation: false,
            canDebug: false,
            onPageFormatChanged: (value) {
              _pdfPageFormat = value;
            },
            build: (format) => InvoicePdf().generatePdf(data: widget.data)),
      ),
    );
  }
}
