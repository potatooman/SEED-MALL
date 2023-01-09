<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/resources/js/addressapi.js"></script>
<%@ include file="/WEB-INF/views/top.jsp"%>

<script>
	//배송메시지 200자 이내로 작성하도록 처리하는 스크립트
	$(document).ready(function() {
		$('#ocomment').on('keyup', function() {
			$('#ocomment_cnt').html("(" + $(this).val().length + " / 200)");

			if ($(this).val().length > 200) {
				$(this).val($(this).val().substring(0, 200));
				$('#ocomment_cnt').html("(200 / 200)");
			}
		});
	});

	// 유효성 체크
	function order_check() {
		if (!$('#omname').val()) {
			alert('받는분을 입력하세요.');
			$('#oname').focus();
			return false;
		}
		if (!$('#omhp1').val()) {
			alert('연락처를 입력하세요.');
			$('#ohp1').focus();
			return false;
		}
		if (!$('#omhp2').val()) {
			alert('연락처를 입력하세요.');
			$('#ohp2').focus();
			return false;
		}
		if (!$('#omhp3').val()) {
			alert('연락처를 입력하세요.');
			$('#ohp3').focus();
			return false;
		}
		if (!$('#omaddr1').val()) {
			alert('주소를 입력하세요.');
			$('#omaddr1').focus();
			return false;
		}
		return true;
	}
	
	// 우편번호 찾기
	function execPostCode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 도로명 조합형 주소 변수

				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}
				// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
				if (fullRoadAddr !== '') {
					fullRoadAddr += extraRoadAddr;
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				console.log(data.zonecode);
				console.log(fullRoadAddr);

				$("[name=ompost]").val(data.zonecode);
				$("[name=omaddr1]").val(fullRoadAddr);

				/* document.getElementById('signUpUserPostNo').value = data.zonecode;*///5자리 새우편번호 사용
				document.getElementById('ompost').value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('omaddr1').value = fullRoadAddr;
			}
		}).open();
	}
</script>
<!-- 결제정보 출력해주는 페이지 -->
<div class="container" style="height: 2300px; overflow: y:hidden;">
	<h1 class="text-center mt-5 mb-5">배송지정보</h1>
	<div class="checkbox mb-3" style="text-align: left;">
		<label> <input type="checkbox" value="remember-me"> 기본
			배송지 설정
		</label>
	</div>

	<form name="orderF" id="orderF" action="cartOrderAdd" method="post" onsubmit="return order_check()">
		<input type="hidden" name="desc_oTotalPrice" value="${total}">
		<table class="table">
			<tr>
				<td width="20%" class="m1">받는분</td>
				<td width="80%" class="m2"><input type="text" name="omname"
					id="omname"></td>
			</tr>
			<tr>
				<td width="20%" class="m1">연락처</td>
				<td width="80%" class="m2"><input type="text" name="omhp1"
					id="omhp1" placeholder="HP1" maxlength="3">- <input
					type="text" name="omhp2" id="omhp2" placeholder="HP2" maxlength="4">-
					<input type="text" name="omhp3" id="omhp3" placeholder="HP3"
					maxlength="4"></td>
			</tr>
			<tr>
				<td width="20%" class="m1">우편번호</td>
				<td width="80%" class="m2"><input type="text" name="ompost"
					id="ompost" maxlength="5">
					<button type="button" class="btn btn-success"
						onclick="execPostCode()">우편번호 찾기</button></td>
			</tr>
			<tr>
				<td width="20" class="m1">주소</td>
				<td width="80%" class="m2"><input type="text" name="omaddr1"
					id="omaddr1"> <input type="text" name="omaddr2" id="omaddr2">
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1">배송 요청사항</td>
				<td width="80%" class="m3"><textarea name="ocomment"
						id="ocomment" rows="5" cols="60"></textarea>
					<div id="ocomment_cnt">(0 / 200)</div> <br> <span class='ck'>*200자
						이내</span></td>
			</tr>
		</table>
		<br> <br> <br>
		<div style="height: 350px; overflow: auto;">
			<h1 class="text-center mt-1 mb-5">주문상품</h1>
			<table class="table">
				<thead>
					<tr class="info text-left">
						<th>상품정보</th>
						<th>판매가</th>
						<th>수량</th>
						<th>배송비</th>
						<th>총액</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="pvo" items="${cartArr}">
					<tr>
						<td>
							<h5>${pvo.product.pname}</h5>
						</td>
						<td><fmt:formatNumber value="${pvo.product.psaleprice}"
								pattern="###,###,###" /> 원<br> <span
							class="badge badge-danger">${pvo.product.ppoint}</span>POINT</td>
						<td>${pvo.pqty}개</td>
						<td>4,000원</td>
						<td><fmt:formatNumber value="${pvo.ctotalprice}" pattern="###,###,###" />
							원</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div style="height: 350px; overflow: auto;">
			<h1 class="text-center mt-5 mb-5">등급할인 정보</h1>
			<table class="table">
				<tr class="info text-left">
					<th>어쩌구님의 회원 등급 :</th>
				</tr>
				<tr>
					<td width="50%" class="m1">할인율</td>
				</tr>
				<tr>
					<td width="50%" class="m2">할인된가격</td>
				</tr>
			</table>
		</div>

		<div style="height: 400px; overflow: auto;">
			<h1 class="text-center mt-5 mb-5">결제수단 선택</h1>
			<input type="radio" name="payment" value="1" checked>신용카드<br>
			<br> <input type="radio" name="payment" value="2">무통장입금<br>
			<br> <input type="radio" name="payment" value="3">휴대폰결제
		</div>

		<div style="height: 400px; overflow: auto;">
			<h1 class="text-center mt-5 mb-5">최종 결제정보</h1>
			<table class="table">
				<tr>
					<td width="20%" class="m1">총 상품금액</td>
					<td width="80%" class="m1"><fmt:formatNumber value="${totalPayment}"
							pattern="###,###" /> 원</td>
				</tr>
				<tr>
					<td width="20%" class="m2">할인금액</td>
					<td width="80%" class="m2">10원</td>
				</tr>
				<tr>
					<td width="20%" class="m2">최종 결제금액</td>
					<td width="80%" class="m2">${total}원</td>
				</tr>
			</table>
		</div>
		<div class="text-center">
			<button class="btn btn-success mb-5">결제하기</button>
		</div>
	</form>
</div>

<%@ include file="/WEB-INF/views/foot.jsp"%>