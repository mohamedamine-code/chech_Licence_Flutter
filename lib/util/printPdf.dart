import 'package:check_license/models/license.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// for all the license of list
Future<void> generatePdfReportAllLicense(List<dynamic> licenses) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('License Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            ...licenses.map((license) => pw.Column(
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

  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );
}


// for just one element of list 
Future<void> generatePdfReportSingleLicense(License license) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('License Report',
                style: pw.TextStyle(
                    fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Name: ${license.name}'),
            pw.Text('Start Date: ${license.StartDate.day}/${license.StartDate.month}/${license.StartDate.year}'),
            pw.Text('End Date: ${license.FinDate.day}/${license.FinDate.month}/${license.FinDate.year}'),
            pw.Text('State: ${license.State}'),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );
}



