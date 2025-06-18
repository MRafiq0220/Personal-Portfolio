<%@ page import="java.sql.*" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%
    String medicineCode = request.getParameter("medicineCode");
    String medicineName = request.getParameter("medicineName");
    String medicineCategory = request.getParameter("medicineCategory");
    int medicineStock = Integer.parseInt(request.getParameter("quantity"));
    double medicinePrice = Double.parseDouble(request.getParameter("price"));

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
     conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

        // Insert into medication table
        String sqlMedication = "INSERT INTO medication (medication_Code, medication_Name, medication_Category, medication_Price) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sqlMedication);
        pstmt.setString(1, medicineCode);
        pstmt.setString(2, medicineName);
        pstmt.setString(3, medicineCategory);
        pstmt.setDouble(4, medicinePrice);
        pstmt.executeUpdate();
        pstmt.close();

        // Generate stockMedication_id from the first two letters of the medicineCode
        String stockMedicationId = medicineCode.substring(0, 2);

        // Insert into stockmedication table
        String sqlStockMedication = "INSERT INTO stockmedication (stockMedication_id, stockMedication_medicationCode, stockMedication_Quantity) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(sqlStockMedication);
        pstmt.setString(1, stockMedicationId);
        pstmt.setString(2, medicineCode);
        pstmt.setInt(3, medicineStock);
        pstmt.executeUpdate();

        out.println("<script>alert('Medicine added successfully'); window.location.href='medicinemenu.jsp';</script>");
    } catch (Exception e) {
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        out.println("<script>alert('Error adding medicine: " + sw.toString().replace("\n", "\\n").replace("\r", "\\r").replace("'", "\\'") + "'); window.location.href='addmedicine.jsp';</script>");
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
