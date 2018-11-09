-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 09, 2018 at 05:42 PM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `code_review_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `code`
--

CREATE TABLE `code` (
  `code_id` int(10) NOT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `code_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) NOT NULL,
  `push_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `number_of_lines` int(11) NOT NULL,
  `user_story_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `code`
--

INSERT INTO `code` (`code_id`, `version`, `code_text`, `user_id`, `push_date`, `number_of_lines`, `user_story_id`, `comment`, `status`) VALUES
(1, 1, 'public class stringexample\n{	public static void main(String[] args)\n	{	String s1 = \"Computer Science\";\n		int x = 307;\n		String s2 = s1 + \" \" + x;\n		String s3 = s2.substring(10,17);\n		String s4 = \"is fun\";\n		String s5 = s2 + s4;\n		\n		System.out.println(\"s1: \" + s1);\n		System.out.println(\"s2: \" + s2);\n		System.out.println(\"s3: \" + s3);\n		System.out.println(\"s4: \" + s4);\n		System.out.println(\"s5: \" + s5);\n		\n		//showing effect of precedence\n		\n		x = 3;\n		int y = 5;\n		String s6 = x + y + \"total\";\n		String s7 = \"total \" + x + y;\n		String s8 = \" \" + x + y + \"total\";\n		System.out.println(\"s6: \" + s6);\n		System.out.println(\"s7: \" + s7);\n		System.out.println(\"s8: \" + s8);\n	}\n}', 2, '2018-10-08 08:20:10', 27, 'R1', '', 2),
(2, 1, 'public class SwitchCaseExample1 {\r\n\r\n   public static void main(String args[]){\r\n     int num=2;\r\n     switch(num+2)\r\n     {\r\n        case 1:\r\n	  System.out.println(\"Case1: Value is: \"+num);\r\n	case 2:\r\n	  System.out.println(\"Case2: Value is: \"+num);\r\n	case 3:\r\n	  System.out.println(\"Case3: Value is: \"+num);\r\n        default:\r\n	  System.out.println(\"Default: Value is: \"+num);\r\n      }\r\n   }\r\n}', 4, '2018-10-09 10:30:20', 17, 'R2', '', 2),
(4, 1, '    @Override\r\n    /*\r\n    create a new account.\r\n    new account number is generated using automatic increment in mysql.\r\n    By default upon creation, \r\n    - balance = 0\r\n    - status = active(100)    \r\n    \r\n    before creating an account, following verifications are made :\r\n    - the customer should exist.\r\n    \r\n    */\r\n    public int createAccount(AccountDTO account) {\r\n        CustomerDAO customerDAO = new CustomerDAOImpl();\r\n         int accountNumber = -1;\r\n        if(customerDAO.getCustomerById(account.getCustomer().getCustomerId()) != null){// checking if customer exists.\r\n            Connection con = ConnectionFactory.getConnection();\r\n            String query = \"INSERT INTO Account(CUSTOMER_ID,\"\r\n                        + \"ACCOUNT_TYPE,STATUS,BALANCE) \"\r\n                        + \"VALUES (?,?,?,?)\";\r\n           \r\n            System.out.println(\"type:\" +account.getAccountType().getCode());\r\n            try {\r\n                PreparedStatement ps = con.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);\r\n                ps.setInt(1, account.getCustomer().getCustomerId());\r\n                ps.setInt(2, account.getAccountType().getCode());\r\n                ps.setInt(3, 100); //upon creationg the account is active by default.\r\n                ps.setFloat(4, 0.00f); //initial balance = 0 by default\r\n  \r\n                ps.executeUpdate();\r\n                ResultSet rs = ps.getGeneratedKeys();\r\n                if (rs.next()) {\r\n                    accountNumber=rs.getInt(1);   \r\n                }\r\n                ps.close();\r\n                rs.close();\r\n                con.close();\r\n            }catch (SQLException ex) {\r\n                ex.printStackTrace();\r\n            }\r\n            \r\n        }\r\n        else{\r\n            throw new UserException(ErrorMessage.CUSTOMER_NOT_FOUND,ErrorMessage.CUSTOMER_NOT_FOUND_DESC);\r\n        }\r\n        return accountNumber;\r\n    }\r\n    /*\r\n    Searches for the accounts belonging to a particular customer using select\r\n    A list is return as one customer can have multile accounts.\r\n    */\r\n    @Override\r\n    public ArrayList<AccountDTO> getAccountByCustomerId(int customerId) {\r\n        ArrayList<AccountDTO> accountList = new ArrayList<AccountDTO>();\r\n        \r\n        Connection con = ConnectionFactory.getConnection();\r\n        String query = \"SELECT * FROM ACCOUNT A,\"\r\n                + \"CUSTOMER C,\"\r\n                + \"ACCOUNT_STATUS ST,\"\r\n                + \"ACCOUNT_TYPE TP \"\r\n                + \"WHERE A.CUSTOMER_ID=C.CUSTOMER_ID \"\r\n                + \"AND A.STATUS = ST.STATUS_CODE \"\r\n                + \"AND A.ACCOUNT_TYPE = TP.TYPE_CODE \"\r\n                + \"AND A.CUSTOMER_ID=?\";\r\n        \r\n        System.out.println(query);\r\n        \r\n        try {\r\n                PreparedStatement ps = con.prepareStatement(query);\r\n                ps.setInt(1,customerId);\r\n                ResultSet rs = ps.executeQuery();\r\n                while (rs.next()) {\r\n                    //Reading the resultset to create a new AccountDTO and set the variables\r\n                    accountList.add(buildAccountfromResult(rs));\r\n                }\r\n                ps.close();\r\n                rs.close();\r\n                con.close();\r\n            }catch (SQLException ex) {\r\n                ex.printStackTrace();\r\n                throw new UserException(ErrorMessage.DATABASE_ERROR,ErrorMessage.DATABASE_ERROR_DESC);\r\n            }\r\n        \r\n        return accountList;\r\n    }\r\n    ', 5, '2018-10-13 22:48:06', 50, 'R2', 'get account list code', 2),
(5, 1, '   public ArrayList<CodeDTO> getUnreadCodes() {\r\n        \r\n        RestTemplate restTemplate = new RestTemplate();\r\n     \r\n        ArrayList<CodeDTO> codeList = new ArrayList<CodeDTO>();\r\n        final ResponseEntity<CodeDTO[]> responseEntity\r\n                = restTemplate.getForEntity(\"http://localhost:9000/CodeReviewer/codes/unreviewed\", CodeDTO[].class);\r\n       \r\n        \r\n        for (CodeDTO code : responseEntity.getBody()) {\r\n            codeList.add(code);\r\n        }\r\n\r\n\r\n        return codeList;\r\n    }\r\n', 4, '2018-10-17 17:48:15', 30, 'R2', 'Retrieving Code List', 2),
(6, 1, 'private void testmethod(RestTemplate restTemplate) {\n     \n\n        final ResponseEntity<Integer> responseEntity\n                = restTemplate.getForEntity(\"http://localhost:9000/CodeReviewer/pushCode\", Integer.class);\n\n        System.out.println(responseEntity.getBody());\n    }', 3, '2018-10-17 17:48:45', 0, 'R1', 'Sending mail', 2),
(7, 1, 'private void testmethod(RestTemplate restTemplate) {\r\n     \r\n\r\n        final ResponseEntity<Integer> responseEntity\r\n                = restTemplate.getForEntity(\"http://localhost:9000/CodeReviewer/pushCode\", Integer.class);\r\n\r\n        System.out.println(responseEntity.getBody());\r\n    }', 3, '2018-10-17 17:49:19', 34, 'R1', 'Sending mail', 2),
(8, 1, ' @Override\r\n    public CodeDTO getCodeById(int codeId) {\r\n        CodeDTO code = null;\r\n         Connection con = ConnectionFactory.getConnection();\r\n        String query = \"SELECT c.code_id, c.comment, c.codeText, c.push_date, c.user_id, \"\r\n                        + \"c.user_story_id, u.first_name, u.last_name, us.title\"\r\n                        + \"FROM code c, user u , user_story us \" +\r\n                        \"where code_id = \"+codeId;\r\n           try {\r\n                PreparedStatement ps = con.prepareStatement(query);\r\n                ResultSet rs = ps.executeQuery();\r\n                while (rs.next()) {\r\n                    code = buildCodeDTOfromResult(rs);\r\n                }\r\n                ps.close();\r\n                rs.close();\r\n                con.close();\r\n            }catch (SQLException ex) {\r\n                \r\n            }\r\n        \r\n        return code;\r\n    }', 6, '2018-10-21 00:13:10', 75, 'R2', 'Creation of review', 2),
(9, 1, '  public static String convertDatetoString(Date date, String format){\n           System.out.println(date);\n\n        SimpleDateFormat sdf = new SimpleDateFormat(format);\n        String jsonDate = sdf.format(date);\n        \n        return jsonDate;\n \n } ', 3, '2018-10-24 00:00:00', 9, 'R2', 'Method to convert Date to String', 2),
(10, 1, '  public static String convertDatetoString(Date date, String format){\n           System.out.println(date);\n\n        SimpleDateFormat sdf = new SimpleDateFormat(format);\n        String jsonDate = sdf.format(date);\n        \n        return jsonDate;\n \n } ', 3, '2018-10-24 00:37:18', 9, 'R2', 'Method to convert Date to String', 2),
(11, 1, ' public static String dateDiff(Date start, Date end){\n       \n\n        int minutes =0;\n        int hours = 0;\n        int days = 0;\n        \n        long diff = end.getTime() - start.getTime(); \n	days = (int) (diff / (24 * 60 * 60 * 1000));\n        \n        Calendar calendar_start = Calendar.getInstance();\n        Calendar calendar_end = Calendar.getInstance();\n        calendar_start.setTime(start);\n        calendar_end.setTime(end);\n       \n        \n        if(calendar_start.get(Calendar.HOUR_OF_DAY) > calendar_end.get(Calendar.HOUR_OF_DAY)){\n            hours = 24-calendar_start.get(Calendar.HOUR_OF_DAY) + calendar_end.get(Calendar.HOUR_OF_DAY);\n\n        }\n        else{\n            hours = calendar_end.get(Calendar.HOUR_OF_DAY) - calendar_start.get(Calendar.HOUR_OF_DAY);\n        }\n        \n        if(calendar_start.get(Calendar.MINUTE) > calendar_end.get(Calendar.MINUTE)){\n            minutes = 60 -calendar_start.get(Calendar.MINUTE) + calendar_end.get(Calendar.MINUTE);\n\n        }\n        else{\n            minutes = calendar_end.get(Calendar.MINUTE) - calendar_start.get(Calendar.MINUTE);\n        }\n       \n\n        \n        return days + \" days \"+ hours + \" Hrs \"+ minutes + \" mins ago.\";\n        \n    }\n    ', 3, '2018-10-24 00:38:26', 38, 'R2', 'Method to get the date difference', 2),
(12, 1, '    public static String convertDatetoString(Date date, String format){\n           System.out.println(date);\n\n        SimpleDateFormat sdf = new SimpleDateFormat(format);\n        String jsonDate = sdf.format(date);\n        \n        return jsonDate;\n \n }       ', 6, '2018-10-24 00:50:59', 9, 'R1', 'Method to convert date to string', 2),
(13, 1, '    public static String convertDatetoString(Date date, String format){\n           System.out.println(date);\n\n        SimpleDateFormat sdf = new SimpleDateFormat(format);\n        String jsonDate = sdf.format(date);\n        \n        return jsonDate;\n \n }       ', 6, '2018-10-24 00:53:59', 9, 'R1', 'Method to convert date to string', 2),
(14, 1, '    public static String convertDatetoString(Date date, String format){\n           System.out.println(date);\n\n        SimpleDateFormat sdf = new SimpleDateFormat(format);\n        String jsonDate = sdf.format(date);\n        \n        return jsonDate;\n \n }       ', 6, '2018-10-24 00:55:20', 9, 'R1', 'Method to convert date to string', 2),
(15, 1, '   public static String dateDiff(Date start, Date end){\n       \n\n        int minutes =0;\n        int hours = 0;\n        int days = 0;\n        \n        long diff = end.getTime() - start.getTime(); \n	days = (int) (diff / (24 * 60 * 60 * 1000));\n        \n        Calendar calendar_start = Calendar.getInstance();\n        Calendar calendar_end = Calendar.getInstance();\n        calendar_start.setTime(start);\n        calendar_end.setTime(end);\n       \n        \n        if(calendar_start.get(Calendar.HOUR_OF_DAY) > calendar_end.get(Calendar.HOUR_OF_DAY)){\n            hours = 24-calendar_start.get(Calendar.HOUR_OF_DAY) + calendar_end.get(Calendar.HOUR_OF_DAY);\n\n        }\n        else{\n            hours = calendar_end.get(Calendar.HOUR_OF_DAY) - calendar_start.get(Calendar.HOUR_OF_DAY);\n        }\n        \n        if(calendar_start.get(Calendar.MINUTE) > calendar_end.get(Calendar.MINUTE)){\n            minutes = 60 -calendar_start.get(Calendar.MINUTE) + calendar_end.get(Calendar.MINUTE);\n\n        }\n        else{\n            minutes = calendar_end.get(Calendar.MINUTE) - calendar_start.get(Calendar.MINUTE);\n        }\n       \n\n        \n        return days + \" days \"+ hours + \" Hrs \"+ minutes + \" mins ago.\";\n        \n    }\n    ', 4, '2018-10-24 00:58:48', 38, 'R1', 'Get the duration ', 2),
(16, 1, '   public static String dateDiff(Date start, Date end){\n       \n\n        int minutes =0;\n        int hours = 0;\n        int days = 0;\n        \n        long diff = end.getTime() - start.getTime(); \n	days = (int) (diff / (24 * 60 * 60 * 1000));\n        \n        Calendar calendar_start = Calendar.getInstance();\n        Calendar calendar_end = Calendar.getInstance();\n        calendar_start.setTime(start);\n        calendar_end.setTime(end);\n       \n        \n        if(calendar_start.get(Calendar.HOUR_OF_DAY) > calendar_end.get(Calendar.HOUR_OF_DAY)){\n            hours = 24-calendar_start.get(Calendar.HOUR_OF_DAY) + calendar_end.get(Calendar.HOUR_OF_DAY);\n\n        }\n        else{\n            hours = calendar_end.get(Calendar.HOUR_OF_DAY) - calendar_start.get(Calendar.HOUR_OF_DAY);\n        }\n        \n        if(calendar_start.get(Calendar.MINUTE) > calendar_end.get(Calendar.MINUTE)){\n            minutes = 60 -calendar_start.get(Calendar.MINUTE) + calendar_end.get(Calendar.MINUTE);\n\n        }\n        else{\n            minutes = calendar_end.get(Calendar.MINUTE) - calendar_start.get(Calendar.MINUTE);\n        }\n       \n\n        \n        return days + \" days \"+ hours + \" Hrs \"+ minutes + \" mins ago.\";\n        \n    }\n    ', 2, '2018-10-24 01:20:45', 38, 'R1', 'Getting Duration', 2),
(17, 1, '    public static String convertDatetoString(Date date, String format){\n           System.out.println(date);\n\n        SimpleDateFormat sdf = new SimpleDateFormat(format);\n        String jsonDate = sdf.format(date);\n        \n        return jsonDate;\n \n }  ', 3, '2018-10-24 08:37:35', 9, 'R1', 'New Code Commit', 2),
(18, 2, '    public static String convertDatetoString(Date date, String format){\n           System.out.println(date);\n\n        SimpleDateFormat sdf = new SimpleDateFormat(format);\n        String jsonDate = sdf.format(date);\n        \n        return jsonDate;\n \n }  ', 2, '2018-10-24 08:54:39', 9, 'R2', '', 2),
(19, 1, '  public ArrayList<UserstoryDTO> getUserStories(int projectId) {\n\n        RestTemplate restTemplate = new RestTemplate();\n        final ResponseEntity<UserstoryDTO[]> responseEntity\n                = restTemplate.getForEntity(\"http://localhost:9000/CodeReviewer/userStories/\" + projectId, UserstoryDTO[].class);\n\n        ArrayList<UserstoryDTO> userStoryList = new ArrayList<>();\n        userStoryList.addAll(Arrays.asList(responseEntity.getBody()));\n\n        return userStoryList;\n    }', 5, '2018-10-27 23:51:57', 11, 'R2', 'Get the list of user stories', 2),
(20, 1, 'testcode', 3, '2018-10-29 12:49:00', 1, 'R2', 'testcomment', 2),
(21, 1, ' private void AddButtonClicked(java.awt.event.MouseEvent evt) {                                  \n        // TODO add your handling code here:\n         ReviewAnnotationDTO annotationDTO = new ReviewAnnotationDTO();\n        annotationDTO.setAnnotText(taAnnotation.getText());\n        annotationDTO.setRuleDTO(rulesList.get(cbRules.getSelectedIndex()));\n        annotationDTO.setLineNumber(Integer.parseInt(tfCodeLine.getText()));\n        annotationsList.add(annotationDTO);\n\n        taAllAnnotations.setText(taAllAnnotations.getText() + \"\\n\" + createAnnotationDesc(annotationDTO));\n    }                                 \n\n    private void btnRejectActionPerformed(java.awt.event.ActionEvent evt) {                                          \n        System.out.println(\"clicked\");\n        if (this.annotationsList.size() > 0) {\n//            review.put(\"codeId\", this.codeId);\n//            review.put(\"reviewerId\",Session.currentUser.getUserId());\n//            review.put(\"approved\", approved);\n//            review.put(\"startTime\", Utils.convertDatetoString(this.startDate,\"yyyy-M-dd hh:mm:ss\"));\n//            review.put(\"submitTime\", Utils.convertDatetoString(this.endDate,\"yyyy-M-dd hh:mm:ss\"));\n            endDate = new Date();\n            ReviewDTO reviewDTO = new ReviewDTO();\n            reviewDTO.setCodeId(this.codeId);\n            reviewDTO.setReviewerId(Session.currentUser.getUserId());\n            reviewDTO.setApproved(0);\n            reviewDTO.setStartTime(Utils.convertDatetoString(this.startDate,\"yyyy-M-dd hh:mm:ss\"));\n            reviewDTO.setSubmitTime(Utils.convertDatetoString(this.endDate,\"yyyy-M-dd hh:mm:ss\"));\n//            int review_id = service.addReview(createReviewJSON(0).toString());\n            reviewDTO.setAnnotationList(this.annotationsList);\n            int review_id = service.addReview(reviewDTO);\n            verifyReviewRequestIsSuccessful(review_id);\n        } else {\n            JOptionPane.showMessageDialog(this,\"Cannot reject without annotating the code\", \"Error\", JOptionPane.ERROR_MESSAGE);\n        }\n    }                                         \n\n    \n\n    private static String createAnnotationDesc(ReviewAnnotationDTO annotation) {\n        return \"Line: \" + annotation.getLineNumber() + \" - Rule: \" + annotation.getRuleDTO().getRuleid() +  \": \" + annotation.getAnnotText();\n    }\n\n    /**\n     * @param args the command line arguments\n     */\n\n    // Variables declaration - do not modify                     \n    private javax.swing.JButton btnReject;\n    private javax.swing.JComboBox<String> cbRules;\n    private javax.swing.JButton jButton_ConfirmApproved;\n    private javax.swing.JLabel jLabel1;\n    private javax.swing.JLabel jLabel10;\n    private javax.swing.JLabel jLabel11;\n    private javax.swing.JLabel jLabel2;\n    private javax.swing.JLabel jLabel3;\n    private javax.swing.JLabel jLabel4;\n    private javax.swing.JLabel jLabel5;\n    private javax.swing.JLabel jLabel6;\n    private javax.swing.JLabel jLabel7;\n    private javax.swing.JLabel jLabel8;\n    private javax.swing.JLabel jLabel9;\n    private javax.swing.JPanel jPanel1;\n    private javax.swing.JPanel jPanel2;\n    private javax.swing.JPanel jPanel3;\n    private javax.swing.JPanel jPanel4;\n    private javax.swing.JScrollPane jScrollPane1;\n    private javax.swing.JScrollPane jScrollPane2;\n    private javax.swing.JScrollPane jScrollPane4;\n    private javax.swing.JTextArea taAllAnnotations;\n    private javax.swing.JTextArea taAnnotation;\n    private javax.swing.JTextArea textArea_ShowCode;\n    private java.awt.TextField tfCodeLine;', 5, '2018-11-09 11:00:57', 71, 'R2', 'Greedy Me', 2),
(22, 1, 'public static void main(String args[]) {\n        /* Set the Nimbus look and feel */\n        //<editor-fold defaultstate=\"collapsed\" desc=\" Look and feel setting code (optional) \">\n        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.\n         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html \n         */\n        try {\n            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {\n                if (\"Nimbus\".equals(info.getName())) {\n                    javax.swing.UIManager.setLookAndFeel(info.getClassName());\n                    break;\n                }\n            }\n        } catch (ClassNotFoundException ex) {\n            java.util.logging.Logger.getLogger(FrameReview.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);\n        } catch (InstantiationException ex) {\n            java.util.logging.Logger.getLogger(FrameReview.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);\n        } catch (IllegalAccessException ex) {\n            java.util.logging.Logger.getLogger(FrameReview.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);\n        } catch (javax.swing.UnsupportedLookAndFeelException ex) {\n            java.util.logging.Logger.getLogger(FrameReview.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);\n        }\n        //</editor-fold>\n\n        /* Create and display the form */\n        java.awt.EventQueue.invokeLater(new Runnable() {\n            public void run() {\n                new FrameReview(1).setVisible(true);\n            }\n        });\n    \n    }                                                       \n\n    private void BackClicked(java.awt.event.MouseEvent evt) {                             \n        // TODO add your handling code here:\n          this.setVisible(false);\n        new FrameUnreadCodes().setVisible(true);\n    }                            \n\n    private void AddButtonClicked(java.awt.event.MouseEvent evt) {                                  \n        // TODO add your handling code here:\n         ReviewAnnotationDTO annotationDTO = new ReviewAnnotationDTO();\n        annotationDTO.setAnnotText(taAnnotation.getText());\n        annotationDTO.setRuleDTO(rulesList.get(cbRules.getSelectedIndex()));\n        annotationDTO.setLineNumber(Integer.parseInt(tfCodeLine.getText()));\n        annotationsList.add(annotationDTO);\n\n        taAllAnnotations.setText(taAllAnnotations.getText() + \"\\n\" + createAnnotationDesc(annotationDTO));\n    }                                 \n\n    private void btnRejectActionPerformed(java.awt.event.ActionEvent evt) {                                          \n        System.out.println(\"clicked\");\n        if (this.annotationsList.size() > 0) {\n//            review.put(\"codeId\", this.codeId);\n//            review.put(\"reviewerId\",Session.currentUser.getUserId());\n//            review.put(\"approved\", approved);\n//            review.put(\"startTime\", Utils.convertDatetoString(this.startDate,\"yyyy-M-dd hh:mm:ss\"));\n//            review.put(\"submitTime\", Utils.convertDatetoString(this.endDate,\"yyyy-M-dd hh:mm:ss\"));\n            endDate = new Date();\n            ReviewDTO reviewDTO = new ReviewDTO();\n            reviewDTO.setCodeId(this.codeId);\n            reviewDTO.setReviewerId(Session.currentUser.getUserId());\n            reviewDTO.setApproved(0);\n            reviewDTO.setStartTime(Utils.convertDatetoString(this.startDate,\"yyyy-M-dd hh:mm:ss\"));\n            reviewDTO.setSubmitTime(Utils.convertDatetoString(this.endDate,\"yyyy-M-dd hh:mm:ss\"));\n//            int review_id = service.addReview(createReviewJSON(0).toString());\n            reviewDTO.setAnnotationList(this.annotationsList);\n            int review_id = service.addReview(reviewDTO);\n            verifyReviewRequestIsSuccessful(review_id);\n        } else {\n            JOptionPane.showMessageDialog(this,\"Cannot reject without annotating the code\", \"Error\", JOptionPane.ERROR_MESSAGE);\n        }\n    }                                         \n\n    \n\n    private static String createAnnotationDesc(ReviewAnnotationDTO annotation) {\n        return \"Line: \" + annotation.getLineNumber() + \" - Rule: \" + annotation.getRuleDTO().getRuleid() +  \": \" + annotation.getAnnotText();\n    }', 4, '2018-11-07 15:49:49', 79, 'R1', 'UI behaviour modification', 2),
(23, 1, 'private void btnAddAnnotationActionPerformed(java.awt.event.ActionEvent evt) {                                                 \n\n        ReviewAnnotationDTO annotationDTO = new ReviewAnnotationDTO();\n        annotationDTO.setAnnotText(taAnnotation.getText());\n        annotationDTO.setRuleDTO(rulesList.get(cbRules.getSelectedIndex()));\n        annotationDTO.setLineNumber(Integer.parseInt(tfCodeLine.getText()));\n        annotationsList.add(annotationDTO);\n\n        taAllAnnotations.setText(taAllAnnotations.getText() + \"\\n\" + createAnnotationDesc(annotationDTO));\n    }                                                \n\n\n    private void jButton_ConfirmApprovedActionPerformed(java.awt.event.ActionEvent evt) {                                                        \n//        int review_id = service.addReview(createReviewJSON(1).toString());\n        endDate = new Date();\n        ReviewDTO reviewDTO = new ReviewDTO();\n        reviewDTO.setCodeId(this.codeId);\n        reviewDTO.setReviewerId(Session.currentUser.getUserId());\n        reviewDTO.setApproved(1);\n        reviewDTO.setStartTime(Utils.convertDatetoString(this.startDate,\"yyyy-M-dd hh:mm:ss\"));\n        reviewDTO.setSubmitTime(Utils.convertDatetoString(this.endDate,\"yyyy-M-dd hh:mm:ss\"));\n//            int review_id = service.addReview(createReviewJSON(0).toString());\n        reviewDTO.setAnnotationList(this.annotationsList);\n        int review_id = service.addReview(reviewDTO);\n        verifyReviewRequestIsSuccessful(review_id);\n    }\n\n    private void verifyReviewRequestIsSuccessful(int review_id) {\n        if(review_id != -1){\n            JOptionPane.showMessageDialog(this,\"File has been successfully reviewed. Review_id : \"+ review_id, \"Success\", JOptionPane.PLAIN_MESSAGE);\n            this.setVisible(false);\n            new FrameUnreadCodes().setVisible(true);\n        }\n        else{\n            JOptionPane.showMessageDialog(this,\"Unable to save review. Please try later.\", \"Error\", JOptionPane.INFORMATION_MESSAGE);\n            this.setVisible(false);\n            new FrameUnreadCodes().setVisible(true);\n        }\n    }\n\n    private JSONObject createReviewJSON(int approved){\n        endDate = new Date();\n        JSONObject review = new JSONObject();\n\n//        review.put(\"codeId\", this.codeId);\n//        review.put(\"reviewerId\",Session.currentUser.getUserId());\n//        review.put(\"approved\", approved);\n//        review.put(\"startTime\", Utils.convertDatetoString(this.startDate,\"yyyy-M-dd hh:mm:ss\"));\n//        review.put(\"submitTime\", Utils.convertDatetoString(this.endDate,\"yyyy-M-dd hh:mm:ss\"));\n        return review;\n    }', 4, '2018-11-09 11:50:15', 51, 'R1', 'UI mod 2', 0),
(24, 1, '/*\n * To change this license header, choose License Headers in Project Properties.\n * To change this template file, choose Tools | Templates\n * and open the template in the editor.\n */\npackage com.agileseven.codereviewserver.DAO;\n\nimport com.agileseven.codereviewserver.DTO.*;\n\nimport java.sql.Connection;\nimport java.sql.PreparedStatement;\nimport java.sql.ResultSet;\nimport java.sql.SQLException;\nimport java.sql.Statement;\nimport java.util.ArrayList;\nimport java.util.logging.Level;\nimport java.util.logging.Logger;\n\n/**\n * This class implements the methods of ReviewDAO interface\n * \n * @author vilosh_na\n * @version 1.0\n * @date created : 13.10.2018\n */\npublic class ReviewDAOImpl implements ReviewDAO {\n\n   \n    public int approveCode(int code_id, int approved) {\n        Connection con = ConnectionFactory.getConnection();\n        \n        String query = \"UPDATE review SET \"\n                    + \"approved = \" + approved + \" \"\n                    + \"WHERE review.code_id = \" + code_id;\n        \n        \n        try { \n            PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);\n            ps.executeUpdate();\n            ResultSet rs = ps.getGeneratedKeys();\n          \n            con.close();\n        } catch (SQLException ex) {\n            System.err.println(\"Got an exception!\");\n            System.err.println(ex.getMessage());\n            return -1;\n        }\n        return 1;\n        \n    }\n\n    @Override\n    public int addReview(ReviewDTO review) {\n        \n        Connection con = ConnectionFactory.getConnection();\n        int review_id = -1;\n        \n        String query = \"INSERT INTO review (code_id, reviewer_id, approved, start_time, submit_time) \"\n                    + \" VALUES(?,?,?,STR_TO_DATE(?,\'%Y-%m-%d %T\'),STR_TO_DATE(?,\'%Y-%m-%d %T\'))\";\n        \n        try { \n            PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);\n            ps.setInt(1, review.getCodeId());\n            ps.setInt(2, review.getReviewerId());\n            // approved by default for first sprint\n            ps.setInt(3, review.getApproved());\n            \n                   \n            ps.setString(4, review.getStartTime());\n            ps.setString(5, review.getSubmitTime());\n            \n            System.out.println(ps.toString());\n          \n            ps.executeUpdate();\n            ResultSet rs = ps.getGeneratedKeys();\n            if(rs.next()){\n                review_id = rs.getInt(1);\n            }\n            CodeDAO codeDAO = new CodeDAOImpl();\n            codeDAO.changeStatusOfCode(review.getCodeId(),2);\n\n            for (ReviewAnnotationDTO annotation: review.getAnnotationList()) {\n                String annQuery = \"INSERT INTO review_annotation (annotation_text, rule_id, review_id, line_number) \"\n                        + \" VALUES(?,?,?,?)\";\n                PreparedStatement annPS = con.prepareStatement(annQuery, Statement.RETURN_GENERATED_KEYS);\n                annPS.setString(1, annotation.getAnnotText());\n                annPS.setString(2, annotation.getRuleDTO().getRuleid());\n                annPS.setInt(3, review_id);\n                annPS.setInt(4, annotation.getLineNumber());\n                annPS.executeUpdate();\n            }\n\n            // Updating the reviewer\'s score\n            int reviewerId = review.getReviewerId();\n            int reviewerScore = 5;\n            reviewerScore += review.getAnnotationList().size();\n\n            String reviewerScoreQuery = \"UPDATE user SET user_xp = user_xp + ? WHERE user_id = ?\";\n            PreparedStatement statementReviewer = con.prepareStatement(reviewerScoreQuery);\n            statementReviewer.setInt(1, reviewerScore);\n            statementReviewer.setInt(2, reviewerId);\n            statementReviewer.executeUpdate();\n\n            // Updating the reviewer\'s gold (if needed)\n            String reviewerNewScoreQuery = \"SELECT user_xp FROM user WHERE user_id = ?\";\n            PreparedStatement statementReviewerNewScoreQuery = con.prepareStatement(reviewerNewScoreQuery);\n            statementReviewerNewScoreQuery.setInt(1, reviewerId);\n\n            ResultSet rsReviewerNewScore = statementReviewerNewScoreQuery.executeQuery();\n            rsReviewerNewScore.next();\n            int score = rsReviewerNewScore.getInt(1);\n\n            increaseUserGoldByOne(con, reviewerId, score);\n\n            // If the code was approved, increase the pusher\'s score by 10\n            if (review.getApproved() == 1) {\n\n                String sqlGetPusherId = \"SELECT user_id, version, number_of_lines from code WHERE code_id = ?\";\n                PreparedStatement statement = con.prepareStatement(sqlGetPusherId);\n                statement.setInt(1, review.getCodeId());\n\n                statement.executeQuery();\n                ResultSet resultSet = statement.executeQuery();\n                resultSet.next();\n\n                int pusherId = resultSet.getInt(1);\n                int version = resultSet.getInt(2);\n                int numberOfLines = resultSet.getInt(3);\n                \n                int xp = 0;\n                if (version == 1){\n                    xp += Math.ceil(numberOfLines / 10.0);\n                } else if (version == 2){\n                    xp += Math.ceil(numberOfLines / 20.0);\n                } else {\n                    xp += (Math.ceil(numberOfLines / 20.0) - (version - 2));\n                }\n                \n                if (xp < 0){\n                    xp = 0;\n                }\n                \n                String pusherScoreQuery = \"UPDATE user SET user_xp = user_xp + \" + xp + \" WHERE user_id = ?\";\n                PreparedStatement statementPusher = con.prepareStatement(pusherScoreQuery);\n                statementPusher.setInt(1, pusherId);\n                statementPusher.executeUpdate();\n\n                \n\n                // Updating the pusher\'s gold (if needed)\n                String pusherNewScoreQuery = \"SELECT user_xp FROM user WHERE user_id = ?\";\n                PreparedStatement statementPusherNewScoreQuery = con.prepareStatement(pusherNewScoreQuery);\n                statementPusherNewScoreQuery.setInt(1, reviewerId);\n\n                ResultSet rsPusherNewScore = statementPusherNewScoreQuery.executeQuery();\n                rsPusherNewScore.next();\n                int pusherScore = rsPusherNewScore.getInt(1);\n\n                increaseUserGoldByOne(con, pusherId, pusherScore);\n\n            }\n            con.close();\n        } catch (SQLException ex) {\n            System.err.println(\"Got an exception!\");\n            System.err.println(ex.getMessage());\n            return -1;\n        } \n\n        return review_id;\n    }\n\n    private void increaseUserGoldByOne(Connection con, int pusherId, int scorePusher) throws SQLException {\n        if (scorePusher % 50 == 0){\n            String pusherBonusGoldQuery = \"UPDATE user SET user_gold = user_gold + 1 WHERE user_id = ?\";\n            PreparedStatement statementPusherBonusGoldQuery = con.prepareStatement(pusherBonusGoldQuery);\n            statementPusherBonusGoldQuery.setInt(1, pusherId);\n            statementPusherBonusGoldQuery.executeUpdate();\n        }\n    }\n\n    @Override\n    public ArrayList<ReviewDTO> getReviewedCodesByUser(int userId, int projectId) {\n        \n        ArrayList<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();\n        \n        Connection con = ConnectionFactory.getConnection();\n        String query = \"SELECT c.code_id,c.code_text,c.user_story_id,\" +\n                        \"us.title, r.review_id, r.reviewer_id, u.first_name, u.last_name,\"+\n                        \"r.approved, STR_TO_DATE(r.submit_time,\'%Y-%m-%d %T\') as submit_time \"+\n                        \"FROM code c, user u, user_story us, review r \" +\n                        \"where r.reviewer_id = u.user_id \" +\n                        \" AND c.user_story_id = us.user_story_id \" +\n                        \" AND r.code_id = c.code_id \" +\n                        \" AND us.project_id = ? \" +\n                        \" AND c.user_id = ? \" +\n                        \"order by r.submit_time desc \";\n        \n           try {\n                PreparedStatement ps = con.prepareStatement(query);\n                System.out.println(ps.toString());\n                ps.setInt(1, projectId);\n                ps.setInt(2, userId);\n                System.out.println(ps.toString());\n                ResultSet rs = ps.executeQuery();\n                while (rs.next()) {\n                    reviewList.add(buildReviewDTOfromResult(rs));\n                }\n                ps.close();\n                rs.close();\n                con.close();\n            }catch (SQLException ex) {\n                \n            }\n        \n        return reviewList;\n      \n    }\n\n    @Override\n    public ArrayList<RuleDTO> getRulesList() {\n        ArrayList<RuleDTO> ruleList = new ArrayList<RuleDTO>();\n\n        Connection con = ConnectionFactory.getConnection();\n        String query = \"SELECT * FROM rule; \";\n\n        try {\n            PreparedStatement ps = con.prepareStatement(query);\n            ResultSet rs = ps.executeQuery();\n            while (rs.next()) {\n                ruleList.add(new RuleDTO(rs.getString(1), rs.getString(2)));\n            }\n            ps.close();\n            rs.close();\n            con.close();\n        }catch (SQLException ex) {\n            ex.printStackTrace();\n        }\n\n        return ruleList;\n    }\n\n    public ReviewDTO buildReviewDTOfromResult(ResultSet rs){\n        \n        ReviewDTO review = new ReviewDTO();\n        \n        try{\n            \n            review.setReviewId(rs.getInt(\"review_id\"));\n            review.setCodeId(rs.getInt(\"code_id\"));\n            review.setReviewerId(rs.getInt(\"reviewer_id\"));\n            review.setApproved(rs.getInt(\"approved\"));\n            review.setSubmitTime(rs.getString(\"submit_time\"));\n            \n            CodeDTO code = new CodeDTO();\n            code.setCodeId(rs.getInt(\"code_id\"));\n            code.setCodeText(rs.getString(\"code_text\"));\n            code.setUserStoryId(rs.getString(\"user_story_id\"));\n            \n            UserstoryDTO userStory = new UserstoryDTO();\n            userStory.setUserstoryId(rs.getString(\"user_story_id\"));\n            userStory.setTitle(rs.getString(\"title\"));\n            code.setUserStory(userStory);\n            \n            review.setCode(code);\n            \n            UserDTO user = new UserDTO();\n            user.setUserId(rs.getInt(\"reviewer_id\"));\n            user.setFirstName(rs.getString(\"first_name\"));            \n            user.setLastName(rs.getString(\"last_name\"));\n            review.setReviewer(user);\n            \n            \n            \n            \n        } catch (SQLException ex) {\n            Logger.getLogger(ReviewDAOImpl.class.getName()).log(Level.SEVERE, null, ex);\n        }\n        \n        return review;\n        \n    }\n\n    \n}\n', 6, '2018-11-09 13:50:52', 285, 'R2', 'Review DAO', 0),
(25, 1, '/*\n * To change this license header, choose License Headers in Project Properties.\n * To change this template file, choose Tools | Templates\n * and open the template in the editor.\n */\npackage com.agileseven.codereview.client.listeners;\n\nimport com.agileseven.codereview.client.views.FrameReview;\nimport java.awt.event.MouseEvent;\nimport java.awt.event.MouseListener;\nimport javax.swing.JFrame;\n\n/**\n *\n * @author vilosh_na\n */\npublic class CodeListMouseListener implements MouseListener {\n    \n    private int codeId;\n    private JFrame frame;\n\n    public CodeListMouseListener(int codeId, JFrame frame) {\n        this.codeId=codeId;\n        this.frame = frame;\n    }\n    \n    \n    \n    @Override\n     public void mouseClicked(MouseEvent e) {\n       this.frame.setVisible(false);\n       new FrameReview(this.codeId).setVisible(true);\n       \n    }\n\n    @Override\n    public void mousePressed(MouseEvent e) {\n        \n    }\n\n    @Override\n    public void mouseReleased(MouseEvent e) {\n    }\n\n    @Override\n    public void mouseEntered(MouseEvent e) {\n    }\n\n    @Override\n    public void mouseExited(MouseEvent e) {\n    }\n    \n}\n', 7, '2018-11-08 15:51:24', 54, 'R2', 'mouse listener', 0),
(26, 1, '/*\n * To change this license header, choose License Headers in Project Properties.\n * To change this template file, choose Tools | Templates\n * and open the template in the editor.\n */\npackage com.agileseven.codereview.client;\n\nimport java.text.SimpleDateFormat;\nimport java.util.Calendar;\nimport java.util.Date;\n\n/**\n *\n * @author vilosh_na\n */\npublic class Utils {\n    \n    public static String dateDiff(Date start, Date end){\n\n        int minutes =0;\n        int hours = 0;\n        int days = 0;\n        \n        long diff = end.getTime() - start.getTime(); \n	    days = (int) (diff / (24 * 60 * 60 * 1000));\n        \n        Calendar calendar_start = Calendar.getInstance();\n        Calendar calendar_end = Calendar.getInstance();\n        calendar_start.setTime(start);\n        calendar_end.setTime(end);\n        \n        if(calendar_start.get(Calendar.HOUR_OF_DAY) > calendar_end.get(Calendar.HOUR_OF_DAY)){\n            hours = 24-calendar_start.get(Calendar.HOUR_OF_DAY) + calendar_end.get(Calendar.HOUR_OF_DAY);\n\n        }\n        else{\n            hours = calendar_end.get(Calendar.HOUR_OF_DAY) - calendar_start.get(Calendar.HOUR_OF_DAY);\n        }\n        \n        if(calendar_start.get(Calendar.MINUTE) > calendar_end.get(Calendar.MINUTE)){\n            minutes = 60 -calendar_start.get(Calendar.MINUTE) + calendar_end.get(Calendar.MINUTE);\n\n        }\n        else{\n            minutes = calendar_end.get(Calendar.MINUTE) - calendar_start.get(Calendar.MINUTE);\n        }\n\n        return days + \" days \"+ hours + \" Hrs \"+ minutes + \" mins.\";\n    }\n        \n    public static String convertDatetoString(Date date, String format){\n        System.out.println(date);\n\n        SimpleDateFormat sdf = new SimpleDateFormat(format);\n        String jsonDate = sdf.format(date);\n        \n        return jsonDate;\n    }\n\n    public static String addLineNumbersToCodeString(String code){\n        int count = 1;\n        String[] lines = code.split(\"\\\\r?\\\\n\");\n        StringBuilder newCodeText = new StringBuilder();\n        for (String line : lines) {\n            newCodeText.append(count).append(line).append(\"\\n\");\n            count++;\n        }\n        return newCodeText.toString();\n    }\n\n}\n', 2, '2018-11-08 09:52:15', 72, 'R1', 'Utility functions', 0),
(27, 1, '@Override\n    public UserDTO getUserById(int userId) throws SQLException {\n\n        PreparedStatement statement = connection.prepareStatement(\"SELECT * FROM user WHERE user_id = ?;\");\n        statement.setInt(1, userId);\n\n        ResultSet resultSet = statement.executeQuery();\n        resultSet.next();\n\n        UserDTO user = new UserDTO();\n        user.setUserId(resultSet.getInt(1));\n        user.setFirstName(resultSet.getString(2));\n        user.setLastName(resultSet.getString(3));\n        user.setEmail(resultSet.getString(4));\n        user.setPhoto(resultSet.getString(5));\n        user.setPositionId(resultSet.getInt(6));\n        user.setProjectId(resultSet.getInt(7));\n\n        return user;\n    }\n\n   \n    \n    public ArrayList<UserDTO> getUsersList() {\n        \n        ArrayList<UserDTO> accountList = new ArrayList<UserDTO>();\n        \n        Connection con = ConnectionFactory.getConnection();\n        ResultSet rs;\n        Statement st;\n        String query = \"SELECT * FROM user\";\n        \n        try {\n            \n            st = con.createStatement();\n            rs = st.executeQuery(query);\n\n            while (rs.next() == true) {\n                int userid = rs.getInt(1);\n                String fname = rs.getString(2);\n                String lastname = rs.getString(3);\n                String email = rs.getString(4);\n                String photo = rs.getString(5);\n                int positionId = rs.getInt(6);\n                int projectId = rs.getInt(7);\n                \n                UserDTO user = new UserDTO(userid,fname,lastname,email,photo,positionId,projectId);\n                accountList.add(user);\n                \n//                st.close();\n//                rs.close();\n//                con.close();\n            }\n            } catch (SQLException ex) {\n            System.out.println(ex);\n        }\n        return accountList;\n    }\n    \n    @Override\n    public List<UserDTO> getMembersOfProject(int projectId) throws SQLException {\n\n        PreparedStatement statement = connection.prepareStatement(\"SELECT * FROM user WHERE project_id = ?;\");\n        statement.setInt(1, projectId);\n        ResultSet resultSet = statement.executeQuery();\n\n        List<UserDTO> users = new ArrayList<>();\n        while(resultSet.next()){\n            int userId = resultSet.getInt(1);\n            String firstName = resultSet.getString(2);\n            String lastName = resultSet.getString(3);\n            String email = resultSet.getString(4);\n            String photoPath = resultSet.getString(5);\n            int positionId = resultSet.getInt(6);\n            int pId = resultSet.getInt(7);\n\n            users.add(new UserDTO(userId, firstName, lastName, email, photoPath, positionId, pId));\n        }\n        return users;\n    }', 4, '2018-11-09 16:15:30', 80, 'R1', 'Push Code to simulate', 2);

