<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Delete Medicine</title>
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
            .form-container label {
                margin: 5px 0 0;
                color: #333;
            }
            .form-container input[type="text"],
            .form-container input[type="number"],
            .form-container select,
            .form-container input[type="submit"],
            .form-container button {
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
            <h2>Delete Medicine</h2>
            <form action="deletemedicineaction.jsp" method="post">
                <input type="text" name="medicineID" placeholder="Medicine ID" required>
                <input type="submit" value="Delete Medicine">

            </form>
            <button onclick="location.href = 'medicinemenu.jsp'">Back to Menu</button>
        </div>
    </body>
</html>
