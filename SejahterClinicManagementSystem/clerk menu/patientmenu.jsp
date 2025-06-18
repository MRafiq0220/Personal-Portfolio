<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Clerk Menu</title>
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
            .menu {
                width: 100%;
                max-width: 600px;
                margin: 50px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
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
            .back-button {
                background-color: #f4f4f4;
                color: black;
                border: 1px solid #ccc;
                text-align: center;
                text-decoration: none;
                padding: 10px;
                border-radius: 5px;
                display: block;
                margin-top: 20px;
            }
            .back-button:hover {
                background-color: #ddd;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="menu">
                <h2>Patient Menu</h2>
                <ul>
                    <li><a href="addpatient.jsp">Add Patient</a></li>
                    <li><a href="findpatient.jsp">Update Patient</a></li>
                    <li><a href="deletepatient.jsp">Delete Patient</a></li>
                </ul>
                <a href="clerkmenu.jsp" class="back-button">Back</a>
            </div>

        </div>
    </body>
</html>