-- --------------------------------------------------------

--
-- Table structure for table `position`
--

CREATE TABLE `position` (
  `position_id` int(10) NOT NULL,
  `role` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `position`
--

INSERT INTO `position` (`position_id`, `role`) VALUES
(1, 'Developer'),
(2, 'Scrum master');

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `project_id` int(10) NOT NULL,
  `project_name` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`project_id`, `project_name`) VALUES
(1, 'Code management system'),
(2, 'Website for university UT1 library'),
(3, 'Website Ytaing asia market'),
(4, 'Work next door ');

-- --------------------------------------------------------

--
-- Table structure for table `project_assignment`
--

CREATE TABLE `project_assignment` (
  `project_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_assignment`
--

INSERT INTO `project_assignment` (`project_id`, `user_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `review_id` int(10) NOT NULL,
  `code_id` int(10) NOT NULL,
  `reviewer_id` int(10) NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `start_time` datetime NOT NULL,
  `submit_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`review_id`, `code_id`, `reviewer_id`, `approved`, `start_time`, `submit_time`) VALUES
(1, 1, 1, 1, '2018-10-08 09:30:00', '2018-10-08 09:45:00'),
(2, 2, 6, 1, '2018-10-10 10:10:00', '2018-10-10 10:50:00'),
(21, 6, 1, 1, '2018-10-23 11:52:13', '2018-10-23 11:52:16'),
(22, 10, 2, 1, '2018-10-24 01:11:20', '2018-10-24 01:11:21'),
(23, 8, 2, 1, '2018-10-24 01:11:25', '2018-10-24 01:11:27'),
(24, 12, 2, 1, '2018-10-24 01:11:32', '2018-10-24 01:11:34'),
(25, 5, 2, 1, '2018-10-24 01:11:38', '2018-10-24 01:11:39'),
(26, 4, 2, 1, '2018-10-24 01:11:44', '2018-10-24 01:11:45'),
(27, 15, 2, 1, '2018-10-24 01:11:54', '2018-10-24 01:11:56'),
(28, 13, 5, 1, '2018-10-24 01:30:50', '2018-10-24 01:30:52'),
(29, 16, 5, 1, '2018-10-24 01:30:58', '2018-10-24 01:30:59'),
(36, 11, 5, 0, '2018-10-27 03:57:34', '2018-10-27 03:57:35'),
(37, 9, 4, 1, '2018-10-27 03:57:38', '2018-10-27 03:57:39'),
(38, 17, 7, 0, '2018-10-27 03:57:42', '2018-10-27 03:57:43'),
(39, 7, 2, 1, '2018-10-27 03:57:46', '2018-10-27 03:57:47'),
(40, 19, 3, 0, '2018-10-29 09:48:20', '2018-10-29 09:48:37'),
(41, 18, 3, 0, '2018-10-29 10:04:42', '2018-10-29 10:05:24'),
(42, 18, 3, 0, '2018-10-29 10:06:32', '2018-10-29 10:06:48'),
(43, 19, 3, 1, '2018-10-29 10:07:13', '2018-10-29 10:08:04'),
(44, 20, 1, 1, '2018-11-06 03:31:35', '2018-11-06 03:32:06'),
(45, 19, 3, 1, '2018-11-06 03:40:20', '2018-11-06 03:40:37'),
(46, 18, 3, 1, '2018-11-06 03:48:39', '2018-11-06 03:49:11'),
(47, 14, 2, 1, '2018-11-09 02:01:12', '2018-11-09 02:01:19'),
(48, 14, 5, 1, '2018-11-09 02:13:47', '2018-11-09 02:13:50'),
(49, 18, 1, 0, '2018-11-09 10:41:09', '2018-11-09 10:41:17'),
(50, 18, 3, 1, '2018-11-09 10:51:21', '2018-11-09 10:51:26'),
(51, 18, 1, 1, '2018-11-09 10:53:53', '2018-11-09 10:54:03'),
(52, 18, 1, 1, '2018-11-09 10:56:01', '2018-11-09 10:56:05'),
(53, 19, 1, 1, '2018-11-09 10:57:15', '2018-11-09 10:57:16'),
(54, 21, 7, 1, '2018-11-09 11:02:46', '2018-11-09 11:03:01'),
(55, 20, 7, 1, '2018-11-09 11:38:29', '2018-11-09 11:38:30'),
(56, 27, 3, 0, '2018-11-09 04:31:34', '2018-11-09 04:31:59'),
(57, 22, 3, 1, '2018-11-09 04:37:40', '2018-11-09 04:37:46');

-- --------------------------------------------------------

--
-- Table structure for table `review_annotation`
--

CREATE TABLE `review_annotation` (
  `annotation_id` int(10) NOT NULL,
  `annotation_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `rule_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `review_id` int(10) NOT NULL,
  `line_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `review_annotation`
--

INSERT INTO `review_annotation` (`annotation_id`, `annotation_text`, `rule_id`, `review_id`, `line_number`) VALUES
(1, 'Incorrect Identation', 'R100', 21, 1),
(2, 'this code is shit', 'R103', 21, 1),
(3, 'test annotation 1', 'R100', 42, 1),
(4, 'test annotation 2', 'R200', 42, 2),
(5, 'not meaningful name', 'R302', 43, 4),
(6, 'test', 'R100', 44, 1),
(7, 'test', 'R100', 45, 1),
(8, 'test', 'R100', 46, 1),
(9, 'hgbhjgbhjgbhjbh', 'R100', 49, 6),
(10, 'Too many comments', 'R103', 56, 17);

-- --------------------------------------------------------

--
-- Table structure for table `rule`
--

CREATE TABLE `rule` (
  `rule_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rule_text` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rule`
--

INSERT INTO `rule` (`rule_id`, `rule_text`) VALUES
('R100', 'Insert annotations for class\r\n'),
('R101', 'Insert annotations for methods\r\n'),
('R103', 'Insert inline comments when important'),
('R104', 'Avoid excessive comments(ex: for self explanatory codes)'),
('R200', 'Maintain a consistent indentation'),
('R201', 'Limit line length to around 80 characters per line'),
('R202', 'Blank Lines\r\n'),
('R203', 'Avoid multiple consecutive blank lines'),
('R300', 'Class name start with Uppercase and each subsequent word also starts with uppercase ex : Person, FootballTournament'),
('R301', 'Lower Camel Case for attributes and methods i.e starts with lowercase and each subsequent word starts with uppsercase ex : name, lastName'),
('R302', 'Use meaningful variable names (avoid 1-letter names ex a, b, c)'),
('R303', 'All constant variables should be in uppercase with words separated by underscore ex : DATABASE_ERROR'),
('R304', 'Name of package should be in lowercase'),
('R400', 'Avoid repeating codes. Regroup similar codes into methods where applicable.'),
('R500', 'Always check errors and catch them to prevent system crash'),
('R501', 'Error messages should be meaningful');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(10) NOT NULL,
  `first_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position_id` int(10) NOT NULL,
  `project_id` int(10) NOT NULL,
  `user_xp` int(11) NOT NULL,
  `user_gold` int(11) NOT NULL,
  `last_login` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `first_name`, `last_name`, `email`, `photo`, `position_id`, `project_id`, `user_xp`, `user_gold`, `last_login`) VALUES
(1, 'Dinh Dieu', 'Vu', 'dinh-dieu.vu@ut-capitole.fr', 'img_Dieu.jpg', 2, 1, 2537, 55, '2018-11-09 17:26:47'),
(2, 'Xutong', 'Jin', 'Rosa.Jin.Cueb@hotmail.com', 'img_Xutong.jpg', 1, 1, 2016, 165, '2018-11-09 17:27:19'),
(3, 'Mahmoud', 'Al Najar', 'testing.agileseven@gmail.com', 'img_Mahmoud.jpg', 1, 1, 1807, 25, '2018-11-09 16:39:40'),
(4, 'Sarune', 'Samoskaite', 'saruneee@gmail.com', 'img_Sarune.jpg', 1, 1, 2108, 32, '2018-11-09 16:39:03'),
(5, 'Viloshna', 'Sonoo', 'viloshna.sonoo@gmail.com', 'img_Viloshna.jpg', 1, 1, 2125, 65, '2018-11-09 14:35:15'),
(6, 'Melika', 'Mali', 'melika.mali@gmail.com', 'img_Melika.jpg', 1, 1, 2320, 17, '2018-11-09 11:32:30'),
(7, 'Kaichi', 'Cong', 'cong.kaichi@gmail.com', 'img_Kaichi.jpg', 1, 1, 2450, 35, '2018-11-09 11:46:42'),
(8, 'Jane', 'Doh', 'jane.doe@gmail.com', 'jane.jpg', 2, 2, 1500, 10, '2018-11-09 01:30:00'),
(9, 'Cristiano', 'Ronaldo', 'cr7@gmail.com', 'cr7.jpg', 1, 2, 1400, 11, '2018-11-09 01:30:10');

-- --------------------------------------------------------

--
-- Table structure for table `user_history`
--

CREATE TABLE `user_history` (
  `user_id` int(10) NOT NULL,
  `first_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position_id` int(10) NOT NULL,
  `project_id` int(10) NOT NULL,
  `user_xp` int(11) NOT NULL,
  `user_gold` int(11) NOT NULL,
  `last_login` datetime NOT NULL,
  `backup_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_history`
--

INSERT INTO `user_history` (`user_id`, `first_name`, `last_name`, `email`, `photo`, `position_id`, `project_id`, `user_xp`, `user_gold`, `last_login`, `backup_date`) VALUES
(1, 'Dinh Dieu', 'Vu', 'dinh-dieu.vu@ut-capitole.fr', 'img_Dieu.jpg', 2, 1, 2510, 30, '2018-11-05 00:00:00', '2018-11-09 10:31:10'),
(2, 'Xutong', 'Jin', 'Rosa.Jin.Cueb@hotmail.com', 'img_Xutong.jpg', 1, 1, 2010, 26, '2018-11-05 00:00:00', '2018-11-09 10:33:42'),
(3, 'Mahmoud', 'Al Najar', 'testing.agileseven@gmail.com', 'img_Mahmoud.jpg', 1, 1, 1777, 24, '2018-11-05 00:00:00', '2018-11-09 15:06:09'),
(4, 'Sarune', 'Samoskaite', 'saruneee@gmail.com', 'img_Sarune.jpg', 1, 1, 2100, 24, '2018-11-05 00:00:00', '2018-11-09 10:29:34'),
(5, 'Viloshna', 'Sonoo', 'viloshna.sonoo@gmail.com', 'img_Viloshna.jpg', 1, 1, 2110, 19, '2018-11-05 00:00:00', '2018-11-09 10:30:21'),
(6, 'Melika', 'Mali', 'melika.mali@gmail.com', 'img_Melika.jpg', 1, 1, 2319, 17, '2018-11-05 00:00:00', '2018-11-09 10:32:23'),
(7, 'Kaichi', 'Cong', 'cong.kaichi@gmail.com', 'img_Kaichi.jpg', 1, 1, 2440, 18, '2018-11-05 00:00:00', '2018-11-09 10:29:34'),
(8, 'Jane', 'Doh', 'jane.doe@gmail.com', 'jane.jpg', 2, 2, 1500, 10, '2018-11-05 00:00:00', '2018-11-09 10:29:21'),
(9, 'Cristiano', 'Ronaldo', 'cr7@gmail.com', 'cr7.jpg', 1, 2, 1400, 11, '2018-11-05 00:00:00', '2018-11-09 10:29:00');

-- --------------------------------------------------------

--
-- Table structure for table `user_story`
--

CREATE TABLE `user_story` (
  `user_story_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `title` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_story`
--

INSERT INTO `user_story` (`user_story_id`, `project_id`, `description`, `title`) VALUES
('R1', 1, 'To push my code', 'Rev_push'),
('R2', 1, 'to indicate that my code is ready to be read', 'Rev_indicate');

-- --------------------------------------------------------

--
-- Table structure for table `version`
--

CREATE TABLE `version` (
  `version_id` int(11) NOT NULL,
  `code_id` int(11) NOT NULL,
  `code_text` text COLLATE utf8_unicode_ci,
  `date_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `code`
--
ALTER TABLE `code`
  ADD PRIMARY KEY (`code_id`),
  ADD KEY `project_id` (`user_story_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `position`
--
ALTER TABLE `position`
  ADD PRIMARY KEY (`position_id`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`project_id`);

--
-- Indexes for table `project_assignment`
--
ALTER TABLE `project_assignment`
  ADD PRIMARY KEY (`project_id`,`user_id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `code_id` (`code_id`),
  ADD KEY `reviewer_id` (`reviewer_id`);

--
-- Indexes for table `review_annotation`
--
ALTER TABLE `review_annotation`
  ADD PRIMARY KEY (`annotation_id`),
  ADD KEY `review_id` (`review_id`),
  ADD KEY `rule_id` (`rule_id`);

--
-- Indexes for table `rule`
--
ALTER TABLE `rule`
  ADD PRIMARY KEY (`rule_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `position_id` (`position_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `user_history`
--
ALTER TABLE `user_history`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `position_id` (`position_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `user_story`
--
ALTER TABLE `user_story`
  ADD PRIMARY KEY (`user_story_id`),
  ADD KEY `fk_pid` (`project_id`);

--
-- Indexes for table `version`
--
ALTER TABLE `version`
  ADD PRIMARY KEY (`version_id`,`code_id`),
  ADD KEY `fk_code_id` (`code_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `code`
--
ALTER TABLE `code`
  MODIFY `code_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `position`
--
ALTER TABLE `position`
  MODIFY `position_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `project_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `review_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `review_annotation`
--
ALTER TABLE `review_annotation`
  MODIFY `annotation_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `user_history`
--
ALTER TABLE `user_history`
  MODIFY `user_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `code`
--
ALTER TABLE `code`
  ADD CONSTRAINT `code_ibfk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_story_idfk` FOREIGN KEY (`user_story_id`) REFERENCES `user_story` (`user_story_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project_assignment`
--
ALTER TABLE `project_assignment`
  ADD CONSTRAINT `project_assignment_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `project_assignment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`code_id`) REFERENCES `code` (`code_id`),
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`reviewer_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `review_annotation`
--
ALTER TABLE `review_annotation`
  ADD CONSTRAINT `review_annotation_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`),
  ADD CONSTRAINT `review_annotation_ibfk_2` FOREIGN KEY (`rule_id`) REFERENCES `rule` (`rule_id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`position_id`) REFERENCES `position` (`position_id`),
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `user_history`
--
ALTER TABLE `user_history`
  ADD CONSTRAINT `user_history_ibfk_1` FOREIGN KEY (`position_id`) REFERENCES `position` (`position_id`),
  ADD CONSTRAINT `user_history_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `user_story`
--
ALTER TABLE `user_story`
  ADD CONSTRAINT `fk_pid` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `version`
--
ALTER TABLE `version`
  ADD CONSTRAINT `fk_code_id` FOREIGN KEY (`code_id`) REFERENCES `code` (`code_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
