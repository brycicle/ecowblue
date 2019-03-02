<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.neil.ecoblue.model.Account" %>
<%@ page import="com.neil.ecoblue.model.Transaction" %>
<%@ page import="java.util.List" %>
<%
    Account account = (Account) session.getAttribute("account");
    //kailangan to ngayon kasi nag if else ako sa baba
    List<Transaction> list = (List<Transaction>)request.getAttribute("list");
%>
<!doctype html>
<html lang="en">
<head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/jq-3.3.1/dt-1.10.18/datatables.min.css"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<link href="/css/ecoblue.css" rel="stylesheet" />
</head>
<body>
<div class="wrapper">
    <!-- Sidebar  -->
    <jsp:include page="sidebar.jsp"/>

    <!-- Page Content  -->
    <div id="content">

		<div class="">
		    <div class="row justify-content-center mt-5">
		        <div class="card col-10 shadow p-3 mb-5 transparent-card rounded">
		            <h5 class="card-title">Transaction History</h5>
		            <div class="card-body">
						<table id="table" class="table table-striped table-bordered" style="width:100%">
		                    <%--For Loop para sa transaction history--%>
								<thead>
									<tr>
										<th>Type</th>
										<th>Email</th>
										<th>Account Name</th>
										<th>Date</th>
										<th>Qty</th>
										<th>Value</th>
										<th>Item Name</th>
									</tr>
								</thead>
								<tbody>
		                    <%for(Transaction transaction : list){%>
									<%--Naka hiwalay kasi null yung item sa redeem type and null naman redeem sa convert type--%>
									<%--IF transaction Type ==1///////CONVERT TYPE TRANSACTION--%>
									<% if(transaction.getTransactionType()==1){%>
										<tr>
											<td>Convert</td>
											<td><%=transaction.getAccount().getEmail()%></td>
											<td><%=transaction.getAccount().getFirstName()%> <%=transaction.getAccount().getLastName()%></td>
											<td><%=transaction.getTransactionDate()%></td>
											<td><%=transaction.getQty()%></td>
											<td><%=transaction.getItem().getPhpValue()%></td>
											<td><%=transaction.getItem().getItemName()%></td>
										</tr>
										<%--ELSE transaction Type ==2///////REDEEM TYPE TRANSACTION--%>
									<%}else{%>
										<tr>
											<td>Redeem</td>
											<td><%=transaction.getAccount().getEmail()%></td>
											<td><%=transaction.getAccount().getFirstName()%> <%=transaction.getAccount().getLastName()%></td>
											<td><%=transaction.getTransactionDate()%></td>
											<td><%=transaction.getQty()%></td>
											<td><%=transaction.getRedeem().getRedeemValue()%></td>
											<td><%=transaction.getRedeem().getRedeemName()%></td>
										</tr>
									<%}%>
		                    	<%}%>
								</tbody>
						</table>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
</div>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->

<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.18/js/dataTables.bootstrap4.js"></script>



<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="/js/ecoblue.js"></script>
<script>

        $('#table').DataTable( {
            "order": [[ 1, "asc" ]]
        } );
    /*$("#qty").change(function() {
        var items = document.getElementsByClassName('itemList');
        $("#totalPoints").val($("#qty").val() * items[$("#itemType").val()].value);
    });
    $("#itemType").change(function() {
        var items = document.getElementsByClassName('itemList');
        $("#totalPoints").val($("#qty").val() * items[$("#itemType").val()].value);
    });*/
</script>
</body>
</html>