$(function() {
    $('#editBtn').click(function() {
        var result = confirm("수정하시겠습니까?");
        if (result) {
            var categoryView = $('#categoryView');
            categoryView.attr("method", "get");
            categoryView.attr("action", "/test/category/edit");
            categoryView.submit();
        }
    });
    $('#deleteBtn').click(function() {
        var result = confirm("삭제하시겠습니까?");
        if (result) {
            var categoryView = $('#categoryView');
            categoryView.attr("action", "/test/category/remove");
            categoryView.submit();
        }
    });
    $('#listBtn').click(function() {
        $(location).attr("href", "/test/category/?" + getGotoParam());
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