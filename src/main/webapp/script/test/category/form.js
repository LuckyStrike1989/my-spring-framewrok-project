$(function() {
	$('#saveBtn').click(function() {
	    var mode = $('#mode').val();
        var modeText = "등록";
        var modeUrl = "/test/category/add";
        if (mode == "edit") {
            modeText = "수정";
            modeUrl = "/test/category/edit";
        }
        var result = confirm(modeText + "하시겠습니까?");
        if (result) {
            var categoryForm = $('#categoryForm');
            if (!categoryForm[0].checkValidity()) {
                categoryForm.addClass("was-validated");
            } else {
                categoryForm.attr("action", modeUrl);
                categoryForm.submit();
            }
        }
	});
	$('#cancelBtn').click(function() {
	    var mode = $('#mode').val();
	    if (mode == "edit") {
	        const categoryID = $('#categoryForm input:hidden[name="categoryID"]').val();
            $(location).attr("href", "/test/category/view?categoryID=" + categoryID + "&" + getGotoParam());
	    } else {
        	$(location).attr("href", "/test/category/?" + getGotoParam());
	    }
	});
	function getGotoParam() {
        const gotoForm = $('#gotoForm');
        const searchType = gotoForm.find('input:hidden[name="searchType"]').val();
        const searchCondition = gotoForm.find('input:hidden[name="searchCondition"]').val();
        const searchKeyword = gotoForm.find('input:hidden[name="searchKeyword"]').val();
        const pageNo = gotoForm.find('input:hidden[name="pageNo"]').val();
        const recordCountPerPage = gotoForm.find('input:hidden[name="recordCountPerPage"]').val();
        return "searchType=" + searchType + "&searchCondition=" + searchCondition + "&searchKeyword=" + encodeURI(searchKeyword) + "&pageNo=" + pageNo + "&recordCountPerPage=" + recordCountPerPage;
    }
});