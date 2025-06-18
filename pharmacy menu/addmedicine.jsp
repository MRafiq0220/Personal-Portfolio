<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Medicine</title>
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
            <h2>Add Medicine</h2>
            <form action="addmedicineaction.jsp" method="post">
                <label for="medicineCode">Medicine Code:</label>
                <input type="text" id="medicineCode" name="medicineCode" placeholder="Medicine Code" required>
                <label for="medicineName">Medicine Name:</label>
                <input type="text" id="medicineName" name="medicineName" placeholder="Medicine Name" required>
                <label for="medicineCategory">Medicine Category:</label>
                <select id="medicineCategory" name="medicineCategory" required>
                    <option value="">Select Category</option>
                    <option value="D">Fever (D)</option>
                    <option value="A">Antibiotic (A)</option>
                    <option value="S">Cold (S)</option>
                    <option value="SF">Nervous (SF)</option>
                    <option value="TS">Pain Relief (TS)</option>
                </select>
                <label for="quantity">Stock Quantity:</label>
                <input type="number" id="quantity" name="quantity" placeholder="Quantity" required>
                <label for="price">Price:</label>
                <input type="number" id="price" name="price" placeholder="Price" required>
                <input type="submit" value="Add Medicine">
            </form>
            <button onclick="location.href = 'pharmacymenu.jsp'">Back to Menu</button>
        </div>
    </body>
</html>
