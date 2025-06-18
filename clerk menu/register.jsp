<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Account Registration</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('bgregister.jpg') no-repeat center center fixed;
            background-size: cover;
            padding: 20px;
        }
        .form-container {
            width: 500px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.8); /* Slight transparency for readability */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .form-container form {
            display: flex;
            flex-direction: column;
        }
        .form-container .form-group {
            margin-bottom: 15px;
        }
        .form-container label {
            font-weight: bold;
        }
        .form-container input[type="text"],
        .form-container input[type="password"],
        .form-container input[type="date"],
        .form-container select,
        .form-container button {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .form-container button {
            background-color: #4CAF50;
            color: white;
            border: none;
            margin-top: 10px;
        }
        .form-container button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Account Registration</h2>
        <form action="registeraction.jsp" method="post">
            <div class="form-group">
                <label for="ic">IC:</label>
                <input type="text" class="form-control" id="ic" name="ic" required>
            </div>
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="gender">Gender:</label>
                <select class="form-control" id="gender" name="gender" required>
                    <option value="">Select Gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                </select>
            </div>
            <div class="form-group">
                <label for="phone">Phone Number:</label>
                <input type="text" class="form-control" id="phone" name="phone" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" class="form-control" id="address" name="address" required>
            </div>
            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" class="form-control" id="dob" name="dob" required>
            </div>
            <div class="form-group">
                <label for="position">Position:</label>
                <select class="form-control" id="position" name="position" required>
                    <option value="">Select Position</option>
                    <option value="K">Clerk</option>
                    <option value="D">Doctor</option>
                    <option value="F">Pharmacy</option>
                </select>
            </div>
            <div class="form-group">
                <label for="login_id">Login ID:</label>
                <input type="text" class="form-control" id="login_id" name="login_id" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
            </div>
            <button type="submit" class="btn btn-primary">Register</button>
        </form>
    </div>
</body>
</html>
