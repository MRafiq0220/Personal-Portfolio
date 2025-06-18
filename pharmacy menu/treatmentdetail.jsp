<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Treatment Details and Payment</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }
            .detail-container {
                width: 80%;
                margin: 50px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .detail-container h2 {
                text-align: center;
                color: #333;
            }
            .detail-container table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            .detail-container th, .detail-container td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
            }
            .detail-container th {
                background-color: #4CAF50;
                color: white;
            }
            .form-container {
                text-align: center;
                margin-top: 20px;
            }
            .form-container input[type="text"], .form-container input[type="number"], .form-container input[type="submit"] {
                padding: 10px;
                font-size: 16px;
                margin: 5px;
            }
        </style>
    </head>
    <body>
        <div class="detail-container">
            <h2>Treatment Details and Payment</h2>
            <%
                String treatmentId = request.getParameter("treatmentId");
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
             Class.forName("com.mysql.cj.jdbc.Driver");
                 conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

                    // Query to get treatment details
                    String sql = "SELECT treatment_IdTreatment, treatment_Illness, treatment_Date, treatment_PatientIC, dispensemedication_medicationCode, dispensemedication_UsageMethod, dispensemedication_Quantity, dispensemedication_TotalPrice FROM treatment JOIN dispensemedication ON treatment_IdTreatment = dispensemedication_IdTreatment WHERE treatment_IdTreatment = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, treatmentId);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
            %>
            <table>
                <tr>
                    <th>Treatment ID</th>
                    <td><%= rs.getString("treatment_IdTreatment") %></td>
                </tr>
                <tr>
                    <th>Patient IC</th>
                    <td><%= rs.getString("treatment_PatientIC") %></td>
                </tr>
                <tr>
                    <th>Illness</th>
                    <td><%= rs.getString("treatment_Illness") %></td>
                </tr>
                <tr>
                    <th>Date</th>
                    <td><%= rs.getString("treatment_Date") %></td>
                </tr>
                <tr>
                    <th>Medication Code</th>
                    <td><%= rs.getString("dispensemedication_medicationCode") %></td>
                </tr>
                <tr>
                    <th>Usage Method</th>
                    <td><%= rs.getString("dispensemedication_UsageMethod") %></td>
                </tr>
                <tr>
                    <th>Quantity</th>
                    <td><%= rs.getInt("dispensemedication_Quantity") %></td>
                </tr>
                <tr>
                    <th>Total Price</th>
                    <td>RM<%= rs.getDouble("dispensemedication_TotalPrice") %></td>
                </tr>
            </table>
            <div class="form-container">
                <form action="updatepayment.jsp" method="post">
                    <input type="hidden" name="treatmentId" value="<%= rs.getString("treatment_IdTreatment") %>">
                    <input type="text" name="paymentMethod" placeholder="Payment Method" required>
                    <input type="number" name="amountPaid" placeholder="Amount Paid" required>
                    <input type="submit" value="Update Payment">
                </form>
            </div>
            <%
                    } else {
                        out.println("<p>No treatment found with the given ID.</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error retrieving treatment details: " + e.getMessage() + "</p>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </div>
    </body>
</html>
