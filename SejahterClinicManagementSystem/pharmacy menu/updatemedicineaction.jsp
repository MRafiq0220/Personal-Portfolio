<%@ page import="java.sql.*" %>
<%
    String medicineId = request.getParameter("medicineId");
    String medicineName = request.getParameter("medicineName");
    String medicineCategory = request.getParameter("medicineCategory");
    int medicineStock = Integer.parseInt(request.getParameter("quantity"));
    double medicinePrice = Double.parseDouble(request.getParameter("price"));

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
 Class.forName("com.mysql.cj.jdbc.Driver");
         conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

        // Update medication table
        String sqlMedication = "UPDATE medication SET medication_Name = ?, medication_Category = ?, medication_Price = ? WHERE medication_Code = ?";
        pstmt = conn.prepareStatement(sqlMedication);
        pstmt.setString(1, medicineName);
        pstmt.setString(2, medicineCategory);
        pstmt.setDouble(3, medicinePrice);
        pstmt.setString(4, medicineId);
        pstmt.executeUpdate();
        pstmt.close();

        // Update stockmedication table
        String sqlStockMedication = "UPDATE stockmedication SET stockMedication_Quantity = ? WHERE stockMedication_medicationCode = ?";
        pstmt = conn.prepareStatement(sqlStockMedication);
        pstmt.setInt(1, medicineStock);
        pstmt.setString(2, medicineId);
        pstmt.executeUpdate();

        out.println("<script>alert('Medicine updated successfully'); window.location.href='medicinemenu.jsp';</script>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Error updating medicine'); window.location.href='retrievemedicine.jsp';</script>");
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
