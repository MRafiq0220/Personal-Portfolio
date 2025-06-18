<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Retrieve Patient</title>
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
            .form-container .back-button {
                background-color: #f4f4f4;
                color: black;
                border: 1px solid #ccc;
                text-align: center;
                text-decoration: none;
                padding: 10px;
                border-radius: 5px;
                margin-top: 10px;
            }
            .form-container .back-button:hover {
                background-color: #ddd;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Retrieve Patient</h2>
            <form action="updatepatient.jsp" method="get">
                <input type="text" id="ic" name="ic" placeholder="Enter IC Number" required>
                <input type="submit" value="Retrieve Patient">
            </form>
            <br>
            <a href="patientmenu.jsp" class="back-button">Back</a>
        </div>
    </body>
</html>
