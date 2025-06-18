<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Submit Treatment</title>
    </head>
    <body>
        <%
            String patientIC = request.getParameter("patientIC");
            String illness = request.getParameter("illness");
            String employeeIC = request.getParameter("employeeIC");

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
              Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
               conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

                String sql = "INSERT INTO treatment (treatment_PatientIC, treatment_Date, treatment_Time, treatment_Illness, treatment_EmployeeIC) VALUES (?, CURDATE(), CURTIME(), ?, ?)";
                pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstmt.setString(1, patientIC);
                pstmt.setString(2, illness);
                pstmt.setString(3, employeeIC);
                int result = pstmt.executeUpdate();

                if (result > 0) {
                    rs = pstmt.getGeneratedKeys();
                    if (rs.next()) {
                        int treatmentId = rs.getInt(1);
                        request.setAttribute("treatmentId", treatmentId);
                        request.setAttribute("patientIC", patientIC);
                        RequestDispatcher rd = request.getRequestDispatcher("prescribemedicine.jsp");
                        rd.forward(request, response);
                    }
                } else {
                    out.println("Failed to record treatment.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error recording treatment.");
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { }
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { }
                try { if (conn != null) conn.close(); } catch (SQLException e) { }
            }
        %>
    </body>
</html>
