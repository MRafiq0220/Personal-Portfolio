<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Medicine</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }
            .form-container {
                width: 300px;
                margin: 50px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .form-container h2 {
                text-align: center;
                color: #333;
            }
            .form-container form {
                display: flex;
                flex-direction: column;
            }
            .form-container label {
                margin: 5px 0 0;
                color: #333;
            }
            .form-container input[type="text"],
            .form-container input[type="number"],
            .form-container select,
            .form-container input[type="submit"],
            .form-container button {
                margin: 10px 0;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            .form-container input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                border: none;
            }
            .form-container input[type="submit"]:hover {
                background-color: #45a049;
            }
            .form-container button {
                background-color: #f4f4f4;
                color: #333;
                border: none;
            }
            .form-container button:hover {
                background-color: #e7e7e7;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Update Medicine</h2>
            <%
                String medicineId = request.getParameter("medicineId");
                String medicineName = "";
                String medicineCategory = "";
                int medicineStock = 0;
                double medicinePrice = 0.0;

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
          Class.forName("com.mysql.cj.jdbc.Driver");
             conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

                    String sql = "SELECT medication_Name, medication_Category, medication_Price, stockMedication_Quantity FROM medication JOIN stockmedication ON medication_Code = stockMedication_medicationCode WHERE medication_Code = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, medicineId);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        medicineName = rs.getString("medication_Name");
                        medicineCategory = rs.getString("medication_Category");
                        medicinePrice = rs.getDouble("medication_Price");
                        medicineStock = rs.getInt("stockMedication_Quantity");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
            <form action="updatemedicineaction.jsp" method="post">
                <input type="hidden" name="medicineId" value="<%= medicineId %>" required>
                <label for="medicineName">Medicine Name</label>
                <input type="text" id="medicineName" name="medicineName" placeholder="Medicine Name" value="<%= medicineName %>" required>
                <label for="medicineCategory">Medicine Category</label>
                <input type="text" id="medicineCategory" name="medicineCategory" placeholder="Medicine Category" value="<%= medicineCategory %>" required>
                <label for="quantity">Quantity</label>
                <input type="number" id="quantity" name="quantity" placeholder="Quantity" value="<%= medicineStock %>" required>
                <label for="price">Price</label>
                <input type="number" id="price" name="price" placeholder="Price" value="<%= medicinePrice %>" required>
                <input type="submit" value="Update Medicine">
            </form>
            <button onclick="location.href = 'medicinemenu.jsp'">Back to Menu</button>
        </div>
    </body>
</html>
