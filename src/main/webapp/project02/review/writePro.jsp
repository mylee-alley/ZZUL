<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="web.bean.dto.ReviewFileDTO" %>
<%@ page import="java.util.Enumeration" %>
<jsp:useBean id="dto" class="web.bean.dto.ReviewDTO" />
<jsp:useBean id="dao" class="web.bean.dao.ReviewDAO" />
<%
   String sid = (String)session.getAttribute("sid");
   
   String path = request.getRealPath("resources/image/review_img");
   int max = 1024*1024*100;
   String enc = "UTF-8";
   DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
   MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
   
   dto.setNum(Integer.parseInt(mr.getParameter("num")));
   dto.setRef(Integer.parseInt(mr.getParameter("ref")));
   dto.setRe_step(Integer.parseInt(mr.getParameter("re_step")));
   dto.setRe_level(Integer.parseInt(mr.getParameter("re_level")));
   dto.setWriter(mr.getParameter("writer"));
   dto.setSubject(mr.getParameter("subject"));
   if(sid==null || !sid.equals("admin")){
      dto.setStar(Integer.parseInt(mr.getParameter("star")));
   }
   dto.setContent(mr.getParameter("content"));
   dto.setReg_date(new Timestamp(System.currentTimeMillis()));
   dto.setRsvt_id(mr.getParameter("rsvt_id"));
   
   dao.insertReview(dto);
   dao.reviewUpload(mr.getParameter("rsvt_id"));
   
   int reviewnum = dao.maxNum();
   int fileCount=0;
   
   ReviewFileDTO fileDTO = new ReviewFileDTO();
   Enumeration enu = mr.getFileNames();
   while(enu.hasMoreElements()){
      String key = (String) enu.nextElement();
      String fileName = mr.getFilesystemName(key);
      String type = mr.getContentType(key);
      if(type != null){
         type = type.split("/")[0];}
      if(fileName != null){
         if(type.equals("image")){
            fileCount++;
            fileDTO.setReview_num(reviewnum);
            fileDTO.setFilename(fileName);
            dao.insertFile(fileDTO);
         }else{
            File f = new File(path+"//"+fileName);
            f.delete();
            response.getWriter().write("<script>alert('사진만 등록 가능합니다.'); history.go(-1);</script>");
            dao.deleteReview(reviewnum);
            return;
         }
      }
   }
   
   if(fileCount > 0){
      dao.updateFile(fileCount, reviewnum);
   }
   
   response.sendRedirect("list.jsp");
%>