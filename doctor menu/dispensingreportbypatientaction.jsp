<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Treatment Report by Patient</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }
            .report-container {
                width: 80%;
                margin: 50px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .report-container h2 {
                text-align: center;
                color: #333;
            }
            .report-container table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            .report-container th, .report-container td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
            }
            .report-container th {
                background-color: #4CAF50;
                color: white;
            }
            .report-container button {
                margin: 10px 0;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #ccc;
                color: #333;
                border: none;
                cursor: pointer;
            }
            .report-container button:hover {
                background-color: #bbb;
            }
        </style>
    </head>
    <body>
        <%
            String patientId = request.getParameter("patientId");
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

                // Query to join treatment and dispensemedication tables
                String sql = "SELECT treatment_IdTreatment, treatment_Illness, treatment_Date, " +
                             "dispensemedication_medicationCode, dispensemedication_UsageMethod, dispensemedication_Quantity, dispensemedication_TotalPrice " +
                             "FROM treatment " +
                             "JOIN dispensemedication ON treatment_IdTreatment = dispensemedication_IdTreatment " +
                             "WHERE treatment_PatientIC = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, patientId);
                rs = pstmt.executeQuery();
        %>
        <div class="report-container">
            <h2>Treatment Report for Patient IC: <%= patientId %></h2>
            <table>
                <tr>
                    <th>Treatment ID</th>
                    <th>Illness</th>
                    <th>Date</th>
                    <th>Medication Code</th>
                    <th>Usage Method</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                </tr>
                <%
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("treatment_IdTreatment") %></td>
                    <td><%= rs.getString("treatment_Illness") %></td>
                    <td><%= rs.getString("treatment_Date") %></td>
                    <td><%= rs.getString("dispensemedication_medicationCode") %></td>
                    <td><%= rs.getString("dispensemedication_UsageMethod") %></td>
                    <td><%= rs.getInt("dispensemedication_Quantity") %></td>
                    <td><%= rs.getDouble("dispensemedication_TotalPrice") %></td>
                </tr>
                <%
                        }
                %>
            </table>
            <button type="button" onclick="location.href='reportmenu.jsp'">Back</button>
        </div>
        <%
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error retrieving treatment report: " + e.getMessage() + "</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </body>
</html>
