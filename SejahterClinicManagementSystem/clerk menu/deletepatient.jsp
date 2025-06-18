<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Delete Patient</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                padding: 20px;
            }
            .form-container {
                width: 400px;
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
            .form-container button {
                margin: 10px 0;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
                width: 100%;
            }
            .form-container button {
                background-color: #4CAF50;
                color: white;
                border: none;
            }
            .form-container button:hover {
                background-color: #45a049;
            }
            .form-container .back-button {
                background-color: #f44336;
                color: white;
                border: none;
            }
            .form-container .back-button:hover {
                background-color: #e53935;
            }
        </style>
        <script type="text/javascript">
            window.onload = function () {
                const urlParams = new URLSearchParams(window.location.search);
                const status = urlParams.get('status');
                if (status === 'success') {
                    alert('Patient record deleted successfully!');
                } else if (status === 'nopatient') {
                    alert('No patient found with the given IC.');
                } else if (status === 'error') {
                    alert('An error occurred. Please try again later.');
                }
            }
        </script>
    </head>
    <body>
        <div class="form-container">
            <h2>Delete Patient</h2>
            <form action="deletepatientaction.jsp" method="post">
                <div class="form-group">
                    <label for="ic">Patient IC:</label>
                    <input type="text" id="ic" name="ic" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary">Delete Patient</button>
            </form>
            <button class="back-button" onclick="location.href = 'patientmenu.jsp'">Back</button>
        </div>
    </body>
</html>
