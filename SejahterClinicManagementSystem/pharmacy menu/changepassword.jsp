<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Change Password</title>
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
            .form-container input[type="password"],
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
            <h2>Change Password</h2>
            <form action="changepasswordaction.jsp" method="post">
                <label for="currentPassword">Current Password:</label>
                <input type="password" id="currentPassword" name="current_password" placeholder="Current Password" required>
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="new_password" placeholder="New Password" required>
                <label for="confirmNewPassword">Confirm New Password:</label>
                <input type="password" id="confirmNewPassword" name="confirm_password" placeholder="Confirm New Password" required>
                <input type="submit" value="Change Password">
            </form>
            <button onclick="location.href = 'pharmacymenu.jsp'">Back to Menu</button>
        </div>
    </body>
</html>

