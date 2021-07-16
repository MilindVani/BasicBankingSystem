<!-- connect 'D:\BankingSystem.fdb' user 'SYSDBA' password 'root'; -->
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.IOException"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" type="text/css" href="bootstrap.min.css" >

<style> 
hr{
        height: 1.2px;
        background-color: #000000;
}
</style>


<meta charset="ISO-8859-1">
<title>Transaction</title>
</head>
<body style="background-color:  #ced4da">

	   <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
       <a class="navbar-brand" href="banklogo.jpg"> Dream Future Bank</a>
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
       
    <br><br>
    <center>
        <h1 style="background-color: #096675cf; color: black; font-size: 50px"> Transaction </h1>
    </center>
	<br><br>
	<%
	String id = request.getParameter("id");
	Integer ID = Integer.parseInt(id);
	Class.forName("org.firebirdsql.jdbc.FBDriver"); 
        try {
        	Connection con = DriverManager.getConnection("jdbc:firebirdsql://localhost:3050/D:/BankingSystem.fdb","SYSDBA", "root");
            Statement st = con.createStatement();
            String query = "SELECT * from Customer where Account_No= "+ID+" ";
            ResultSet rs = st.executeQuery(query);
            
            long senderAccountNo = 0;
            int senderAmount = 0;
            while (rs.next()) 
            {
            	senderAccountNo = rs.getLong("Account_No");
            	senderAmount = rs.getInt("CURRENT_BALANCE");
     %>
	
	     <div class="card" style="width: 30%; margin-left: 35%" >
              <div class="card-header"  >
                  <img src="bank.jpeg" alt="sys"  style="width: 100%"> 
              </div>
         <div class="card-body">
         <form method="post">
			  <div class="form-group">
			  	<label for="exampleInputEmail1">(SENDER)</label><br>
			    <label for="exampleInputEmail1">Name:</label>
			    <input style="background-color:  lightgrey; border:  1px solid black"  type="text" value="<%=rs.getString("Name")%>" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="username" placeholder="Enter Name">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputPassword1">Account Number:</label>
			    <input style="background-color: lightgrey; border: 1px solid black"  type="number" value="<%=rs.getInt("Account_No")%>" class="form-control" id="exampleInputPassword1" name="accountno.1" placeholder="Enter Account Number">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputPassword1">Amount To Transfer:</label>
			    <input style="background-color: lightgrey; border: 1px solid black" type="number" class="form-control" id="exampleInputPassword1" name="amount"placeholder="Enter Amount">
			  </div>
			  
			  <hr>
			  
			  <div class="form-group">
			  	<label for="exampleInputEmail1">(RECIVER)</label><br>
			  	<label for="exampleInputPassword1">Account Number:</label>
			    <input  style="background-color: lightgrey; border: 1px solid black" type="number" class="form-control" id="exampleInputPassword1" name="accountno.2" placeholder="Enter Account Number">
			  </div>
			  <center>
			  	<button type="submit" class="btn btn-primary">Transfer</button>
			  </center>
			</form>
              </div>
        </div>
        <br><br>
        <%
            } // while loop end.
        int Transferamount = Integer.parseInt(request.getParameter("amount"));
        String reciverAccount1 = request.getParameter("accountno.2");
        Integer reciverAccount = Integer.parseInt(reciverAccount1);
		
		String query1 = "SELECT * from Customer where Account_No = "+reciverAccount+" ";
		rs = st.executeQuery(query1);
		
		int reciverAmount = 0;
		long reciverAccountNo = 0;
        while (rs.next()) 
        {
        	reciverAccountNo = rs.getInt("Account_No");
            reciverAmount = rs.getInt("CURRENT_BALANCE");
        }
        if(Transferamount <= senderAmount)
		{
			int senderAmountChange = senderAmount - Transferamount;
	        int reciverAmountChange = reciverAmount + Transferamount;
	        
	        String query2 = "update Customer set CURRENT_BALANCE = "+senderAmountChange+" where ACCOUNT_NO = "+senderAccountNo+" "; 
	        String query3 = "update Customer set CURRENT_BALANCE = "+reciverAmountChange+" where ACCOUNT_NO = "+reciverAccountNo+" ";
	        int result1 = st.executeUpdate(query2);
	        int result2 = st.executeUpdate(query3);
	        if(result1 != 0 && result2 != 0)
	        {
	        	String query4 = "insert into Transfer values("+senderAccountNo+", "+reciverAccountNo+", "+Transferamount+" )";
		        int i = st.executeUpdate(query4);
		        
		        out.println("<script type=\"text/javascript\">");  
				out.println("alert('Transaction done successfully.');");
				out.println("location='ViewAllCustomer.jsp';");
				out.println("</script>");
				
			}
	        else
	        {
	        	out.println("<script type=\"text/javascript\">");  
				out.println("alert('Transaction Failed!');");
				out.println("</script>");
	        }
	    }
        else 
		{ 
        	out.println("<script type=\"text/javascript\">");  
			out.println("alert('Insufficinet amount!');");
			out.println("location='ViewAllCustomer.jsp';");
			out.println("</script>");
		}
        con.close();
        rs.close();
        st.close();
        }
            
        catch (Exception ex) {
            System.out.println(ex);
        }  
    %>
</body>
    <script type="text/javascript" src="jquery.js" ></script>
    <script type="text/javascript" src="bootstrap.min.js" ></script>
</html>