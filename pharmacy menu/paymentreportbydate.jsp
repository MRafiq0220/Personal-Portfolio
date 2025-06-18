<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Payment Report by Date</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #e9f7ef; /* Light green background */
                font-family: 'Arial', sans-serif;
            }
            .container {
                margin-top: 50px;
                background-color: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h2 {
                color: #28a745; /* Green text */
            }
            form {
                margin-top: 20px;
            }
            .form-group label {
                font-weight: bold;
            }
            .btn-primary {
                background-color: #28a745;
                border-color: #28a745;
            }
            .btn-primary:hover {
                background-color: #218838;
                border-color: #1e7e34;
            }
            .btn-secondary {
                background-color: #6c757d;
                border-color: #6c757d;
            }
            .btn-secondary:hover {
                background-color: #5a6268;
                border-color: #545b62;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center">Payment Report by Date</h2>
            <form action="paymentreportbydateaction.jsp" method="post">
                <div class="form-group">
                    <label for="startDate">Start Date:</label>
                    <input type="date" class="form-control" id="startDate" name="startDate" required>
                </div>
                <div class="form-group">
                    <label for="endDate">End Date:</label>
                    <input type="date" class="form-control" id="endDate" name="endDate" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Get Report</button>
                <button type="button" class="btn btn-secondary btn-block" onclick="window.history.back();">Back</button>
            </form>
        </div>
    </body>
</html>
