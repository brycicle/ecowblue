<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.neil.ecoblue.model.Account" %>
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
</head>
<body>
<div class="wrapper">
    <!-- Sidebar  -->
    <jsp:include page="sidebar.jsp"/>

    <!-- Page Content  -->
    <div id="content">

		<div class="container">
		    <div class="row justify-content-center m-5">
		        <div class="card col-8 shadow p-3 transparent-card rounded">
					<div class="d-flex justify-content-between">
						<b class="card-title">Redeem</b>
						<b class="card-title">Total :
							<input type="hidden" id="accountTotal">
							<span class="badge badge-pill badge-warning mr-3"><i class="fas fa-coins"></i> <b id="accTotal">0</b></span>
						</b>
					</div>
		            <div class="card-body">
		                <form action="/redeem" id="redeem" method="POST">
							<div class="form-row">
								<label for="user">School Email</label>
								<div class="input-group mb-12">
									<input type="text" class="form-control" name="user" id="user" placeholder="StudentNumber" required>
									<div class="input-group-append">
										<span class="input-group-text" id="basic-addon2">@iacademy.edu.ph</span>
									</div>
								</div>
							</div>
							<div class="form-row mt-3">
								<div class="form-group col-8">
									<label>Item Name</label>
								</div>
								<div class="form-group col-2">
									<label>Points</label>
								</div>
								<div class="form-group col-2">
									<label>Qty</label>
								</div>
							</div>
							<c:forEach var="item" items="${items}">
								<div class="form-row mb-3">
									<div class="form-group col-8">
											${item.redeemName}
									</div>
									<div class="form-group col-2">
										<span class="badge badge-pill badge-points badge-warning mr-3"><i class="fas fa-coins"></i> ${item.redeemValue}</span>
									</div>
									<input class="itemPrice" value="${item.redeemValue}" style="display: none;">
									<div class="form-group col-2">
										<input id="item-${item.redeemId}" name="item-${item.redeemId}" type="number" min="0" class="item form-control" value="0" required>
									</div>
								</div>
							</c:forEach>
		                    <div class="form-row">
		                        <div class="form-group col-10">
		                            <label>Total Points to Spend :</label>
		                        </div>
		                        <div class="form-group col-2">
									<input type="number" min="0" class="form-control" id="totalPoints" name="totalPoints" value="0" disabled>
		                        </div>
		                        <div class="col-md-12">
		                            <button id="btnSubmit" type="button" class="btn btn-block btn-outline-success disabled">Redeem</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
</div>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="/js/ecoblue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
<script>
    var prices = new Array();
    var hasError = true;
    var trueTotal = 0;
    $("#user").keyup(function() {
        $("#accTotal").html("0");
        jQuery.ajax({
            url: '/checkredeem',
            data: {  user: $('#user').val() },
            method: "POST",
            success: function (data) {
                if(data=="invalid") {
                    hasError = true;
                    $("#btnSubmit").addClass("disabled");
                }
                else{
                    trueTotal = data;
                    $("#accTotal").html(data);
                    $("#accountTotal").val(data);
                    if(parseInt($("#totalPoints").val())==0){}
                    else{
                    trueTotal = data;
                    hasError = false;
                    $("#btnSubmit").removeClass("disabled");
                    }
                }
            }
        });
    });
    $(".itemPrice").each(function(i) {
        prices[i]=$(this).val();
    });
    $(".item").change(function() {
        var total = 0;
        $(".item").each(function(i) {
            total += prices[i]*$(this).val();
        });
        $("#totalPoints").val(total);
        if(parseInt(
            $("#accountTotal").val()
			)
			<
			parseInt(
			    $("#totalPoints").val()
			)
		){
            $("#btnSubmit").addClass("disabled");
        }
        else{
            $("#btnSubmit").removeClass("disabled");
        }
        if($("#totalPoints").val()==0){
            $("#btnSubmit").addClass("disabled");
		}
    });
    $("#btnSubmit").click(function() {
   		var total = trueTotal-$("#totalPoints").val()
		if($("#btnSubmit").hasClass("disabled")){}else{
			Swal.fire({
			  title: 'Success!',
			  text:$("#user").val() + " redeemed " + $("#totalPoints").val() + " "+ $("#itemType option[value='"+$('#itemType').val()+"']").text()+". Your Total is now "+total+" Points",
			  type:'success',
			  confirmButtonColor: '#3085d6',
			  confirmButtonText: 'OK'
			}).then((result) => {
			  if (result.value) {
				$("#redeem").submit()
			  }
			});
		}
    });
</script>
</body>
</html>