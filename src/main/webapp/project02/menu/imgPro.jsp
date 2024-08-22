<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.io.File"%>
<jsp:useBean id="dao" class="web.bean.dao.MenuDAO" />
<jsp:useBean id="dto" class="web.bean.dto.MenuDTO" />
<%
//    String path = request.getRealPath("project02/menu");
//   String path = request.getRealPath("project02/resources");
    String path = request.getRealPath("resources/image/menu");
   int max = 1024*1024*10;
   String enc = "UTF-8";
   DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
   MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
      
   String sysName = mr.getFilesystemName("img");
   String type = mr.getContentType("img");
   type = type.split("/")[0];
   int num = Integer.parseInt(mr.getParameter("num"));
   
   dto = dao.getMenuDetail(num);
   String fname = dto.getImg();
   
   if(type.equals("image")){
    
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