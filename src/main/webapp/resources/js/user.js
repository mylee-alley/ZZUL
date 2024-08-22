/**
 * 주주주주석
 */
function inputCheck() {
	// document. : 현재 페이지 안에있는
	// element : 태그 
	// get 태그를 꺼내겠다 id라는 속성이 id인것의 값
	// .value()아님 .value임
	// 스크립트는 변수의 타입이 없음 아무거나 다 집어 넣을 수 있음
	id = document.getElementById("id").value;
	console.log("========야호야호id========"+id);
	if (id == "") {
		alert("ID를 입력~~~~~~!!");		// 메세지 창
		document.getElementById("id").focus();
	}
}