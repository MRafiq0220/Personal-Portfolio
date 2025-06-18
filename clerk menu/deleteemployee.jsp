<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Delete Employee</title>
    </head>
    <body>
        <%
            String employeeIC = request.getParameter("employeeIC");
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

                // Start a transaction
                conn.setAutoCommit(false);

                // Retrieve the employee_loginID
                String selectLoginIDSQL = "SELECT employee_loginID FROM employee WHERE employee_IC = ?";
                pstmt = conn.prepareStatement(selectLoginIDSQL);
                pstmt.setString(1, employeeIC);
                rs = pstmt.executeQuery();
                String employeeLoginID = null;

                if (rs.next()) {
                    employeeLoginID = rs.getString("employee_loginID");
                }

                rs.close();
                pstmt.close();

                if (employeeLoginID != null) {
                    // Retrieve treatment IDs associated with the employee
                    String selectTreatmentSQL = "SELECT treatment_IdTreatment FROM treatment WHERE treatment_EmployeeIC = ?";
                    pstmt = conn.prepareStatement(selectTreatmentSQL);
                    pstmt.setString(1, employeeIC);
                    rs = pstmt.executeQuery();
                    List<Integer> treatmentIds = new ArrayList<>();

                    while (rs.next()) {
                        treatmentIds.add(rs.getInt("treatment_IdTreatment"));
                    }

                    rs.close();
                    pstmt.close();

                    // Delete related records from the dispensemedication table
                    if (!treatmentIds.isEmpty()) {
                        for (int treatmentId : treatmentIds) {
                            String deleteDispenseMedicationSQL = "DELETE FROM dispensemedication WHERE dispenseMedication_IdTreatment = ?";
                            pstmt = conn.prepareStatement(deleteDispenseMedicationSQL);
                            pstmt.setInt(1, treatmentId);
                            pstmt.executeUpdate();
                            pstmt.close();
                        }
                    }

                    // Delete related records from the treatment table
                    String deleteTreatmentSQL = "DELETE FROM treatment WHERE treatment_EmployeeIC = ?";
                    pstmt = conn.prepareStatement(deleteTreatmentSQL);
                    pstmt.setString(1, employeeIC);
                    pstmt.executeUpdate();
                    pstmt.close();

                    // Delete the employee record
                    String deleteEmployeeSQL = "DELETE FROM employee WHERE employee_IC = ?";
                    pstmt = conn.prepareStatement(deleteEmployeeSQL);
                    pstmt.setString(1, employeeIC);
                    int rowsAffected = pstmt.executeUpdate();
                    pstmt.close();

                    // Delete the login record
                    String deleteLoginSQL = "DELETE FROM login WHERE login_loginID = ?";
                    pstmt = conn.prepareStatement(deleteLoginSQL);
                    pstmt.setString(1, employeeLoginID);
                    pstmt.executeUpdate();
                    pstmt.close();

                    // Commit the transaction
                    conn.commit();

                    if (rowsAffected > 0) {
                        out.println("Employee and related records deleted successfully.");
                    } else {
                        out.println("Employee not found.");
                    }
                } else {
                    out.println("Employee not found.");
                }
            } catch (Exception e) {
                // Rollback the transaction in case of error
                if (conn != null) {
                    try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
                }
                e.printStackTrace();
                out.println("Error: " + e.getMessage());
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }

            // Redirect to clerkmenu.jsp
            response.sendRedirect("clerkmenu.jsp");
        %>
    </body>
</html>
