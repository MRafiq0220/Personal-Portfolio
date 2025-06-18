<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Medicine Menu</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }
            .menu {
                width: 300px;
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
            }
            .menu a:hover {
                background-color: #e9e9e9;
            }
            .menu button {
                width: 100%;
                padding: 10px;
                margin-top: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #f9f9f9;
                cursor: pointer;
            }
            .menu button:hover {
                background-color: #e9e9e9;
            }
        </style>
    </head>
    <body>
        <div class="menu">
            <h2>Medicine Menu</h2>
            <ul>
                <li><a href="addmedicine.jsp">Add Medicine</a></li>
                <li><a href="retrievemedicine.jsp">Update Medicine</a></li>
                <li><a href="deletemedicine.jsp">Delete Medicine</a></li>
            </ul>
            <button onclick="location.href = 'pharmacymenu.jsp'">Back to Menu</button>

        </div>
    </body>
</html>
