<%@ page import="com.example.cms.database.entity.Post" %>
<%@ page import="com.example.cms.database.dao.PostDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="<%=session.getAttribute("lang")%>">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
    <title>Admin - Edit</title>
    <jsp:include page="../../include/head.jsp"/>
    <jsp:include page="../../include/mde.jsp"/>
</head>
<body>
<jsp:include page="../../include/nav.jsp"/>
<%
    Post post = null;
    try {
        long idBlogPost = Long.parseLong((String) request.getAttribute("idBlogPost"));
        post = new PostDAO().find(idBlogPost);
    } catch (NumberFormatException ignored) {
    }
    pageContext.setAttribute("post", post);
%>
<nav class="light-blue lighten-2">
    <div class="nav-wrapper container">
        <div class="col s12">
            <a href="${pageContext.request.contextPath}" class="breadcrumb">
                Home
            </a>
            <a href="${pageContext.request.contextPath}/admin/admin.jsp"
               class="breadcrumb">
                Posts
            </a>
            <c:if test="${post != null}">
                <a href="${pageContext.request.contextPath}/admin/post/edit/${post.idPost}"
                   class="breadcrumb">
                        ${post.title}
                </a>
            </c:if>
        </div>
    </div>
</nav>
<div class="container">
    <jsp:include page="../../fragment/postEditForm.jsp">
        <jsp:param name="idBlogPost" value="${post.idPost}"/>
        <jsp:param name="title" value="${post.title}"/>
        <jsp:param name="slug" value="${post.slug}"/>
        <jsp:param name="excerpt" value="${post.excerpt}"/>
        <jsp:param name="body" value="${post.body}"/>
        <jsp:param name="published" value="${post.published}"/>
    </jsp:include>
</div>
<br><br>
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", ()=>{
        M.updateTextFields();
        M.CharacterCounter.init(document.querySelectorAll("[data-length]"));
    });
</script>
<script type="text/javascript">
    const simplemde = new SimpleMDE({
        autofocus: true,
        autosave: {
            enabled: true,
            delay: 1000,
        },
        blockStyles: {
            bold: "__",
            italic: "_"
        },
        element: document.getElementById("body"),
        forceSync: true,
        indentWithTabs: false,
        insertTexts: {
            horizontalRule: ["", "\n\n-----\n\n"],
            image: ["![](http://", ")"],
            link: ["[", "](http://)"],
            table: ["", "\n\n| Column 1 | Column 2 | Column 3 |\n| -------- | -------- | -------- |\n| Text     | Text      | Text     |\n\n"],
        },
        lineWrapping: true,
        parsingConfig: {
            allowAtxHeaderWithoutSpace: true,
            strikethrough: false,
            underscoresBreakWords: true,
        },
        placeholder: "Type here...",
        promptURLs: true,
        renderingConfig: {
            singleLineBreaks: false,
            codeSyntaxHighlighting: true,
        },
        shortcuts: {
            drawTable: "Cmd-Alt-T"
        },
        showIcons: ["code", "table"],
        spellChecker: false,
        styleSelectedText: false,
        tabSize: 4,
        toolbarTips: false,
    });
</script>
<jsp:include page="../../include/footer.jsp"/>
</body>
</html>
