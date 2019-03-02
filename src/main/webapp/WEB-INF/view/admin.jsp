<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<link href="/css/ecoblue.css" rel="stylesheet" />

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
<div class="wrapper">
    <!-- Sidebar  -->
    <jsp:include page="sidebar.jsp"/>

    <!-- Page Content  -->
    <div id="content">
		<div class="">
		    <div class="row justify-content-center mx-5">
		        <div class="card col-12 shadow py-3 my-5 transparent-card rounded">
		            <h5 class="card-title">Item</h5>
		            <div class="card-body">
						<table class="table table-hover table-bordered">
							<thead>
							<tr>
								<td>Item Name</td>
								<td>Points</td>
								<td colspan="2">PHP Value</td>
							</tr>
								<form action="/newItem" method="post">
									<tr>
										<td><input type="text" id="itemName" name="itemName" placeholder="Item Name" class="full"></td>
										<td><input type="number" id="itemPoint" name="itemPoint" placeholder="Points"></td>
										<td><input type="number" id="phpValue" name="phpValue" placeholder="PHP Value"></td>
										<td><input type="submit" class="btn btn-block btn-success" value="Add"/></td>
									</tr>
								</form>
							</thead>
						</table>
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<td>Item Name</td>
									<td>Points</td>
									<td>PHP Value</td>
									<td>Options</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${items}">
									<tr>
										<input type="hidden" id="itemId-${item.itemId}" value="${item.itemId}">
										<td><input type="text" id="itemName-${item.itemId}" value="${item.itemName}" class="full"></td>
										<td><input type="number" id="itemPoint-${item.itemId}" value="${item.itemPoint}"></td>
										<td><input type="number" id="phpValue-${item.itemId}" value="${item.phpValue}"></td>
										<td><input type="button" id="btnDel-${item.itemId}" class="btn btn-outline-danger" value="Delete"/><input type="button" id="btnSave-${item.itemId}" class="btn btn-outline-success" value="Save"/></td>
									</tr>
									<script>
                                        $("#btnSave-${item.itemId}").click(function() {
                                            jQuery.ajax({
                                                url: '/updateItem',
                                                data: { itemId: $("#itemId-${item.itemId}").val(),
														itemName: $('#itemName-${item.itemId}').val(),
														itemPoint: $("#itemPoint-${item.itemId}").val(),
														phpValue: $("#phpValue-${item.itemId}").val(),
														},
                                                method: "POST",
                                                success: function (data) {
                                                    location.reload();
                                                }
                                            });
                                        });
                                        $("#btnDel-${item.itemId}").click(function() {
                                            jQuery.ajax({
                                                url: '/deleteItem',
                                                data: { itemId: $("#itemId-${item.itemId}").val()
                                                },
                                                method: "POST",
                                                success: function (data) {
                                                    location.reload();
                                                }
                                            });
                                        });
									</script>
								</c:forEach>
							</tbody>
						</table>
		            </div>
		        </div>
				<!-------------->
				<div class="card col-12 shadow py-3 my-5 transparent-card rounded">
					<h5 class="card-title">Redeem</h5>
					<div class="card-body">
						<table class="table table-hover table-bordered">
							<thead>
							<tr>
								<td>Item Name</td>
								<td>Points</td>
								<td colspan="2">PHP Value</td>
							</tr>
							<form action="/newRedeem" method="post">
								<tr>
									<td><input type="text" id="redeemName" name="redeemName" placeholder="Item Name" class="full"></td>
									<td><input type="number" id="redeemValue" name="redeemValue" placeholder="PHP Value"></td>
									<td><input type="submit" class="btn btn-block btn-success" value="Add"/></td>
								</tr>
							</form>
							</thead>
						</table>
						<table class="table table-hover table-bordered">
							<thead>
							<tr>
								<td>Item Name</td>
								<td>Redeem Value</td>
								<td>Options</td>
							</tr>
							</thead>
							<tbody>
							<c:forEach var="redeem" items="${redeems}">
								<tr>
									<input type="hidden" id="redeemId-${redeem.redeemId}" value="${redeem.redeemId}">
									<td><input type="text" id="redeemName-${redeem.redeemId}" value="${redeem.redeemName}" class="full"></td>
									<td><input type="number" id="redeemValue-${redeem.redeemId}" value="${redeem.redeemValue}"></td>
									<td><input type="button" id="btn2Del-${redeem.redeemId}" class="btn btn-outline-danger" value="Delete"/><input type="button" id="btn2Save-${redeem.redeemId}" class="btn btn-outline-success" value="Save"/></td>
								</tr>
								<script>
                                    $("#btn2Save-${redeem.redeemId}").click(function() {
                                        jQuery.ajax({
                                            url: '/updateRedeem',
                                            data: { redeemId: $("#redeemId-${redeem.redeemId}").val(),
                                                redeemName: $('#redeemName-${redeem.redeemId}').val(),
                                                redeemValue: $("#redeemValue-${redeem.redeemId}").val()
                                            },
                                            method: "POST",
                                            success: function (data) {
                                                location.reload();
                                            }
                                        });
                                    });
                                    $("#btn2Del-${redeem.redeemId}").click(function() {
                                        jQuery.ajax({
                                            url: '/deleteRedeem',
                                            data: { redeemId: $("#redeemId-${redeem.redeemId}").val()
                                            },
                                            method: "POST",
                                            success: function (data) {
                                                location.reload();
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
</body>
</html>