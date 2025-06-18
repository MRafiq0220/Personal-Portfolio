<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Employee</title>
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
                margin: 5px 0 2px 0;
                color: #333;
            }
            .form-container input[type="text"],
            .form-container input[type="date"],
            .form-container input[type="password"],
            .form-container select,
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
            <h2>Add Employee</h2>
            <form action="addemployeeaction.jsp" method="post">
                <label for="ic">IC Number</label>
                <input type="text" id="ic" name="ic" placeholder="IC Number" required>
                <label for="name">Name</label>
                <input type="text" id="name" name="name" placeholder="Name" required>
                <label for="phone">Phone</label>
                <input type="text" id="phone" name="phone" placeholder="Phone" required>
                <label for="address">Address</label>
                <input type="text" id="address" name="address" placeholder="Address" required>
                <label for="dob">Date of Birth</label>
                <input type="date" id="dob" name="dob" placeholder="Date of Birth" required>
                <label for="gender">Gender</label>
                <select id="gender" name="gender" required>
                    <option value="" disabled selected>Select Gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                </select>
                <label for="role">Role</label>
                <select id="role" name="role" required>
                    <option value="" disabled selected>Select Role</option>
                    <option value="K">Clerk</option>
                    <option value="D">Doctor</option>
                    <option value="F">Pharmacy</option>
                </select>
                <label for="loginID">Login ID</label>
                <input type="text" id="loginID" name="loginID" placeholder="Login ID" required>
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Password" required>
                <input type="submit" value="Add Employee">
            </form>
            <br>
            <a href="employeemenu.jsp" class="back-button">Back</a>
        </div>
    </body>
</html>
