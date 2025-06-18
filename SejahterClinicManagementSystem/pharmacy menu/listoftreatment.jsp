<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>List of Treatments (Today)</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .container {
                width: 100%;
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            .content {
                margin: 50px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h1 {
                text-align: center;
                color: #333;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            table, th, td {
                border: 1px solid #ccc;
            }
            th, td {
                padding: 10px;
                text-align: left;
            }
            th {
                background-color: #f9f9f9;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .button-container {
                text-align: center;
                margin-top: 20px;
            }
            a {
                text-decoration: none;
                color: #007bff;
                padding: 5px 10px;
                border: 1px solid #007bff;
                border-radius: 3px;
                transition: background-color 0.3s, color 0.3s;
            }
            a:hover {
                background-color: #007bff;
                color: #fff;
            }
            .back-button {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #ccc;
                color: #333;
                text-align: center;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                text-decoration: none;
                transition: background-color 0.3s, color 0.3s;
            }
            .back-button:hover {
                background-color: #bbb;
                color: #fff;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="content">
                <h1>List of Treatments for Today</h1>
                <table>
                    <tr>
                        <th>Treatment ID</th>
                        <th>Date</th>
                        <th>Patient Name</th>
                        <th>Details</th>
                        <th>Action</th>
                    </tr>
                    <%
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

                            String query = "SELECT treatment_IdTreatment, treatment_Date, treatment_Illness, patient_Name FROM treatment JOIN patient ON treatment.treatment_PatientIC = patient.patient_IC WHERE treatment_Date = CURDATE()";
                            pstmt = conn.prepareStatement(query);
                            rs = pstmt.executeQuery();

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("treatment_IdTreatment") %></td>
                        <td><%= rs.getDate("treatment_Date") %></td>
                        <td><%= rs.getString("patient_Name") %></td>
                        <td><%= rs.getString("treatment_Illness") %></td>
                        <td><a href="displaytreatmentdetail.jsp?treatmentId=<%= rs.getInt("treatment_IdTreatment") %>">View Details</a></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<h2>Error: " + e.getMessage() + "</h2>");
                        } finally {
                            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </table>
                <div class="button-container">
                    <a href="paymentmenu.jsp" class="back-button">Back to Menu</a>
                </div>
            </div>
        </div>
    </body>
</html>
