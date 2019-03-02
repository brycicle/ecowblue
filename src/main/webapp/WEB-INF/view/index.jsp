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

</head>
<body>
<div class="wrapper">
    <!-- Sidebar  -->
    <jsp:include page="sidebar.jsp"/>

    <!-- Page Content  -->
    <div id="content">

		<div class="container">
		    <div class="row justify-content-center m-5">
		        <div class="card col-8 shadow p-3 mb-5 transparent-card rounded">
		            <h5 class="card-title">Convert</h5>
		            <div class="card-body">
		                <form action="/convert" id="convert" method="POST">
							<div class="form-row">
								<label for="id">School Email</label>
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
							<div class="form-row my-3">
								<div class="form-group col-8">
										${item.itemName}
								</div>
								<div class="form-group col-2">
									<span class="badge badge-pill badge-points badge-warning mr-3"><i class="fas fa-coins"></i> ${item.phpValue}</span>
								</div>
								<input class="itemPrice" value="${item.phpValue}" style="display: none;">
								<div class="form-group col-2">
									<input id="item-${item.itemId}" name="item-${item.itemId}" type="number" min="0" class="item form-control" value="0" required>
								</div>
							</div>
							</c:forEach>
							<div class="form-row">
								<div class="form-group col-10 mb-3">
									<label>Total Points to Earn :</label>
								</div>
								<div class="form-group col-2 mb-3">
									<input type="number" min="0" class="form-control" id="totalPoints" name="totalPoints" value="0" disabled>
								</div>
							</div>
		                    <div class="form-row">
		                        <div class="col-md-6">
		                            <button type="reset" class="btn btn-block btn-outline-danger">Clear</button>
		                        </div>
		                        <div class="col-md-6">
		                            <button type="button" id="btnSubmit" class="btn btn-block btn-outline-success disabled">Convert</button>
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
    var total = 0;
    $("#user").keyup(function() {
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
                    total = data;
                    hasError = false;
                    $("#btnSubmit").removeClass("disabled");
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
    });
    $(".item").keyup(function() {
        var total = 0;
        $(".item").each(function(i) {
            total += prices[i]*$(this).val();
        });
        $("#totalPoints").val(total);
    });
    $("#itemType").change(function() {
        var items = document.getElementsByClassName('itemList');
        $("#totalPoints").val($("#qty").val() * items[$("#itemType").val()].value);
    });
    $("#btnSubmit").click(function() {
        var user = $('#user').val() + '@iacademy.edu.ph';
        var newTotal = parseInt(total)+parseInt($("#totalPoints").val());
        if(!hasError){
			Swal.fire({
				title: 'Success!',
				text: user + " earned " + ($("#totalPoints").val()) + " Points. Your Total is now "+(newTotal)+" Points",
				type:'success',
				confirmButtonColor: '#3085d6',
				confirmButtonText: 'OK'
			}).then((result) => {
				if (result.value) {
					$("#convert").submit()
				}
			})
        }
    });
</script>
</body>
</html>