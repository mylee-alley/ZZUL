<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.io.File"%>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="dao" class="web.bean.dao.MenuDAO" />
<%
   String path = request.getRealPath("project02/menu");
   int max = 1024*1024*10;
   String enc = "UTF-8";
   DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
   MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
      
   String sysName = mr.getFilesystemName("img");
   String type = mr.getContentType("img");
   type = type.split("/")[0];
   String fname;
   
   if(type.equals("image")){      
       fname = sysName;
      int num = Integer.parseInt(mr.getParameter("num"));
      dao.imgChange(sysName, num);
      File f = new File(path+"/"+fname);
      f.delete();
%>      <script>
         alert("사진이 등록되었습니다.");
         window.close();
      </script>
<%   }else{
      File f = new File(path+"/"+sysName);
      f.delete();
%>      <script>
         alert("이미지 파일만 등록 가능합니다.");
         history.go(-1);
      </script>
<%   }%>
