<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>

      <form id="registerForm" action="inputPro.jsp" method="post" name="join" onsubmit="return newSave()" >
      
          아이디: <input type="text" name="id" id="id" required="required" maxlength="20" placeholder="아이디를 입력해 주세요" />
          <input type="button" value="아이디 중복확인" onclick="idCheck();"/><br/>
          
          <input type="hidden" id="idChecked" name="idChecked" /><br/> 
          
          비밀번호: <input type="password" name="pw" required="required" minlength="6" maxlength="20" placeholder="6~20 글자 내로 입력해주세요" /><br/>
          
          이름: <input type="text" name="name" required="required" minlength="1" maxlength="20" placeholder="이름을 입력해 주세요" /><br/>
          
          연락처: <input type="tel" name="phone" required="required" placeholder="- 빼고 숫자만 입력해주세요"/><br/>
          
          이메일: <input type="email" name="email" required="required" minlength="1" maxlength="30" placeholder="이메일을 입력해 주세요" /><br/>
      
          <input type="submit" value="가입" /><br/>
      </form>

      
      <script>
    // 아이디 중복 확인 버튼을 눌렀을 때의 동작
//     var idChecked = document.getElementById("idChecked").value;
    function idCheck() {
        var id = document.getElementById("id").value;
        if (id.trim === "") {
            alert("아이디를 입력해주세요.");
        } else {
//             var queryString ="id="+id+"&idChecked="+idChecked;
            open("idCheck.jsp?id="+id, "ID 중복확인", "width=300,height=500");
            console.log("input.jsp 유효성 :::: " + document.getElementById("idChecked").value);
        }
    }
    
    // 가입버튼 클릭시
    function newSave(){
		// 유효성 체크 
        console.log("input.jsp 유효성 :::: " + document.getElementById("idChecked").value);
		if(document.getElementById("idChecked").value !='1'){
         alert("ID 중복확인을 하세요.");
         return false;
		}
       var id = document.join.id.value
       if(id.trim===""||id.length<3||id.length>20){
         alert("3자리이상,20자리 이하의 ID를 입력하세요.");
         document.join.id.focus();
         return false;
       }
       var pw = document.join.pw.value
       if(pw.trim===""||pw.length<6||pw.length>20){
         alert("6자리이상,20자리 이하의 PW를 입력하세요.");
         document.join.pw.focus();
         return false;
       }
       var name = document.join.name.value
       if(name.trim===""||name.length<2||name.length>10){
           alert("2자이상, 10자이하의 성함을 입력하세요.");
           document.join.name.focus();
           return false;
         }
       var phone = document.join.phone.value
       if(phone.trim===""||phone.length>11){
           alert("연락처 입력하세요.");
           document.join.phone.focus();
           return false;
         }
     }    
</script>