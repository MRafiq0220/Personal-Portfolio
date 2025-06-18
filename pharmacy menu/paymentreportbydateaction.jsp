<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Payment Report</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #e9f7ef; /* Light green background */
                font-family: 'Arial', sans-serif;
            }
            .container {
                margin-top: 50px;
                background-color: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h2 {
                color: #28a745; /* Green text */
            }
            table {
                width: 100%;
                margin-top: 20px;
                border-collapse: collapse;
            }
            table, th, td {
                border: 1px solid #ccc;
            }
            th, td {
                padding: 10px;
                text-align: left;
            }
            th {
                background-color: #28a745; /* Green background */
                color: white;
            }
            .btn-secondary {
                background-color: #6c757d;
                border-color: #6c757d;
            }
            .btn-secondary:hover {
                background-color: #5a6268;
                border-color: #545b62;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center">Payment Report</h2>
            <%
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

                    String sql = "SELECT * FROM payment WHERE payment_Date BETWEEN ? AND ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, startDate);
                    pstmt.setString(2, endDate);

                    rs = pstmt.executeQuery();
            %>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Payment ID</th>
                        <th>Patient ID</th>
                        <th>Amount</th>
                        <th>Date</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("payment_IdPayment") %></td>
                        <td><%= rs.getString("payment_IdTreatment") %></td>
                        <td><%= rs.getString("payment_TotalPayment") %></td>
                        <td><%= rs.getString("payment_Date") %></td>
                        <td><%= rs.getString("payment_Status") %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <button type="button" class="btn btn-secondary btn-block" onclick="window.history.back();">Back</button>
            <%
                } catch (Exception e) {
                    e.printStackTrace(new PrintWriter(out));
                    out.println("<script>alert('Error retrieving payment report. Check the console for details.');</script>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(new PrintWriter(out)); }
                    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(new PrintWriter(out)); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(new PrintWriter(out)); }
                }
            %>
        </div>
    </body>
</html>
