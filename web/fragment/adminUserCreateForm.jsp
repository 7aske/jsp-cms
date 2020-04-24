<%@ page import="com.example.cms.database.dao.RoleDAO" %>
<%@ page import="com.example.cms.database.entity.Role" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.cms.database.RoleNames" %>
<%@ page import="com.example.cms.database.entity.User" %>
<%
    boolean setup = request.getParameter("setup") != null && request.getParameter("setup").equals("true");
    User user = (User) request.getAttribute("user");
%>
<% if (setup) { %>
<form class="col s12" method="post" action="${pageContext.request.contextPath}/admin/create">
<%} else {%>
<form class="col s12" method="post" action="${pageContext.request.contextPath}/admin/user/edit<%= user != null ? "/" + user.getIdUser() : ""%>">
<%}%>
    <div class="row">
        <br/>
        <br/>
        <% if (setup) { %>
        <div class="row col s12 m12">
            <div class="input-field col s12 m12 l6 xl6">
                <p>Appears that there is no administrator account.</p>
                <p>Why don't you take time to set one up right now?</p>
                <p>Fill out the form accordingly.</p>
            </div>
        </div>
        <% } %>
        <label for="idUser">
            <input id="idUser" name="idUser" type="text" class="validate" hidden value="<%= user != null ? user.getIdUser() : "" %>">
        </label>
        <div class="row col s12 m12">
            <div class="input-field col s12 m12 l6 xl6">
                <input id="email" name="email" type="email" class="validate" value="${pageContext.request.getAttribute("user").email}" required>
                <label for="email">Email</label>
            </div>
        </div>
        <div class="col s12 m12"></div>
        <div class="row col s12 m12">
            <div class="input-field col s12 m12 l6 xl6">
                <input id="username" name="username" type="text" <%=request.getAttribute("user") != null ? "readonly" : ""%> class="validate" value="${pageContext.request.getAttribute("user").username}" required>
                <label for="username">Username</label>
                <span class="helper-text">Username you use to log in</span>
            </div>
        </div>
        <div class="row col s12 m12">
            <div class="input-field col s12 m12 l6 xl6">
                <input id="display_name" name="display_name" type="text" value="${pageContext.request.getAttribute("user").displayName}" class="validate" required>
                <label for="display_name">Display Name</label>
                <span class="helper-text">Name you want to be displayed when you submit a post</span>
            </div>
        </div>
        <div class="row col s12 m12">
            <div class="input-field col s12 m12 l6 xl6">
                <input id="password" name="password" type="password" class="validate" required>
                <label for="password">Password</label>
            </div>
        </div>
        <div class="row col s12 m12">
            <div class="input-field col s12 m12 l6 xl6">
                <input id="password_confirm" name="password_confirm" type="password" class="validate" required>
                <label for="password_confirm">Confirm Password</label>
                <span class="helper-text">Passwords must match</span>
            </div>
        </div>
        <% if (setup) { %>
        <label>
            <input type="checkbox" name="setup" checked class="hidden">
        </label>
        <% } else { %>
        <% }%>
        <div class="row col s12 m12">
            <div class="input-field col s12 m12 l6 xl6">
                <h6>Roles:</h6>
                <% List<Role> roles = new RoleDAO().findAll(); %>
                <% for (int i = 0; i < roles.size(); i++) { %>
                <p>
                    <label>
                        <input name="roles" value="<%=roles.get(i).getRoleName()%>" type="checkbox" class="filled-in"
                                <%= user != null && user.getRoles().contains(roles.get(i)) ? "checked": "" %>
                                <%= roles.get(i).getRoleName().equals(RoleNames.ADMIN) && setup ? "checked" : "" %>
                                <%= roles.get(i).getRoleName().equals(RoleNames.AUTHOR) && !setup ? "checked" : "" %>
                                <%= roles.get(i).getRoleName().equals(RoleNames.ADMIN) && setup ? "disabled" : "" %>
                                <%= roles.get(i).getRoleName().equals(RoleNames.AUTHOR) && !setup ? "disabled" : "" %>
                        />
                        <span><%=roles.get(i).getRoleName().toUpperCase().charAt(0) + roles.get(i).getRoleName().substring(1)%></span>
                    </label>
                </p>
                <% } %>
            </div>
        </div>
        <div class="row col s12 m12">
            <button class="light-blue btn" type="submit">submit</button>
        </div>
    </div>
</form>