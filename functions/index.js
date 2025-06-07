const functions = require("firebase-functions");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");
const dayjs = require("dayjs");

admin.initializeApp();
const db = admin.firestore();

// Get Gmail credentials from Firebase environment config
const gmailEmail = functions.config().gmail.user;
const gmailPassword = functions.config().gmail.pass;

// Configure Gmail SMTP transporter
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: gmailEmail,
    pass: gmailPassword,
  },
});

exports.checkLicenseExpiry = functions.pubsub
  .schedule("every 24 hours")
  .onRun(async (context) => {
    const snapshot = await db.collection("licenses").get();
    const today = dayjs();

    for (const doc of snapshot.docs) {
      const data = doc.data();
      const expiry = dayjs(data.expiryDate.toDate());
      const diffDays = expiry.diff(today, "day");

      if ([30, 21, 7].includes(diffDays)) {
        const mailOptions = {
          from: `"License Notifier" <${gmailEmail}>`,
          to: data.email,
          subject: `📌 License Expiry - ${data.software}`,
          text: `The license for ${data.software} will expire in ${diffDays} days.`,
        };

        await transporter.sendMail(mailOptions);
        console.log(`📧 Email sent to ${data.email}`);
      }
    }

    return null;
  });
