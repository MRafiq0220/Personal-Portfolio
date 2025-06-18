<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Prescribe Medicine</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }
            .form-container {
                width: 400px;
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
            .form-container select,
            .form-container input[type="number"],
            .form-container textarea,
            .form-container input[type="submit"],
            .form-container input[readonly] {
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
        </style>
        <script>
            function updateMedicineDetails() {
                var medicineSelect = document.getElementById("medicineCode");
                var selectedOption = medicineSelect.options[medicineSelect.selectedIndex];
                var category = selectedOption.getAttribute("data-category");
                var price = selectedOption.getAttribute("data-price");

                document.getElementById("medicationCategory").value = category;
                document.getElementById("medicationPrice").value = price;
            }
        </script>
    </head>
    <body>
        <div class="form-container">
            <h2>Prescribe Medicine</h2>
            <form action="prescribemedicineaction.jsp" method="post">
                <input type="hidden" name="treatmentId" value="<%= request.getAttribute("treatmentId") %>" />
                <input type="hidden" name="patientIC" value="<%= request.getAttribute("patientIC") %>" />
                <select name="medicineCode" id="medicineCode" required onchange="updateMedicineDetails()">
                    <option value="">Select Medicine</option>
                    <!-- Dynamically populate medicine options -->
                    <% 
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        try {
                          Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
               conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");


                            String sql = "SELECT medication_Code, medication_Name, medication_Category, medication_Price FROM medication";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();

                            while (rs.next()) {
                                String medicineCode = rs.getString("medication_Code");
                                String medicineName = rs.getString("medication_Name");
                                String medicineCategory = rs.getString("medication_Category");
                                double medicinePrice = rs.getDouble("medication_Price");
                                out.println("<option value='" + medicineCode + "' data-category='" + medicineCategory + "' data-price='" + medicinePrice + "'>" + medicineName + "</option>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try { if (rs != null) rs.close(); } catch (SQLException e) { }
                            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { }
                            try { if (conn != null) conn.close(); } catch (SQLException e) { }
                        }
                    %>
                </select>
                <input type="text" id="medicationCategory" name="medicationCategory" placeholder="Medication Category" readonly />
                <input type="text" id="medicationPrice" name="medicationPrice" placeholder="Medication Price" readonly />
                <input type="number" name="quantity" placeholder="Quantity" required />
                <textarea name="usageMethod" placeholder="Usage Method" required></textarea>
                <input type="submit" value="Prescribe Medicine" />
            </form>
        </div>
    </body>
</html>
