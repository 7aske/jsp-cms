<%@ page import="com.example.cms.database.entity.Post" %>
<%@ page import="com.example.cms.database.dao.PostDAO" %>
<%@ page import="com.example.cms.config.Config" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String slug = (String) request.getAttribute("postSlug");
    if (slug == null) {
        response.sendRedirect(request.getContextPath());
        return;
    }
    Post post = new PostDAO().findBySlug(slug);
    if (post == null) {
        response.sendRedirect(request.getContextPath());
        return;
    }

    request.setAttribute("post", post);
%>
<%
    String username = (String) session.getAttribute("username");
    String confUsername = Config.getProperties().getProperty("blog-username");
    boolean loggedIn = username != null && username.equals(confUsername);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
    <title>
        Blog - <%= post.getTitle()%>
    </title>
    <jsp:include page="include/head.jsp"/>
    <jsp:include page="include/markdown.jsp"/>
    <style>
        .post-body img {
            max-width: 100%;
        }
    </style>
</head>
<body>
<jsp:include page="include/nav.jsp"/>
<nav class="light-blue lighten-2">
    <div class="nav-wrapper container">
        <div class="col s12">
            <a href="${pageContext.request.contextPath}" class="breadcrumb">
                Home
            </a>
            <a href="${pageContext.request.contextPath}/post/${pageContext.request.getAttribute("post").slug}"
               class="breadcrumb">
                <%= post.getTitle()%>
            </a>
        </div>
    </div>
</nav>
<div class="section no-pad-bot">
    <div class="container">
        <h2>
            <%= post.getTitle()%>
            <%
                if (loggedIn) {
                    out.print(String.format("<a class=\"btn orange\" href=\"%s/admin/post/edit/%d\">Edit<i class=\"material-icons right\">edit</i></a>", request.getContextPath(), post.getIdPost()));
                }
            %>
        </h2>
    </div>
</div>
<div class="container">
    <div class="post-body"><%=post.getBody()%></div>
    <br><br>
</div>
<jsp:include page="include/footer.jsp"/>
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", () => {
        const postBody = document.querySelector(".post-body");
        // const converter = new showdown.Converter();
        // postBody.innerHTML = converter.makeHtml(postBody.innerHTML);
        postBody.innerHTML = marked(postBody.innerHTML, {
            "baseUrl": null,
            "breaks": false,
            "gfm": true,
            "headerIds": true,
            "highlight": null,
            "mangle": true,
            "sanitize": false,
            "smartLists": true,
            "smartypants": true,
            "xhtml": false
        });
    });
</script>
</body>
</html>

