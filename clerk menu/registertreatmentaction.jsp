<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%
    String patientIC = request.getParameter("patientIC");
    String doctorID = request.getParameter("doctorID");
    String treatmentDescription = request.getParameter("treatmentDescription");

    if (patientIC == null || doctorID == null || treatmentDescription == null) {
%>
<script>
    alert("Missing required parameters!");
    window.location.href = "registertreatment.jsp"; // Redirect back to treatment registration page
</script>
<%
    } else {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

            // Check if doctorID exists in employee table
            String checkSql = "SELECT COUNT(*) FROM employee WHERE employee_IC = ?";
            pstmt = con.prepareStatement(checkSql);
            pstmt.setString(1, doctorID);
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count == 0) {
%>
<script>
    alert("The provided doctorID does not exist in the employee table.");
    window.location.href = "registertreatment.jsp"; // Redirect back to treatment registration page
</script>
<%
                return;
            }

            // Close previous statement and result set
            pstmt.close();
            rs.close();

            String sql = "INSERT INTO treatment (treatment_PatientIC, treatment_EmployeeIC, treatment_Illness, treatment_Date, treatment_Time) VALUES (?, ?, ?, ?, ?)";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, patientIC);
            pstmt.setString(2, doctorID);
            pstmt.setString(3, treatmentDescription);

            // Get the current date and time
            String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
            String currentTime = new SimpleDateFormat("HH:mm:ss").format(new Date());
            pstmt.setString(4, currentDate);
            pstmt.setString(5, currentTime);

            int rowsInserted = pstmt.executeUpdate();

            if (rowsInserted > 0) {
%>
<script>
    alert("Treatment registered successfully!");
    window.location.href = "registertreatment.jsp"; // Redirect back to treatment registration page
</script>
<%
            } else {
%>
<script>
    alert("Failed to register treatment.");
    window.location.href = "registertreatment.jsp"; // Redirect back to treatment registration page
</script>
<%
            }
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
%>
<script>
    alert("Error occurred: <%= e.getMessage() %>");
    window.location.href = "registertreatment.jsp"; // Redirect back to treatment registration page
</script>
<%
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>
