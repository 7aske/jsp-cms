<%@ page import="com.example.cms.database.entity.Role" %>
<%@ page import="com.example.cms.database.RoleNames" %>
<%@ page import="com.example.cms.util.Util" %>
<%@ page import="java.util.HashSet" %>
<%
    String username = (String) session.getAttribute("username");
    Integer idUser = (Integer) session.getAttribute("idUser");
    Iterable<Role> roles = session.getAttribute("roles") != null ? ((Iterable<Role>) session.getAttribute("roles")) : new HashSet<Role>();
    boolean loggedIn = username != null && idUser != null;
%>
<jsp:include page="navMaterializeOverride.jsp"/>
<nav class="light-blue lighten-1" role="navigation">
    <ul id="dropdown1" class="dropdown-content">
        <li><a href="<%=request.getContextPath()%>/admin/admin.jsp">Posts</a></li>
        <% if (Util.hasRole(roles, RoleNames.ADMIN)) { %>
        <li><a href="<%=request.getContextPath()%>/admin/user/users.jsp">Users</a></li>
        <%}%>
        <li><a href="<%=request.getContextPath()%>/admin/tag/tags.jsp">Tags</a></li>

    </ul>
    <div class="nav-wrapper container">
        <a id="logo-container" href="${pageContext.request.contextPath}" class="brand-logo">BLOG</a>
        <a href="#" data-target="nav-mobile" class="sidenav-trigger right"><i class="material-icons">menu</i></a>
        <ul class="hide-on-med-and-down right">
            <li><a href="${pageContext.request.contextPath}">Home</a></li>
            <%if (loggedIn) { %>
            <li><a class="dropdown-trigger" href="#" data-target="dropdown1">More<i class="material-icons right">arrow_drop_down</i></a>
            </li>
            <li><a href="<%=request.getContextPath()%>/admin/logout">Logout</a></li>
            <% } %>
        </ul>
        <ul id="nav-mobile" class="sidenav">
            <li><a href="${pageContext.request.contextPath}">Home</a></li>
            <%if (loggedIn) { %>
            <li><a href="<%=request.getContextPath()%>/admin/admin.jsp">Posts</a></li>
            <% if (Util.hasRole(roles, RoleNames.ADMIN)) { %>
            <li><a href="<%=request.getContextPath()%>/admin/user/users.jsp">Users</a></li>
            <% } %>
            <li><a href="<%=request.getContextPath()%>/admin/tag/tags.jsp">Tags</a></li>
            <li><a href="<%=request.getContextPath()%>/admin/logout">Logout</a></li>
            <% } %>
        </ul>
    </div>
</nav>
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", () => {
        M.Dropdown.init(document.querySelector(".dropdown-trigger"), {});
        M.Sidenav.init(document.querySelector(".sidenav"), {edge: "right"});
    });
</script>