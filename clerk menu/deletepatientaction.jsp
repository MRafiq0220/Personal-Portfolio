<%@ page import="java.sql.*" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%
    String ic = request.getParameter("ic");
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

        // Start transaction
        conn.setAutoCommit(false);

        // Delete from payment table
        String deletePaymentSQL = "DELETE FROM payment WHERE payment_IdTreatment IN (SELECT treatment_IdTreatment FROM treatment WHERE treatment_PatientIC = ?)";
        pstmt = conn.prepareStatement(deletePaymentSQL);
        pstmt.setString(1, ic);
        pstmt.executeUpdate();

        // Delete from dispensemedication table
        String deleteDispenseMedicationSQL = "DELETE FROM dispensemedication WHERE dispenseMedication_IdTreatment IN (SELECT treatment_IdTreatment FROM treatment WHERE treatment_PatientIC = ?)";
        pstmt = conn.prepareStatement(deleteDispenseMedicationSQL);
        pstmt.setString(1, ic);
        pstmt.executeUpdate();

        // Delete from treatment table
        String deleteTreatmentSQL = "DELETE FROM treatment WHERE treatment_PatientIC = ?";
        pstmt = conn.prepareStatement(deleteTreatmentSQL);
        pstmt.setString(1, ic);
        pstmt.executeUpdate();

        // Delete from patient table
        String deletePatientSQL = "DELETE FROM patient WHERE patient_IC = ?";
        pstmt = conn.prepareStatement(deletePatientSQL);
        pstmt.setString(1, ic);
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // Commit transaction
            conn.commit();
            response.sendRedirect("deletepatient.jsp?status=success");
        } else {
            // Rollback transaction
            conn.rollback();
            response.sendRedirect("deletepatient.jsp?status=nopatient");
        }
    } catch (SQLException e) {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        // Log the error and show a generic message to the user
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        System.err.println("SQL Exception: " + e.getMessage());
        response.sendRedirect("deletepatient.jsp?status=error");
    } catch (ClassNotFoundException e) {
        // Log the error and show a generic message to the user
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        System.err.println("ClassNotFoundException: " + e.getMessage());
        response.sendRedirect("deletepatient.jsp?status=error");
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
