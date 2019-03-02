<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <!-- Bootstrap CSS --><link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/jq-3.3.1/dt-1.10.18/datatables.min.css"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<link href="/css/ecoblue.css" rel="stylesheet" />

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
</head>
<body>
<div class="wrapper">
    <!-- Sidebar  -->
    <jsp:include page="sidebar.jsp"/>
    <!-- Page Content  -->
    <div id="content">
		<div class="">
		    <div class="row justify-content-center mx-5">

				<div class="card col-6 shadow py-3 my-5 mr-2 transparent-card rounded">
					<h5 class="card-title">Load Accounts</h5>
					<div class="card-body">
						<form action="/uploadcsv" method="POST" enctype="multipart/form-data">
							<div class="row">
								<div class="col">
									<input type="file" name="file" id="file">
								</div>
								<div class="col">
									<input type="submit" class="btn btn-block btn-success" value="Save Accounts">
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="card col-5 shadow py-3 my-5 ml-2 transparent-card rounded">
					<h5 class="card-title">Ecoblue Email</h5>
					<div class="card-body">
						<form action="/changepass" method="POST" enctype="multipart/form-data">
							<div class="row">
								<div class="col">
									<input type="password" name="password" class="form-control" id="password" placeholder="Password">
								</div>
								<div class="col">
									<input type="confirm-password" name="confirm-password" class="form-control" id="confirm-password" placeholder="Confirm Password">
								</div>
								<div class="col">
									<input type="submit" class="btn btn-block btn-success" value="Change Password">
								</div>
							</div>
						</form>
					</div>
				</div>
		        <div class="card col-12 shadow py-3 my-5 transparent-card rounded">
		            <h5 class="card-title">Account List</h5>
		            <div class="card-body">
						<table id="accountTable" class="table table-hover table-bordered">
							<thead>
								<tr>
									<td>Email Address</td>
									<td style="display: none"></td>
									<td style="display: none"></td>
									<td>Name</td>
									<td>Total Points</td>
									<td>Options</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="account" items="${accounts}">
									<tr>
										<input type="hidden" id="accountId-${account.accountId}" value="${account.accountId}" class="full">
										<td style="display: none">${account.email}</td>
										<td style="display: none">${account.firstName} ${account.lastName}</td>
										<td><input type="text" id="email-${account.accountId}" value="${account.email}" class="full"></td>
										<td><input type="text" id="accountName-${account.accountId}" value='${account.firstName} ${account.lastName}' class="full"></td>
										<td>${account.totalPoints}</td>
										<td><input type="button" id="btnDel-${account.accountId}" class="btn btn-outline-danger" value="Delete"/><input type="button" id="btnSave-${account.accountId}" class="btn btn-outline-success" value="Save"/></td>
									</tr>
									<script>
                                        $("#btnSave-${account.accountId}").click(function() {
                                            jQuery.ajax({
                                                url: '/updateAccount',
                                                data: { accountId: $("#accountId-${account.accountId}").val(),
                                                    email: $('#email-${account.accountId}').val(),
                                                    accountName: $("#accountName-${account.accountId}").val()
                                                },
                                                method: "POST",
                                                success: function (data) {
                                                    Swal.fire({
                                                        title: 'Success!',
                                                        text: data + " Updated",
                                                        type:'success',
                                                        confirmButtonColor: '#3085d6',
                                                        confirmButtonText: 'OK'
                                                    }).then((result) => {
                                                        if (result.value) {
                                                        //location.reload();
                                                    }
                                                });
                                                }
                                            });
                                        });
                                        $("#btnDel-${account.accountId}").click(function() {
                                            jQuery.ajax({
                                                url: '/deleteAccount',
                                                data: { accountId: $("#accountId-${account.accountId}").val()
                                                },
                                                method: "POST",
                                                success: function (data) {
                                                    Swal.fire({
                                                        title: 'Are you sure?',
                                                        text: "Confirm Delete",
                                                        type: 'warning',
                                                        showCancelButton: true
                                                    }).then((result) => {
                                                        if (result.value) {
                                                        Swal.fire({
                                                            title: 'Success!',
                                                            text: data + " Deleted",
                                                            type:'success',
                                                            confirmButtonColor: '#3085d6',
                                                            confirmButtonText: 'OK'
                                                        }).then((result) => {
                                                            if (result.value) {
                                                            location.reload();
                                                        }
                                                    });
                                                    }
                                                })

                                                }
                                            });
                                        });
									</script>
								</c:forEach>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="/js/ecoblue.js"></script>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.18/js/dataTables.bootstrap4.js"></script>

<script>
    $('#accountTable').DataTable();
</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
</body>
</html>