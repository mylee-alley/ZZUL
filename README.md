# 맛집 예약 웹 애플리케이션 프로젝트

## 프로젝트 개요
이 프로젝트는 사용자가 맛집을 예약하고 리뷰를 작성할 수 있으며, 관리자가 메뉴와 예약을 관리할 수 있는 종합적인 웹 애플리케이션입니다. Java, Servlet, JSP, Oracle DB 등 다양한 웹 개발 기술을 실제 프로젝트에 적용하여 실무 능력을 향상시키는 것을 목표로 하였습니다.

## 기술 스택
<div>
    <img src="https://img.shields.io/badge/Java-11.0.18-red.svg" alt="Java">
    <img src="https://img.shields.io/badge/Servlet-4-yellow.svg" alt="Servlet">
    <img src="https://img.shields.io/badge/Oracle-19c-green.svg" alt="Oracle">  
    <img src="https://img.shields.io/badge/JSP-2.3-blue.svg" alt="JSP">
    <img src="https://img.shields.io/badge/HTML5-gray.svg" alt="HTML">
</div>

- **백엔드**: Java 11.0.18, Servlet 4
- **프론트엔드**: HTML5, JSP 2.3
- **데이터베이스**: Oracle DB 19c
- **서버**: Apache Tomcat 9.0.73
- **개발 도구**: Eclipse 4.26.0, Windows 10, UTF-8 인코딩

## 주요 기능 및 개인 기여도

### 사용자 기능
1. 회원가입 및 로그인 (담당)
   - 사용자 인증 및 관리 시스템 구현
   - 자동 로그인 기능 개발
2. 예약 관리
3. 리뷰 작성 (담당)
   - 실사용자 대상 리뷰 작성 및 조회 기능 구현
   - 서비스 이용 후 일정 기간 내 리뷰 작성 제한 로직 개발

### 관리자 기능
1. 메뉴 관리 (담당)
   - 관리자 페이지에서 메뉴 등록 및 수정 기능 개발
2. 예약 관리
3. 매출 통계 확인

## 문제 해결 경험

1. **메뉴 삭제와 리뷰 게시판 연동 문제**
   - 문제: 메뉴 삭제 시 리뷰 게시판에서 오류 발생
   - 해결: 메뉴 상태 관리 시스템 도입 (판매중: 1, 판매 중지: 2, 삭제: 0)
   - 결과: 데이터 일관성 유지 및 사용자 경험 개선

2. **팝업창 파라미터 전달 오류**
   - 문제: GET 방식으로 다수 파라미터 전달 시 URL 오류
   - 해결: Form 태그의 hidden 필드를 활용한 파라미터 전달 방식 적용
   - 결과: 안정적인 데이터 전송 및 보안성 향상

3. **날짜 데이터 처리 최적화**
   - 문제: 다양한 날짜 타입(Date, LocalDate, String) 처리 시 혼란
   - 해결: 타입별 적절한 포맷팅 방법 적용 (SimpleDateFormat, DateTimeFormatter)
   - 학습: Java의 최신 시간 API(java.time 패키지) 활용 능력 향상

## 프로젝트 성과 및 자기 개발

- MVC 아키텍처 기반의 웹 애플리케이션 개발 경험 획득
- 데이터베이스 설계 및 쿼리 최적화 능력 향상
- 프로젝트 일정 관리 및 우선순위 설정 능력 개발
- 팀 협업 및 의사소통 스킬 향상

## 향후 개선 계획

1. **보안 강화**: 비밀번호 암호화 및 XSS 방어 로직 구현
2. **프론트엔드 개선**: 반응형 디자인 및 사용자 친화적 UI/UX 개발
3. **코드 품질 향상**: 단위 테스트 도입 및 코드 리팩토링
4. **신기술 도입**: Spring Framework 및 JPA 적용 검토

## 프로젝트 기간
2024/04/24 - 2024/05/27 (약 5주)
