<%@ page import="java.sql.*, java.io.*" %>
<%
    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    String ic = request.getParameter("ic");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String dob = request.getParameter("dob");
    String regDate = request.getParameter("regDate");
    String regTime = request.getParameter("regTime");
    String gender = request.getParameter("gender");
    String allergy = request.getParameter("allergy");

    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
      conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

        String sql = "INSERT INTO patient (patient_IC, patient_Name, patient_Gender, patient_PhoneNumber, patient_DateOfBirth, patient_RegistrationDate, patient_RegistrationTime, patient_Address, patient_Allergy) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pst = conn.prepareStatement(sql);
        pst.setString(1, ic);
        pst.setString(2, name);
        pst.setString(3, gender);
        pst.setString(4, phone);
        pst.setDate(5, Date.valueOf(dob));
        pst.setDate(6, Date.valueOf(regDate));

        // Ensure regTime is in the correct format
        try {
            pst.setTime(7, Time.valueOf(regTime + ":00")); // Add seconds to ensure format is HH:MM:SS
        } catch (IllegalArgumentException e) {
            pst.setTime(7, new Time(System.currentTimeMillis())); // Set current time if format is incorrect
        }

        pst.setString(8, address);
        pst.setString(9, allergy);

        int row = pst.executeUpdate();

        if (row > 0) {
            out.println("<script>alert('Patient added successfully');</script>");
            out.println("<script>window.location.href = 'addpatient.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to add patient');</script>");
        }
    } catch (Exception e) {
        StringWriter sw = new StringWriter();
        e.printStackTrace(new PrintWriter(sw));
        String stackTrace = sw.toString();

        out.println("<p>Error: " + e.getMessage() + "</p>");
        out.println("<pre>" + stackTrace + "</pre>"); // Print the stack trace for debugging purposes
    } finally {
        if (pst != null) {
            try {
                pst.close();
            } catch (SQLException e) { /* ignored */ }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) { /* ignored */ }
        }
    }
%>
