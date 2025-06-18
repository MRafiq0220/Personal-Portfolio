<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Report Menu</title>
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
                text-align: center;
            }
            .menu h2 {
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
                background-color: #f9f9f9;
            }
            .menu a:hover {
                background-color: #e9e9e9;
            }
            .back-button {
                margin-top: 20px;
                background-color: #f44336;
                color: white;
                border: none;
                padding: 10px;
                border-radius: 5px;
                display: inline-block;
                text-align: center;
                cursor: pointer;
                text-decoration: none;
            }
            .back-button:hover {
                background-color: #e53935;
            }
        </style>
    </head>
    <body>
        <div class="menu">
            <h2>Report Menu</h2>
            <ul>
                <li><a href="treatmentreportbypatient.jsp">Treatment Report by Patient</a></li>
                <li><a href="dispensingreportbypatient.jsp">Medicine Dispensing Report by Patient</a></li>
            </ul>
            <a class="back-button" href="doctormenu.jsp">Back</a>
        </div>
    </body>
</html>
