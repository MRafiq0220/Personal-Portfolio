<%@ page import="java.sql.*" %>
<%
Connection con = null;
Statement s = null;
String ic = request.getParameter("ic");
 
Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
con = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

s = con.createStatement();
String sql = "SELECT * FROM patient WHERE patient_IC= '"+ic+"'"  ;		
System.out.println(sql);			
ResultSet rs = s.executeQuery(sql);
  if(!rs.next()) {
out.println("Sorry, could not find that publisher. ");
} else {
                       
                       
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Patient</title>
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
            .form-container input[type="text"],
            .form-container select,
            .form-container textarea,
            .form-container input[type="submit"] {
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
            <h2>Update Patient</h2>
            <form action="updatepatientaction.jsp" method="post">
                <input type="hidden" id="ic" name="ic" value="<%=rs.getString("patient_IC")%>">
                <input type="text" id="name" name="name" value="<%=rs.getString("patient_Name")%>" readonly>
                <input type="text" id="phone" name="phone" value="<%=rs.getString("patient_PhoneNumber")%>">
                <input type="text" id="address" name="address" value="<%=rs.getString("patient_Address")%>">
                <input type="text" id="allergy" name="allergy" value="<%=rs.getString("patient_Allergy")%>">
                <input type="submit" value="Update Patient">
            </form>
            <button onclick="location.href = 'findpatient.jsp'">Back to Menu</button>
        </div>

        <% } %>
    </body>
</html>
