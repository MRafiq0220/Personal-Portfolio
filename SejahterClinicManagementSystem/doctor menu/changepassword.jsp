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
                background-color: #ccc;
                color: #333;
                border: none;
            }
            .form-container button:hover {
                background-color: #bbb;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Change Password</h2>
            <form action="changedoctorpasswordaction.jsp" method="post">
                <label for="currentPassword">Current Password:</label>
                <input type="password" name="current_password" placeholder="Current Password" required><br>
                <label for="newPassword">New Password:</label>
                <input type="password" name="new_password" placeholder="New Password" required><br>
                <label for="confirmNewPassword">Confirm New Password:</label>
                <input type="password" name="confirm_password" placeholder="Confirm New Password" required><br>
                <input type="submit" value="Change Password">
            </form>
            <button type="button" onclick="location.href='doctormenu.jsp'">Back</button>
        </div>
    </body>
</html>
