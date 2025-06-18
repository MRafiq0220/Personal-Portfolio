<%@ page import="java.sql.*" %>
<%@ page import="java.util.logging.*" %>
<%
    String medicineID = request.getParameter("medicineID");
    if (medicineID == null || medicineID.isEmpty()) {
        out.println("<script>alert('Invalid medicine ID'); window.location.href='deletemedicine.jsp';</script>");
        return;
    }

    Logger logger = Logger.getLogger("DeleteMedicineAction");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
  Class.forName("com.mysql.cj.jdbc.Driver");
         conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

        // Check if medicine ID exists
        String checkMedicineSQL = "SELECT * FROM medication WHERE medication_Code = ?";
        pstmt = conn.prepareStatement(checkMedicineSQL);
        pstmt.setString(1, medicineID);
        rs = pstmt.executeQuery();

        if (!rs.next()) {
            out.println("<script>alert('No medicine found with the given ID'); window.location.href='deletemedicine.jsp';</script>");
        } else {
            // Debugging: Log the medicineID
            logger.info("Deleting medicine with ID: " + medicineID);

            conn.setAutoCommit(false); // Start transaction

            // Delete from stockmedication table
            String deleteStockMedicationSQL = "DELETE FROM stockmedication WHERE stockMedication_medicationCode = ?";
            pstmt = conn.prepareStatement(deleteStockMedicationSQL);
            pstmt.setString(1, medicineID);
            int stockRowsAffected = pstmt.executeUpdate();

            // Delete from dispensemedication table
            String deleteDispenseMedicationSQL = "DELETE FROM dispensemedication WHERE dispenseMedication_medicationCode = ?";
            pstmt = conn.prepareStatement(deleteDispenseMedicationSQL);
            pstmt.setString(1, medicineID);
            int dispenseRowsAffected = pstmt.executeUpdate();

            // Delete from medication table
            String deleteMedicationSQL = "DELETE FROM medication WHERE medication_Code = ?";
            pstmt = conn.prepareStatement(deleteMedicationSQL);
            pstmt.setString(1, medicineID);
            int medicationRowsAffected = pstmt.executeUpdate();

            // Commit transaction
            conn.commit();

            // Debugging: Log the number of rows affected
            logger.info("Stock Rows affected: " + stockRowsAffected);
            logger.info("Dispense Rows affected: " + dispenseRowsAffected);
            logger.info("Medication Rows affected: " + medicationRowsAffected);

            out.println("<script>alert('Medicine deleted successfully'); window.location.href='medicinemenu.jsp';</script>");
        }
    } catch (Exception e) {
        logger.log(Level.SEVERE, "Error deleting medicine", e);
        if (conn != null) {
            try {
                conn.rollback(); // Rollback transaction on error
            } catch (SQLException se) {
                logger.log(Level.SEVERE, "Error rolling back transaction", se);
            }
        }
        out.println("<script>alert('Error deleting medicine'); window.location.href='deletemedicine.jsp';</script>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { logger.log(Level.SEVERE, "Error closing ResultSet", e); }
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { logger.log(Level.SEVERE, "Error closing PreparedStatement", e); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { logger.log(Level.SEVERE, "Error closing Connection", e); }
    }
%>
