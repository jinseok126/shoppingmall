<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
$(document).ready(function(){
	
	var count = 5;
	
	// 더보기 버튼 클릭수에 따라 보이는 데이터가 달라짐
	var freeCount = 2;
	var reviewCount = 2;
	var inquiryCount = 2;
	
	// 첫 화면은 count의 변수만큼 나타나기 
	for(var i=1; i<=count; i++){
		$("#freeBoardTr_"+i+"").css("display", "");
		$("#reviewBoardTr_"+i+"").css("display", "");
		$("#inquiryBoardTr_"+i+"").css("display", "");
	}
	
	// freeBoard 개수
	// console.log($("#freeBoardTable tbody tr").length);
	
	
	// 데이터가 count보다 없을 경우 버튼 안보이게 하기
	if($("#freeBoardTable tbody tr").length <= 7){
		$("#freeBoardBtn").hide();
	}
	if($("#reviewBoardTable tbody tr").length <= 7){
		$("#reviewBoardBtn").hide();
	}
	if($("#inquiryBoardTable tbody tr").length <= 7){
		$("#inquiryBoardBtn").hide();
	}
	 
	$("#search_input").datepicker({dateFormat:'yy-mm-dd'});
	
	// 날짜 별 검색버튼
	$("#searchBtn").click(function(){
		$("#search_input").val($("#search_input").val().split("20")[1]);
		// alert($("#search_input").val());
		$("#titleName").html("검색한 게시물 목록");
		
		location.href="${pageContext.request.contextPath}/admin/adminBoardList.do?date="+$("#search_input").val()+"";
		
		/*
		$.ajax({
			
			url : '${pageContext.request.contextPath}/admin/byDateBoard.do',
			type : 'get',
			data : {
				date : $("#search_input").val()
			}, 
			success : function(data){
				alert("success");
			}, 
			error : function(xhr, status){
				alert("error");
			}
		}); // ajax
		*/
	}); // click
	
	// 자유 게시판 더보기 버튼
	$("#freeBoardBtn").click(function(){
		for(var i=(count*freeCount-4); i<=(count*freeCount); i++){
			$("#freeBoardTr_"+i+"").css("display", "");
		}
		freeCount++;
		if($("#freeBoardTable tbody tr").length <= count*freeCount){
			$(this).hide();
		}
	}); // click
	
	// review 게시판 더보기 버튼
	$("#reviewBoardBtn").click(function(){
		for(var i=(count*freeCount-4); i<=(count*freeCount); i++){
			$("#reviewBoardTr_"+i+"").css("display", "");
		}
		freeCount++;
		if($("#reviewBoardTable tbody tr").length <= count*freeCount){
			$(this).hide();
		}
	}); // click
	
	// Q&A 게시판 더보기 버튼
	$("#inquiryBoardBtn").click(function(){
		for(var i=(count*freeCount-4); i<=(count*freeCount); i++){
			$("#inquiryBoardTr_"+i+"").css("display", "");
		}
		freeCount++;
		if($("#inquiryBoardTable tbody tr").length <= count*freeCount){
			$(this).hide();
		}
	}); // click
	
}); // ready
</script>
</head>
<body>
<br>
<h2 class="col-sm-6" style="text-align: right;" id="titleName">오늘 올라온 게시물</h2>
<br>
<div style="text-align: right">
	날짜 별 검색 : <input type="text" id="search_input" placeholder="pattern = yyyy">
	<input type="button" value="검색" id="searchBtn">
</div>
<h3 class="col-sm-5" style="text-align: right;">자유 게시판</h3>
<h5>작성된 게시글 수는 ${freeBoard.size()}개 입니다.</h5>
<table class="table table-hover" id="freeBoardTable" style="border-collapse: collapse;">
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
		
	<tbody>
	<c:forEach items="${freeBoard}" var="freeBoard" varStatus="st">
		<tr id="freeBoardTr_${st.count}" style="display: none;">
			<td>${freeBoard.boardNum}</td>
			<td>
				<a href="${pageContext.request.contextPath}/board/view.do?boardNum=${freeBoard.boardNum}">
				${freeBoard.boardSubject}</a>
			</td>
			<td>${freeBoard.boardWriter}</td>
			<td>${freeBoard.boardDate}</td>
			<td>${freeBoard.boardReadCount}</td>
		</tr>
	</c:forEach>
		<tr>
			<td colspan="5">
				<button type="button" class="btn btn-dark col-sm-12" id="freeBoardBtn">
					<div class="col-sm-10">더보기</div>
				</button>
			</td>
		</tr>
	</tbody>
</table>
<br>

<h3 class="col-sm-5" style="text-align: right;">Reviews</h3>
<h5>작성된 게시글 수는 ${reviewBoard.size()}개 입니다.</h5>
<table class="table table-hover" id="reviewBoardTable">
	<thead>
		<tr>
			<th>번호</th>
			<th>상품 아이디</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
		
	<tbody>
	<c:forEach items="${reviewBoard}" var="reviewBoard" varStatus="st">
		<tr id="reviewBoardTr_${st.count}">
			<td>${reviewBoard.boardNum}</td>
			<td>${reviewBoard.productId}</td>
			<td>
				<a href="${pageContext.request.contextPath}/board/view.do?boardNum=${reviewBoard.boardNum}">
				${freeBoard.boardSubject}</a>
			</td>
			<td>${reviewBoard.boardWriter}</td>
			<td>${reviewBoard.boardDate}</td>
			<td>${reviewBoard.boardReadCount}</td>
		</tr>
	</c:forEach>	
		<tr>
			<td colspan="6">
				<button type="button" class="btn btn-dark col-sm-12" id="reviewBoardBtn">
					<div class="col-sm-10">더보기</div>
				</button>
			</td>
		</tr>
	</tbody>
</table>
<br>	
  
<h3 class="col-sm-5" style="text-align: right;">Q&A</h3>
<h5>작성된 게시글 수는 ${inquiryBoard.size()}개 입니다.</h5>	
<table class="table table-hover" id="inquiryBoardTable">
	<thead>
		<tr>
			<th>번호</th>
			<th>상품 아이디</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
		
	<tbody>
	<c:forEach items="${inquiryBoard}" var="inquiryBoard" varStatus="st">
		<tr id="inquiryBoardTr_${st.count}">
			<td>${inquiryBoard.boardNum}</td>
			<td>${inquiryBoard.productId}</td>
			<td>
				<a href="${pageContext.request.contextPath}/board/view.do?boardNum=${inquiryBoard.boardNum}">
				${freeBoard.boardSubject}</a>
			</td>
			<td>${inquiryBoard.boardWriter}</td>
			<td>${inquiryBoard.boardDate}</td>
			<td>${inquiryBoard.boardReadCount}</td>
		</tr>
	</c:forEach>	
		<tr>
			<td colspan="6">
				<button type="button" class="btn btn-dark col-sm-12" id="inquiryBoardBtn">
					<div class="col-sm-10">더보기</div>
				</button>
			</td>
		</tr>
	</tbody>
</table>  
</body>
</html>