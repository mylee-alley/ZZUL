<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="web.bean.dto.NoticeDTO" %>
<%@ page import="java.util.Enumeration"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="dao" class="web.bean.dao.NoticeDAO"/> 
<jsp:useBean id="dto" class="web.bean.dto.NoticeDTO"/> 
    
<% 
  String path = request.getRealPath("resources/image/notice");
  int max = 1024*1024*100;
  String enc = "UTF-8";
  DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
  MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
  
  int notiNum = Integer.parseInt(mr.getParameter("notiNum"));
  dto.setNotiNum(notiNum);  
  dto.setTitle(mr.getParameter("title"));
  dto.setImg(mr.getParameter("img"));
  dto.setContent(mr.getParameter("content"));
  
  int result = dao.notiChange(dto);
  
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
  
 if(result == 1){ %>
 <script>
	alert("공지사항이 수정되었습니다.");
	window.location="notiList.jsp";
 </script>
<% } else{%>
 <script>
	alert("공지사항 수정에 실패하였습니다.");
	history.go(-1);
 </script>
 
<% }%>