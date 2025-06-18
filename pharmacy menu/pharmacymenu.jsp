<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*, java.sql.*" %>
<%
    // No need to declare the session object, it's already available implicitly
    // HttpSession session = request.getSession(false);

    if (session == null || session.getAttribute("loginID") == null) {
        // Redirect to login page if session is invalid or loginID attribute is not found
        response.sendRedirect("../login.jsp");
        return;
    }

    // Get the loginID from the session
    String loginID = (String) session.getAttribute("loginID");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Pharmacy Menu</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: url('bgpharmacy.jpg') no-repeat center center fixed;
                background-size: cover;
                margin: 0;
                padding: 0;
            }
            .container {
                width: 100%;
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            .menu {
                width: 100%;
                max-width: 600px;
                margin: 50px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: rgba(255, 255, 255, 0.8);
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .menu h2 {
                text-align: center;
                color: #333;
            }
            .menu ul {
                list-style-type: none;
                padding: 0;
            }
            .menu li {
                margin: 10px 0;
            }
            .menu a {
                text-decoration: none;
                color: #333;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                display: block;
                text-align: center;
                background-color: #f9f9f9;
                transition: background-color 0.3s;
            }
            .menu a:hover {
                background-color: #e9e9e9;
            }
            .welcome-message {
                text-align: center;
                margin-bottom: 20px;
                font-size: 18px;
                color: #555;
            }
            .logout-button {
                text-align: center;
                margin-top: 20px;
            }
            .logout-button form {
                display: inline;
            }
            .logout-button input[type="submit"] {
                padding: 10px 20px;
                background-color: #dc3545;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .logout-button input[type="submit"]:hover {
                background-color: #c82333;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="menu">
                <h2>Pharmacy Menu</h2>
                <div class="welcome-message">
                    Welcome, <%= session.getAttribute("loginID") %>!
                </div>
                <ul>
                    <li><a href="updatepharmacy.jsp?loginID=<%= loginID %>">Update Pharmacy Profile</a></li>
                    <li><a href="changepassword.jsp">Change Password</a></li>
                    <li><a href="medicinemenu.jsp">Medicine Menu</a></li>
                    <li><a href="paymentmenu.jsp">Payment Menu</a></li>
                    <li><a href="reportmenu.jsp">Report Menu</a></li>
                </ul>
                <div class="logout-button">
                    <form action="../logout.jsp" method="post">
                        <input type="submit" value="Logout">
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
