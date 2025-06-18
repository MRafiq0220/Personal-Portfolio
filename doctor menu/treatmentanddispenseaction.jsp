<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String patientId = request.getParameter("patientId");
    String medicine = request.getParameter("medicine");
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
       Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
       conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

        String sql = "INSERT INTO treatment (patient_id, medicine) VALUES (?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, patientId);
        pstmt.setString(2, medicine);
        pstmt.executeUpdate();
%>
<div class="alert alert-success" role="alert">
    Treatment and medicine dispensed successfully!
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
