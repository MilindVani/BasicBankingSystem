<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="bootstrap.min.css">

<style> 
hr{
        height: 1.2px;
        background-color: #000000;
}
</style>

<meta charset="ISO-8859-1">
<title>View Detail</title>
</head>
<body style="background-color: #ced4da">
    
   	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    	<a class="navbar-brand" href="banklogo.jpg"> Dream Future Bank</a>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
	            <ul class="navbar-nav mr-auto">
	                <li class="nav-item active">
	                    <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
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
    
    
    <br><br>
    <center>
	    <h1 style="background-color: #096675cf; color: black; font-size: 55px">Customer Details</h1>
	</center>
	<br><br>
		
	<%
	String id = request.getParameter("id");
	Integer ID = Integer.parseInt(id);
	Class.forName("org.firebirdsql.jdbc.FBDriver"); 
    try
    {
  		Connection con = DriverManager.getConnection("jdbc:firebirdsql://localhost:3050/D:/BankingSystem.fdb","SYSDBA", "root");
	    Statement st = con.createStatement();
	    String query = "select * from customer where Account_No =  "+ID+" ";
	    ResultSet rs = st.executeQuery(query);
	    while(rs.next())
	    {
	%>
         
       <div class="card" style="width: 27rem; margin-left: 33%">
       		<img class="card-img-top" src="bank.jpeg"  alt="Card image cap">
       <div class="card-body">
           <form>
               <div class="form-group">
                   <label for="inputEmail4">Name</label>
                   <input type="lable" class="form-control"style="border: 1px solid black" value="<%=rs.getString("Name")%>"  id="inputEmail4" placeholder="Email" readonly="true">
               </div>
               <div class="form-group">
                   <label for="inputPassword4">Account Number</label>
                   <input type="lable" class="form-control" style="border: 1px solid black" id="input"passwordPassword4"  value="<%=rs.getLong("Account_No")%>" placeholder="Password"  readonly="true">
               </div>
               <div class="form-group">
                 <label for="inputAddress">Email</label>
                 <input type="lable" class="form-control" style="border: 1px solid black" id="inputAddress"  value="<%=rs.getString("Email")%>" placeholder="email@gmail.com"  readonly="true">
               </div>
               <div class="form-group">
                 <label for="inputAddress2">Phone Number</label>
                 <input type="lable" class="form-control" style="border: 1px solid black" value="<%=rs.getLong("Phone_No")%>" id="inputAddress2" placeholder="Phn no"  readonly="true">
               </div>
               <div class="form-group ">
               	  <label for="inputCity">Current Balance</label>
                  <input type="text"  class="form-control" style="border: 1px solid black" value="<%=rs.getInt("Current_Balance")%>"  id="inputCity"  readonly="true">
               </div>
               <center>
               <a href="ViewAllCustomer.jsp"  class="btn btn-primary">Back</a>
               </center>
           </form>
       </div>
   	   </div>      
       <br><br>
    <%
       }
       con.close();
       rs.close();
       st.close();
   }
   catch(Exception ex)
   {
       System.out.println(ex);
   }
   %>  
</body>

    <script type="text/javascript" src="jquery.js" ></script>
    <script type="text/javascript" src="bootstrap.min.js" ></script>
    
</html>