<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String username = (String) session.getAttribute("loginID"); // This should be retrieved from the session
    String currentPassword = request.getParameter("current_password");
    String newPassword = request.getParameter("new_password");
    String confirmPassword = request.getParameter("confirm_password");

    if (!newPassword.equals(confirmPassword)) {
        out.println("<script>alert('New password and confirmation do not match.'); window.location.href='changepassword.jsp';</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
       conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

        // Retrieve the stored password
        String sql = "SELECT login_password FROM login WHERE login_loginID=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String storedPassword = rs.getString("login_password");

            // Verify the old password
            if (currentPassword.equals(storedPassword)) {
                // Update the password in the database
                sql = "UPDATE login SET login_password=? WHERE login_loginID=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, newPassword);
                pstmt.setString(2, username);
                int updateResult = pstmt.executeUpdate();
                pstmt.close();

                if (updateResult > 0) {
                    out.println("<script>alert('Password changed successfully'); window.location.href='doctormenu.jsp';</script>");
                } else {
                    out.println("<script>alert('Failed to change the password'); window.location.href='changepassword.jsp';</script>");
                }
            } else {
                out.println("<script>alert('Old password is incorrect'); window.location.href='changepassword.jsp';</script>");
            }
        } else {
            out.println("<script>alert('User not found'); window.location.href='changepassword.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Error changing password: " + e.getMessage() + "'); window.location.href='changepassword.jsp';</script>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
