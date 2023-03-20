/******************************


1. change ajax view 
3. edit info
4. edit pwd
5. changePage to Where
6. ajax items view 


******************************/


//1.
function changeAjaxView(target) {
	var view =null;
	if(target instanceof Object){
		view = "ViewAjax/"+$(target).attr("aria-View")+".jsp";
	}else{
		view = "ViewAjax/"+target;
	}
	$.post(view, function(data) {
				$("#ajaxView").html(data);
			})
}

//3.
var toggle = true;
function editInfo() {
	if(toggle){
		$(".editInfo").removeAttr("disabled")
			.attr("class","border border-danger editInfo bg-light form-control");
		$("#changeInfo").html("<span>取消</span>");
		$("#submitInfo").show();
		toggle = false;
	}else{
		$(".editInfo").attr("disabled","disabled").
			attr("class","editInfo bg-light form-control");
		$("#changeInfo").html("<span>修改個人資料</span>");
		$("#submitInfo").hide();
		toggle = true;
	}
}

//4.
function ckPassword() {
	if ($("#ckPassword2").val() == $("#ckPassword1").val() && $("#ckPassword1").val().match("^(?=.*\\d)(?=.*[a-zA-Z]).{6,20}$")) {
		$("#ckPassword1").attr("class","form-control is-valid bg-light");
		$("#ckPassword2").attr("class","form-control is-valid bg-light");
	}else{
		$("#ckPassword1").attr("class","form-control is-invalid bg-light");
		$("#ckPassword2").attr("class","form-control is-invalid bg-light");
	}
}
function isPasswordEmpty() {
	if ($("#ckPassword1").val() =="") {
		$("#ckPassword1").attr("class","form-control is-invalid bg-light");
		$("#ckPassword2").attr("class","form-control is-invalid bg-light");
	}
}
function onSubmit(obj) {
	if(document.getElementById("ckPassword2").value!=
		document.getElementById("ckPassword1").value){
		return false
	}
}

//5.
function sendRedirect(href) {
	location.href = href;
}

//6.
function changeSellerItemAjaxView(target) {
	var view =null;
	view = "ViewAjax/OrderSellerDetailsV.jsp?tCode="+$(target).attr("aria-View");
	$.post(view, function(data) {
				$("#ajaxView").html(data);
			})
}
function changeBuyerItemAjaxView(target) {
	var view =null;
	view = "ViewAjax/OrderBuyerDetailsV.jsp?tCode="+$(target).attr("aria-View");
	$.post(view, function(data) {
				$("#ajaxView").html(data);
			})
	$('[data-toggle="tooltip"]').tooltip('hide')
}
