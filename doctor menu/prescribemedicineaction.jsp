<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Prescribe Medicine</title>
    </head>
    <body>
        <%
            String treatmentId = request.getParameter("treatmentId");
            String medicineCode = request.getParameter("medicineCode");
            String usageMethod = request.getParameter("usageMethod");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // Log start of the process
                out.println("Start processing...<br>");

                Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
                conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_mrafiq", "sql_mrafiq", "yDB5npdN8jXaZpL8");

                out.println("Database connection established.<br>");

                // Retrieve the price per unit of the medicine from the database
                double pricePerUnit = 0.0;
                String priceQuery = "SELECT medication_Price FROM medication WHERE medication_Code = ?";
                pstmt = conn.prepareStatement(priceQuery);
                pstmt.setString(1, medicineCode);
                rs = pstmt.executeQuery();
                out.println("Executed price query.<br>");

                if (rs.next()) {
                    pricePerUnit = rs.getDouble("medication_Price");
                    out.println("Medicine price retrieved: " + pricePerUnit + "<br>");
                } else {
                    out.println("<script>alert('Error: Medicine code not found in database.'); window.location.href='doctormenu.jsp';</script>");
                    return;
                }
                rs.close();
                pstmt.close();

                // Calculate the total price
                double totalPrice = pricePerUnit * quantity;
                out.println("Total price calculated: " + totalPrice + "<br>");

                // Check if there is enough stock
                int currentStock = 0;
                String stockQuery = "SELECT stockMedication_Quantity FROM stockmedication WHERE stockMedication_medicationCode = ?";
                pstmt = conn.prepareStatement(stockQuery);
                pstmt.setString(1, medicineCode);
                rs = pstmt.executeQuery();
                out.println("Executed stock query.<br>");

                if (rs.next()) {
                    currentStock = rs.getInt("stockMedication_Quantity");
                    out.println("Current stock: " + currentStock + "<br>");
                } else {
                    out.println("<script>alert('Error: Medication stock not found in database.'); window.location.href='doctormenu.jsp';</script>");
                    return;
                }
                rs.close();
                pstmt.close();

                if (currentStock < quantity) {
                    out.println("<script>alert('Insufficient stock for the medicine.'); window.location.href='doctormenu.jsp';</script>");
                } else {
                    // Update the stock
                    String updateStockQuery = "UPDATE stockmedication SET stockMedication_Quantity = stockMedication_Quantity - ? WHERE stockMedication_medicationCode = ?";
                    pstmt = conn.prepareStatement(updateStockQuery);
                    pstmt.setInt(1, quantity);
                    pstmt.setString(2, medicineCode);
                    int stockUpdateResult = pstmt.executeUpdate();
                    pstmt.close();
                    out.println("Updated stock.<br>");

                    if (stockUpdateResult > 0) {
                        // Insert the prescription details into the dispensemedication table
                        String insertQuery = "INSERT INTO dispensemedication (dispenseMedication_IdTreatment, dispenseMedication_medicationCode, dispenseMedication_UsageMethod, dispenseMedication_Quantity, dispenseMedication_TotalPrice) VALUES (?, ?, ?, ?, ?)";
                        pstmt = conn.prepareStatement(insertQuery);
                        pstmt.setInt(1, Integer.parseInt(treatmentId));
                        pstmt.setString(2, medicineCode);
                        pstmt.setString(3, usageMethod);
                        pstmt.setInt(4, quantity);
                        pstmt.setDouble(5, totalPrice);

                        int result = pstmt.executeUpdate();
                        pstmt.close();
                        out.println("Inserted prescription details.<br>");

                        if (result > 0) {
                            // Update payment information
                            String paymentSql = "INSERT INTO payment (payment_IdTreatment, payment_Status, payment_TotalPayment) VALUES (?, 'In Progress', ?)";
                            pstmt = conn.prepareStatement(paymentSql);
                            pstmt.setInt(1, Integer.parseInt(treatmentId));
                            pstmt.setDouble(2, totalPrice);

                            // Log the prepared statement
                            out.println("Executing payment insertion: " + pstmt + "<br>");

                            try {
                                int paymentResult = pstmt.executeUpdate();
                                pstmt.close();
                                out.println("Payment record result: " + paymentResult + "<br>");

                                if (paymentResult > 0) {
                                    out.println("<script>alert('Medicine prescribed and payment record updated successfully. Total Price: " + new DecimalFormat("#.##").format(totalPrice) + "'); window.location.href='doctormenu.jsp';</script>");
                                } else {
                                    out.println("<script>alert('Failed to update payment record.'); window.location.href='doctormenu.jsp';</script>");
                                }
                            } catch (SQLException e) {
                                out.println("SQLState: " + e.getSQLState() + "<br>");
                                out.println("Error Code: " + e.getErrorCode() + "<br>");
                                out.println("Message: " + e.getMessage() + "<br>");
                                e.printStackTrace();
                                out.println("<script>alert('Failed to update payment record: " + e.getMessage() + "'); window.location.href='doctormenu.jsp';</script>");
                            }
                        } else {
                            out.println("<script>alert('Failed to prescribe medicine.'); window.location.href='doctormenu.jsp';</script>");
                        }
                    } else {
                        out.println("<script>alert('Error updating medication stock.'); window.location.href='doctormenu.jsp';</script>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('Error prescribing medicine: " + e.getMessage() + "'); window.location.href='doctormenu.jsp';</script>");
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </body>
</html>
