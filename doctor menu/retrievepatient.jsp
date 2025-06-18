<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Retrieve Patient</title>
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
                text-align: center;
            }
            .form-container h2 {
                color: #333;
            }
            .form-container form {
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .form-container label {
                margin-top: 10px;
                width: 100%;
                text-align: left;
            }
            .form-container input[type="text"],
            .form-container input[type="submit"],
            .form-container button,
            .form-container textarea {
                margin: 10px 0;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                width: 100%;
            }
            .form-container input[type="submit"],
            .form-container button {
                background-color: #4CAF50;
                color: white;
                border: none;
            }
            .form-container input[type="submit"]:hover,
            .form-container button:hover {
                background-color: #45a049;
            }
            .back-button {
                margin-top: 20px;
                background-color: #f44336;
                color: white;
            }
            .back-button:hover {
                background-color: #e53935;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Retrieve Patient Information</h2>
            <form action="retrievepatient.jsp" method="post">
                <label for="patientIC">Patient IC</label>
                <input type="text" id="patientIC" name="patientIC" placeholder="Patient IC" required />
                <button type="submit">Retrieve Patient</button>
            </form>
            <button class="back-button" onclick="location.href='treatmentandprescription.jsp'">Back</button>
            <%
                String patientIC = request.getParameter("patientIC");
                if (patientIC != null) {
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                        conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

                        String sql = "SELECT * FROM patient WHERE patient_IC = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, patientIC);
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            String patientName = rs.getString("patient_name");
                            String patientAddress = rs.getString("patient_address");

                            // Retrieve doctor login ID (assuming it's stored in session after login)
                            String doctorLoginID = (String) session.getAttribute("loginID");

                            if (doctorLoginID != null && doctorLoginID.startsWith("D")) {
                                // Get employeeIC based on doctorLoginID
                                String sqlDoctor = "SELECT employee_IC FROM employee WHERE employee_loginID = ?";
                                pstmt = conn.prepareStatement(sqlDoctor);
                                pstmt.setString(1, doctorLoginID);
                                ResultSet rsDoctor = pstmt.executeQuery();

                                if (rsDoctor.next()) {
                                    String employeeIC = rsDoctor.getString("employee_IC");

                                    out.println("<p>Patient Name: " + patientName + "</p>");
                                    out.println("<p>Patient Address: " + patientAddress + "</p>");

                                    // Hidden form to submit treatment details
                                    out.println("<form action='submittreatment.jsp' method='post'>");
                                    out.println("<input type='hidden' name='patientIC' value='" + patientIC + "' />");
                                    out.println("<input type='hidden' name='employeeIC' value='" + employeeIC + "' />");
                                    out.println("<label for='illness'>Illness</label>");
                                    out.println("<textarea id='illness' name='illness' placeholder='Illness' required></textarea>");
                                    out.println("<input type='submit' value='Submit Treatment' />");
                                    out.println("</form>");
                                } else {
                                    out.println("<p>Doctor not found in the system.</p>");
                                }
                            } else {
                                out.println("<p>Invalid doctor login ID.</p>");
                            }
                        } else {
                            out.println("<p>Patient not found.</p>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error retrieving patient information.</p>");
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException e) { }
                        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { }
                        try { if (conn != null) conn.close(); } catch (SQLException e) { }
                    }
                }
            %>
        </div>
    </body>
</html>
