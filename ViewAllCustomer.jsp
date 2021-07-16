<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="bootstrap.min.css">
<meta charset="ISO-8859-1">
<title> View Customer </title>
</head>
<body style="background-color: #ced4da">
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
       <a class="navbar-brand" href="banklogo.jpg"> Dream Future Bank</a>
	 	<!--<img class="d-block w-100" src="bank1.jpg" alt="First slide" style = " height: 10px">-->
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Dropdown
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="ViewAllCustomer.jsp">View All Customers</a>
                        <a class="dropdown-item" href="TransferMoneyHome.jsp">Transfer Money</a>
                    </div>
                    
                    <li class="nav-item active">
                    <a class="nav-link" href="#"> About Us <span class="sr-only">(current)</span></a>
         
                </li>
                </li>
            </ul>
        </div>
    </nav>
    <br>    
    <br>
    <center>
        <h1 style="background-color: #096675cf; color: black; font-size: 50px" >Details of Customer</h1>
    </center>
    <br>
        <%
        Class.forName("org.firebirdsql.jdbc.FBDriver"); 
        try
        {
            Connection con = DriverManager.getConnection("jdbc:firebirdsql://localhost:3050/D:/BankingSystem.fdb","SYSDBA", "root");
            Statement st = con.createStatement();
            String query = "select * from customer";
            ResultSet rs = st.executeQuery(query);
        %>
            <div class="row">
            <%
            while(rs.next())
            {
            	long id = rs.getLong("Account_No");
                String name = rs.getString("NAME");
                request.setAttribute("id",id);
                System.out.println("----------------------------------" +  id);
            %>
                 <div class="column" >
                     <div class="card" style="width: 20rem; margin-left: 7rem; border-radius:25px; margin-top:5%">
                        <img class="card-img-top" src="bank.jpeg" style="border-radius:25px" alt="Card image cap" >
                        <div class="card-body" style="backgroundcolor: grey">
                            <h5 class="card-title" style="text-align: center"><%=name%></h5>
                          <p class="card-text" style="text-align: center"><%=id%></p>
                          <!-- Large modal -->
                          <div class="row" style="">
                          <a href="ViewDetail.jsp?id=<%=id%>" style="margin-left: 20%; border-radius:25px"  class="btn btn-primary">View</a>
                          <div class="column">
                              <a href="TransferMoney.jsp?id=<%=id%>" style="margin-left: 8%; border-radius:25px" class="btn btn-info">Transaction</a>
                          </div>
                          </div>
                        </div>
                     </div>
                 </div>
            <%
            }
            %>
            </div>
            <% 
            con.close();
            rs.close();
            st.close();
        }
        catch(Exception ex)
        {
            System.out.println(ex);
        }%>
	
</body>

	<script type="text/javascript" src="jquery.js" ></script>
    <script type="text/javascript" src="bootstrap.min.js" ></script>
	
</html>