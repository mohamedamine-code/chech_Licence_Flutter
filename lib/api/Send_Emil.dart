import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Mail {
  Future<void> sendMail(String name,DateTime finDate) async {
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
          ..subject = '🔔 License Expiration Notice '
          ..text =
              'This is to inform you that your license [${name}] has expired on [${DateFormat.yMMMd().format(finDate)}].Please take the necessary steps to renew your license to avoid any service interruptions.If you need assistance with the renewal process, feel free to contact our support team.Thank you for your prompt attention.';

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
