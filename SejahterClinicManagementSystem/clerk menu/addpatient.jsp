<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Patient</title>
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
            .form-container input[type="date"],
            .form-container input[type="time"],
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
        <script>
            window.onload = function () {
                var now = new Date();
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);
                var time = ("0" + now.getHours()).slice(-2) + ":" + ("0" + now.getMinutes()).slice(-2);
                document.getElementById('regDate').value = today;
                document.getElementById('regTime').value = time;
            }
        </script>
    </head>
    <body>
        <div class="form-container">
            <h2>Add Patient</h2>
            <form action="addpatientaction.jsp" method="post">
                <input type="text" id="ic" name="ic" placeholder="IC Number" required>
                <input type="text" id="name" name="name" placeholder="Name" required>
                <input type="text" id="phone" name="phone" placeholder="Phone Number" required>
                <input type="text" id="address" name="address" placeholder="Address" required>
                <input type="date" id="dob" name="dob" placeholder="Date of Birth" required>
                <input type="date" id="regDate" name="regDate" required readonly>
                <input type="time" id="regTime" name="regTime" required readonly>
                <select id="gender" name="gender" required>
                    <option value="" disabled selected>Select Gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                </select>
                <input type="text" id="allergy" name="allergy" placeholder="Allergy">
                <input type="submit" value="Add Patient">
            </form><br>
            <a href="patientmenu.jsp" class="back-button">Back</a>
        </div>
    </body>
</html>
