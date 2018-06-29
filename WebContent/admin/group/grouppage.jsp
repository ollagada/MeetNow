<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/top.jsp"%>

<div>
	<div class="admin_grouppage"
		style="width: 700px; margin: 0 auto; margin-top: 100px;">
		<table class="table table-condensed">
			<thead>
				<tr>
					<td style="font-size: 30px;"><strong>그룹정보</strong></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td></td>
					<td>${gdto.group_picture}</td>
				</tr>
				<tr>
					<td>그룹이름</td>
					<td>${gdto.group_name }</td>
				</tr>
				<tr>
					<td>그룹리더</td>
					<td>${gdto.group_leader }</td>
				</tr>
				<tr>
					<td>그룹생성일</td>
					<td>${gdto.group_createdate }</td>
				</tr>
				<tr>
					<td>그룹위치</td>
					<td>${gdto.group_location}</td>
				</tr>
				<tr>
					<td>그룹의 관심사??</td>
					<td>${gdto.group_interests }</td>
				</tr>
				<tr>
					<td>블락상태:</td>
					<c:if test="${gdto.group_betweendate < 0 }">
						<td id="blockstate">블락</td>
					</c:if>
					<c:if test="${gdto.group_betweendate >=0 }">
						<td id="blockstate">정상</td>
					</c:if>
				</tr>
				<tr>
					<td>그룹 블락횟수</td>
					<td id="blocknum">${gdto.group_warningnumber }회</td>
				</tr>
				<tr>
					<td>그룹 블락 날짜</td>
					<td id="warningdate">${gdto.group_warningdate }</td>
				</tr>
				<tr>
					<td>그룹 블락 만료날짜</td>
					<td id="expiredate">${gdto.group_expiredate }</td>
				</tr>

				<tr>
					<td>그룹 관심사</td>
					<td>${gdto.group_interests }</td>
				</tr>
				<tr>
					<td>그룹인원수</td>
					<td>${size }명</td>
				</tr>
				<tr>
					<td>그룹 소개</td>
					<td>${gdto.group_info }</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="admin_member_report">
		<table class="table table-condensed"
			style="margin: 50px auto; width: 700px;">
			<thead>
				<tr>
					<th style="font-size: 30px;">신고내용</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>신고일시</td>
					<td>report_date</td>
				</tr>
				<tr>
					<td>신고자</td>
					<td>report_caller</td>
				</tr>
				<tr>
					<td>신고내용</td>
					<td>report_reason</td>
				</tr>
				<tr>
					<td>블락</td>
					<c:if test="${gdto.group_warningnumber == 0}">
						<td>
							<button id="block" type="button" class="btn btn-warning">블락</button>
						</td>
					</c:if>
					<c:if test="${gdto.group_warningnumber == 1}">
						<td>
							<button id="block" type="button" class="btn btn-warning">영구정지</button>
						</td>
					</c:if>
					<c:if test="${gdto.group_warningnumber == 2}">
						<td>
							<button id="delet" type="button" class="btn btn-danger" disabled>삭제중</button>
						</td>
					</c:if>
				</tr>
				<tr>
					<td style="font-size: 30px;"><strong>신고기록</strong></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<script>
	$(document).ready(function() {
		
		$("#block").click(function(e) {
			var distinction = "group";
			var group_seq = ${gdto.group_seq}
			console.log("group_seq: " + group_seq);
			
			$.ajax({
				url : "warning.ao",
				type : "get",
				data : {
					distinction,
					group_seq
				},
				success : function(resp) {
					console.log("delete resp.warningnumber:" + resp.warningnumber);
					console.log("delete resp.btweendate:" + resp.betweendate);
					$("#blocknum").text(resp.warningnumber + "회");
					$("#warningdate").text(resp.warningdate);
					$("#expiredate").text(resp.expiredate);

					if (resp.warningnumber == 1) {
						$("#block").text("영구정지");
						
						/* $("#block").attr("id", "permanentblock"); */
					}

					if (resp.warningnumber == 2) {
						$("#block").addClass("btn-danger");
						$("#block").removeClass("btn-warning")
						$("#block").text("삭제중");
						$("#block").addClass("disabled");
						$("#block").attr("id", "delete");
					}

					if (resp.betweendate < 0) {
						console.log("0보다 작다");
						$("#blockstate").text("블락");
					}
					if (resp.betweendate >= 0) {
						console.log("0보다 작다");
						$("#blockstate").text("정상");
					}
				},
				error : function(error) {
					console.log(error);
				}
			})
		})

		
	})
</script>
</body>
</html>