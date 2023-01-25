<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/top.jsp"%>
<style>
a{
	text-decoration: none;
	color: black;
}
</style>
<div class="d-flex">
<%@ include file="/WEB-INF/views/member/mypageSidebar.jsp"%>
<div class="container mt-3" style="height: 600px; overflow: auto;">
	<table class="table table-condensed " style="background:#f7f9fa; text-align: center; border: 1px solid #cccccc">
		<thead>
			<tr>
				<th style="width: 7%">글번호</th>
				<th style="width: 61%">제목</th>
				<th style="width: 8%">날짜</th>
				<th style="width: 8%">조회수</th>
			</tr>
		</thead>
		<tbody id="boardBody">
			<c:if test="${boardComArr eq null or empty boardComArr}">
				<tr>
					<td colspan="5">
						<b>데이터가 없습니다.</b>
					</td>
				</tr>
			</c:if>
			<c:if test="${boardComArr ne null and not empty boardComArr}">
				<c:forEach var="board" items="${boardComArr}">
					<tr>
						<td>
							<c:out value="${board.cidx}" />
						</td>
						<td>
							<a href="${myctx}/boardGet?cidx=${board.cidx}">${board.ctitle}</a>
						</td>
						<td>
							<c:out value="${board.cdate}" />
						</td>
						<td>
							<c:out value="${board.creadnum}" />
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>
</div>


<%@ include file="/WEB-INF/views/foot.jsp"%>