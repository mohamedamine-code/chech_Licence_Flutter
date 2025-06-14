import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Mail {
  Future<void> sendMail() async {
    final smtpServer = gmail(
      dotenv.env["GMAIL"]!,
      dotenv.env["GMAIL_PASSWORD"]!,
    );

    final message =
        Message()
          ..from = Address(dotenv.env["GMAIL"]!, 'Mohamed amine Ben Nsir')
          ..recipients.add(
            'mohamed.createur09@gmail.com',
          ) // test with a real address
          ..subject = 'Test Mail from Flutter :: ${DateTime.now()}'
          ..text = 'This is a plain text message from Flutter.';

    try {
      final sendReport = await send(message, smtpServer);
      print('✅ Message sent: $sendReport');
    } on MailerException catch (e) {
      print('❌ Message not sent.');
      for (var p in e.problems) {
        print('⚠️ Problem: ${p.code}: ${p.msg}');
      }
    } catch (e) {
      print('❗ Unexpected error: $e');
    }
  }
}
