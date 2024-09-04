<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Student Records</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Add New Student</h2>
    <form action="addStudent.jsp" method="post">
        First Name: <input type="text" name="first_name" required><br>
        Last Name: <input type="text" name="last_name" required><br>
        Email: <input type="email" name="email" required><br>
        Enrollment Date: <input type="date" name="enrollment_date" required><br>
        <input type="submit" value="Add Student">
    </form>

    <h2>Existing Student Records</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Enrollment Date</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("org.mariadb.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/StudentRecords", "root", "Susobhan");
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM students");
                
                while(rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("id") + "</td>");
                    out.println("<td>" + rs.getString("first_name") + "</td>");
                    out.println("<td>" + rs.getString("last_name") + "</td>");
                    out.println("<td>" + rs.getString("email") + "</td>");
                    out.println("<td>" + rs.getDate("enrollment_date") + "</td>");
                    out.println("</tr>");
                }
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                try { if(rs != null) rs.close(); } catch(SQLException e) {}
                try { if(stmt != null) stmt.close(); } catch(SQLException e) {}
                try { if(conn != null) conn.close(); } catch(SQLException e) {}
            }
        %>
    </table>
</body>
</html>
