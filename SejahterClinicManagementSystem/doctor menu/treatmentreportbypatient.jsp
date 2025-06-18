<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Treatment Report by Patient</title>
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
                text-align: center;
            }
            .form-container h2 {
                color: #333;
            }
            .form-container form {
                display: flex;
                flex-direction: column;
            }
            .form-container input[type="text"],
            .form-container input[type="submit"],
            .form-container .back-button {
                margin: 20px 0;
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
            .back-button {
                background-color: #f44336;
                color: white;
                border: none;
                cursor: pointer;
                text-decoration: none;
            }
            .back-button:hover {
                background-color: #e53935;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Treatment Report by Patient</h2>
            <form action="treatmentreportbypatientaction.jsp" method="post">
                <input type="text" name="patientId" placeholder="Patient IC" required />
                <input type="submit" value="Generate Report" />
            </form>
            <a class="back-button" href="reportmenu.jsp">Back</a>
        </div>
    </body>
</html>
