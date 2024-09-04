<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Add Student</title>
</head>
<body>
    <%
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String email = request.getParameter("email");
        String enrollmentDate = request.getParameter("enrollment_date");

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/StudentRecords", "root", "Susobhan");
            String sql = "INSERT INTO students (first_name, last_name, email, enrollment_date) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, email);
            pstmt.setDate(4, Date.valueOf(enrollmentDate));
            int rows = pstmt.executeUpdate();
            if(rows > 0) {
                out.println("<h3>Student added successfully!</h3>");
            } else {
                out.println("<h3>Failed to add student.</h3>");
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try { if(pstmt != null) pstmt.close(); } catch(SQLException e) {}
            try { if(conn != null) conn.close(); } catch(SQLException e) {}
        }
    %>
    <a href="index.jsp">Back to Home</a>
</body>
</html>
