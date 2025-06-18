<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Display Detail Treatment and Payment - Update</title>
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
            h1, h2 {
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
            form {
                text-align: center;
            }
            label {
                margin-right: 10px;
            }
            select, input[type="submit"] {
                padding: 5px 10px;
                margin: 5px;
            }
            .button-container {
                text-align: center;
                margin-top: 20px;
            }
            .back-button {
                display: inline-block;
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
                <%
                    String treatmentId = request.getParameter("treatmentId");

                    if (treatmentId == null || treatmentId.isEmpty()) {
                        out.println("<h2>Error: Treatment ID is missing.</h2>");
                        return;
                    }

                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                         Class.forName("com.mysql.cj.jdbc.Driver");
                         conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

                        // Retrieve treatment details
                        String treatmentQuery = "SELECT treatment_IdTreatment, treatment_Date, treatment_Illness, payment_Status, payment_TotalPayment FROM treatment JOIN payment ON treatment_IdTreatment = payment_IdTreatment WHERE treatment_IdTreatment = ?";
                        pstmt = conn.prepareStatement(treatmentQuery);
                        pstmt.setInt(1, Integer.parseInt(treatmentId));
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                %>
                <h1>Treatment and Payment Details</h1>
                <table>
                    <tr>
                        <th>Treatment ID</th>
                        <td><%= rs.getInt("treatment_IdTreatment") %></td>
                    </tr>
                    <tr>
                        <th>Date</th>
                        <td><%= rs.getDate("treatment_Date") %></td>
                    </tr>
                    <tr>
                        <th>Details</th>
                        <td><%= rs.getString("treatment_Illness") %></td>
                    </tr>
                    <tr>
                        <th>Payment Status</th>
                        <td><%= rs.getString("payment_Status") %></td>
                    </tr>
                    <tr>
                        <th>Total Payment</th>
                        <td><%= rs.getDouble("payment_TotalPayment") %></td>
                    </tr>
                </table>

                <h2>Update Payment Status</h2>
                <form action="updatepayment.jsp" method="post">
                    <input type="hidden" name="treatmentId" value="<%= treatmentId %>">
                    <label for="paymentStatus">Payment Status:</label>
                    <select name="paymentStatus" id="paymentStatus">
                        <option value="In Progress" <%= rs.getString("payment_Status").equals("In Progress") ? "selected" : "" %>>In Progress</option>
                        <option value="Completed" <%= rs.getString("payment_Status").equals("Completed") ? "selected" : "" %>>Completed</option>
                        <option value="Pending" <%= rs.getString("payment_Status").equals("Pending") ? "selected" : "" %>>Pending</option>
                        <option value="Cancelled" <%= rs.getString("payment_Status").equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                    </select>
                    <br><br>
                    <input type="submit" value="Update">
                </form>
                <%
                        } else {
                            out.println("<h2>No treatment found with the given ID.</h2>");
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
                <div class="button-container">
                    <a href="listoftreatment.jsp" class="back-button">Back to List</a>
                </div>
            </div>
        </div>
    </body>
</html>
