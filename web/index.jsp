<%@ page import="com.example.cms.database.entity.Post" %>
<%@ page import="com.example.cms.database.dao.PostDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
  <title>Blog</title>
  <jsp:include page="include/head.jsp"/>
</head>
<body>
<jsp:include page="include/nav.jsp"/>
<div class="section no-pad-bot">
  <div class="container">
    <br><br>
    <h1 class="header center orange-text">Blog Template</h1>
    <div class="row center">
      <h5 class="header col s12 light">A modern responsive front-end framework based on Material Design</h5>
    </div>
  </div>
</div>
<%
  List<Post> posts = new PostDAO().findAllPublished();
  pageContext.setAttribute("posts", posts);
%>
<div class="row">
  <c:forEach items="${posts}" var="post">
    <jsp:include page="fragment/indexPost.jsp">
      <jsp:param name="title" value="${post.title}"/>
      <jsp:param name="excerpt" value="${post.excerpt}"/>
      <jsp:param name="idUser" value="${post.idUser.idUser}"/>
      <jsp:param name="slug" value="${post.slug}"/>
      <jsp:param name="datePosted" value="${post.datePosted}"/>
      <jsp:param name="tags" value="${post.tags.stream().map(t -> t.name).reduce((l, r) -> l += ',' += r).orElse('')}"/>
      <jsp:param name="display_name" value="${post.idUser.displayName}"/>
    </jsp:include>
  </c:forEach>
</div>
<br><br>
<jsp:include page="include/footer.jsp"/>
</body>
</html>
