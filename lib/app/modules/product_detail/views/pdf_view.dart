import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../widgets/app_color.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class PdfView extends StatefulWidget {
  final String pdf;
  const PdfView({super.key, required this.pdf,});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {

  secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    secureScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        backgroundColor: AppColor.white50,
        title: Text("Pdf View", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SfPdfViewer.network(widget.pdf),
      // body: SfPdfViewer.asset('assets/pdf/agriculture_page.pdf'),
    );
  }
}
