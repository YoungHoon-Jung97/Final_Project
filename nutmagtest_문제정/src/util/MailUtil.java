package util;

import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;


public class MailUtil {

    public static void sendEmail(String recipient, String tempPassword) {
        final String fromEmail = "msk7262@gmail.com"; 		// 본인 Gmail
        final String password = "grkd nmon dxft ddmu";     // 앱 비밀번호

        // 이메일 도메인 분리
        String domain = fromEmail.substring(fromEmail.indexOf("@") + 1).toLowerCase();
        
        // SMTP 설정값
        Properties props = new Properties();
        
        if (domain.equals("gmail.com")) {
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
		}  else {
            throw new RuntimeException("지원하지 않는 이메일 도메인입니다: " + domain);
        }
        
        // 인증 및 메일 전송
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(
                    Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject("[넛맥] 임시 비밀번호 안내");
            message.setText("안녕하세요.\n\n요청하신 임시 비밀번호는 아래와 같습니다.\n\n"
                    + tempPassword + "\n\n로그인 후 반드시 비밀번호를 변경해주세요.");

            Transport.send(message);
            System.out.println("✅ " + domain.toUpperCase() + " 메일 전송 성공!");
        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("❌ 메일 전송 실패!");
        }
    }
}
