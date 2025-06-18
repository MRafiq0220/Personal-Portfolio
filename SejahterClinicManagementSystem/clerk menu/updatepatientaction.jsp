<%@ page import="java.sql.*" %>
<%
    String ic = request.getParameter("ic");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String allergy = request.getParameter("allergy");

    Connection conn = null;
    PreparedStatement pst = null;
    String url = "jdbc:mysql://localhost/sql_mrafiq";
    String user = "sql_mrafiq";
    String password = "yDB5npdN8jXaZpL8";



    try {
     Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        conn = DriverManager.getConnection(url, user, password);
        
        String sql = "UPDATE patient SET patient_PhoneNumber = ?, patient_Address = ?, patient_Allergy = ? WHERE patient_IC = ?";
        pst = conn.prepareStatement(sql);
        pst.setString(1, phone);
        pst.setString(2, address);
        pst.setString(3, allergy);
        pst.setString(4, ic);
        
        int row = pst.executeUpdate();
        
        if (row > 0) {
            out.println("<script>alert('Patient updated successfully');</script>");
            out.println("<script>window.location.href = 'findpatient.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to update patient');</script>");
            out.println("<script>window.location.href = 'findpatient.jsp';</script>");
        }
        
    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
    } finally {
        if (pst != null) {
            try {
                pst.close();
            } catch (SQLException e) { /* ignored */}
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) { /* ignored */}
        }
    }
%>
