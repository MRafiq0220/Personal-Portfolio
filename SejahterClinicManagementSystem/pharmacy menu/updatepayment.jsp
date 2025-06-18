<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.time.LocalDate, java.time.LocalTime" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Payment Status</title>
    </head>
    <body>
        <%
            String treatmentId = request.getParameter("treatmentId");
            String paymentStatus = request.getParameter("paymentStatus");

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
         Class.forName("com.mysql.cj.jdbc.Driver");
                 conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");;

                // Get current date and time
                String paymentDate = LocalDate.now().toString();
                String paymentTime = LocalTime.now().toString();

                // Update payment status, date, and time
                String updateQuery = "UPDATE payment SET payment_Status = ?, payment_Date = ?, payment_Time = ? WHERE payment_IdTreatment = ?";
                pstmt = conn.prepareStatement(updateQuery);
                pstmt.setString(1, paymentStatus);
                pstmt.setString(2, paymentDate);
                pstmt.setString(3, paymentTime);
                pstmt.setInt(4, Integer.parseInt(treatmentId));
                int result = pstmt.executeUpdate();

                if (result > 0) {
                    out.println("<script>alert('Payment status updated successfully.'); window.location.href='listoftreatment.jsp';</script>");
                } else {
                    out.println("<script>alert('Failed to update payment status.'); window.location.href='listoftreatment.jsp';</script>");
                }
                pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('Error updating payment status: " + e.getMessage() + "'); window.location.href='listoftreatment.jsp';</script>");
            } finally {
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </body>
</html>

