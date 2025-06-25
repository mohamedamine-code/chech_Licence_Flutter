import 'package:check_license/models/license.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generatePdfReportAllLicense(List<dynamic> licenses) async {
  final pdf = pw.Document();

  const int licensesPerPage = 15;

  for (int i = 0; i < licenses.length; i += licensesPerPage) {
    final subList = licenses.sublist(
      i,
      (i + licensesPerPage > licenses.length)
          ? licenses.length
          : i + licensesPerPage,
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('License Report - Page ${(i ~/ licensesPerPage) + 1}',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              ...subList.map((license) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Name: ${license['name']}'),
                      pw.Text('Start Date: ${license['selectedDate']}'),
                      pw.Text('End Date: ${license['expiryDate']}'),
                      pw.Divider(),
                    ],
                  )),
            ],
          );
        },
      ),
    );
  }

  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );
}
