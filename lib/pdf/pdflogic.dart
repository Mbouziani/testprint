import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoicePdf {
  Future<Uint8List> generatePdf({required String data}) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.tajawalBold();

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(base: font),
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) => pw.Directionality(
          textDirection: pw.TextDirection.rtl,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(data, textAlign: pw.TextAlign.center),
              pw.SizedBox(height: 50),
              pw.Text(data,
                  style: pw.TextStyle(font: font, fontSize: 20),
                  textDirection: pw.TextDirection.rtl),
              pw.SizedBox(height: 50),
              pw.Text(
                  ' ا ب  ث  ح ج ت خ د ذ ر ز س ش ص ض ط ظ  غ ف ق ك ل م ن ه و ي ء ا',
                  textAlign: pw.TextAlign.center),
              pw.Text('ارقام', textAlign: pw.TextAlign.center),
              pw.Text('فاتورة', textAlign: pw.TextAlign.center),
              _pdfCongrate(isEn: false)
            ],
          ),
        ),
      ),
    );
    return await pdf.save();
  }

  pw.Widget _pdfCongrate({required bool isEn}) {
    return pw.Directionality(
        textDirection: pw.TextDirection.rtl,
        child: pw.Column(children: [
          pw.SizedBox(height: 15),
          pw.Text(isEn ? 'Thank You.' : 'سعداء بخدمتكم',
              textAlign: pw.TextAlign.center,
              style: const pw.TextStyle(fontSize: 10)),
        ]));
  }
}
