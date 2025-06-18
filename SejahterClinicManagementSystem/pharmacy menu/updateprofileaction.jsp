<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%

     String username = request.getParameter("ic");
    String phoneNumber = request.getParameter("phoneNumber");
    String address = request.getParameter("address");

    if (username == null || username.isEmpty() || phoneNumber == null || phoneNumber.isEmpty() || address == null || address.isEmpty()) {
        out.println("<script>alert('All fields are required'); window.location.href='updatepharmacy.jsp';</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
  Class.forName("com.mysql.cj.jdbc.Driver");
         conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

        String sql = "UPDATE employee SET employee_PhoneNumber = ?, employee_Address = ? WHERE employee_IC = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, phoneNumber);
        pstmt.setString(2, address);
        pstmt.setString(3, username);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            out.println("<script>alert('Profile updated successfully'); window.location.href='updatepharmacy.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to update profile'); window.location.href='updatepharmacy.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace(new PrintWriter(out));  // Print stack trace to the JSP output
        out.println("<script>alert('Error updating profile. Check the console for details.');</script>");
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(new PrintWriter(out)); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(new PrintWriter(out)); }
    }
%>
