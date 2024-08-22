<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Enumeration"%>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dto" class="web.bean.dto.NoticeDTO" />
<jsp:useBean id="dao" class="web.bean.dao.NoticeDAO"/>

<%
 String path = request.getRealPath("resources/image/notice");
 int max = 1024*1024*100;
 String enc = "UTF-8";
 DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
 MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
 
 String title = mr.getParameter("title"); 
 String content = mr.getParameter("content"); 
 
 dto.setTitle(title);
 dto.setContent(content);
 dto.setReg_date(new Timestamp(System.currentTimeMillis()));
 
 dao.notiAdd(dto);
 int notiNum = dao.maxNotiNum(); 
 
 Enumeration enu = mr.getFileNames();
 while(enu.hasMoreElements()){
    String key = (String)enu.nextElement();//저장된 파일이름 문자열로 가져오기
    String fileName = mr.getFilesystemName(key);//시스템에 저장돼있는 파일이름
    
    String type = mr.getContentType(key);//저장된 파일의 타입
    if(type != null){ type = type.split("/")[0];}
    if(fileName != null){
       if(type.equals("image")){
          dao.imgAdd(fileName , notiNum);
          
       } else{
          File f = new File(path+"//"+fileName);
          f.delete();
          response.getWriter().write("<script>alert('사진만 등록 가능합니다.');history.go(-1;</script>)");
       }
    }
 }
 

 if(title != null && content != null){ %> 
    <script>
      alert("새 공지사항이 등록되었습니다.");
      window.location="notiList.jsp";
   </script>
<% } else {%>
    <script>
      alert("공지등록 실패");
      history.go(-1);
   </script>    
<% }%>