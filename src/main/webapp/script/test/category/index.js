$(function () {
    const categorySearch = $('#categorySearch');
    $('#searchBtn').click(function() {
        $(this).attr("disabled", "disabled");
        categorySearch.submit();
    });
    $('#searchKeyword').keypress(function(event){
        if (13 == event.which) {
            $('#searchBtn').click();
            return false;
        }
    });
    $('select[name="pagination.recordCountPerPage"]').change(function(event) {
        categorySearch.submit();
    });
    $('#boardPagination .page-link').click(function(event) {
        event.preventDefault();
        event.stopPropagation();
        const pageLastNo = categorySearch.find('input:hidden[name="pagination.pageLastNo"]').val();
        const pageNo = categorySearch.find('input:hidden[name="pagination.pageNo"]').val();
        const moveToPageNo = $(this).attr("data-pageno");
        if (pageNo == moveToPageNo) {
            return;
        }
        if (moveToPageNo > 0 && moveToPageNo <= pageLastNo) {
            categorySearch.find('input:hidden[name="pagination.pageNo"]').val(moveToPageNo);
            categorySearch.submit();
        }
    });
    $('#addCategoryBtn').click(function() {
    	$(location).attr("href", "/test/category/add?" + getGotoParam());
    });
    $('.list .item').click(function() {
    	$(location).attr("href", "/test/category/view?categoryID=" + $(this).attr("data-value") + "&" + getGotoParam());
    });
    function getGotoParam() {
        const searchType = $('#searchType').val();
        const searchCondition = $('#searchCondition').val();
        const searchKeyword = $('#searchKeyword').val();
        const gotoForm = $('#gotoForm');
        const pageNo = gotoForm.find('input:hidden[name="pageNo"]').val();
        const recordCountPerPage = gotoForm.find('input:hidden[name="recordCountPerPage"]').val();
    	return "searchType=" + searchType + "&searchCondition=" + searchCondition + "&searchKeyword=" + encodeURI(encodeURIComponent(searchKeyword)) + "&pageNo=" + pageNo + "&recordCountPerPage=" + recordCountPerPage;
    }
});
