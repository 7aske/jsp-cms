<%@ page import="com.example.cms.database.dao.UserDAO" %>
<%@ page import="com.example.cms.database.RoleNames" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
    <title>Blog - Admin Login</title>
    <jsp:include page="../include/head.jsp"/>
    <jsp:include page="../include/materializeOverride.jsp"/>
</head>
<body>
<jsp:include page="../include/nav.jsp"/>
<%
    if (new UserDAO().findByRoleName(RoleNames.ADMIN).size() == 0) {
        response.sendRedirect(request.getContextPath() + "/admin/setup.jsp");
    }
%>
<jsp:include page="../fragment/errorList.jsp"/>
<div class="container">
    <div class="row">
        <form class="col s12" method="post" action="${pageContext.request.contextPath}/admin/login">
            <div class="row">
                <br/>
                <br/>
                <div class="col s12 m12 l3"></div>
                <div class="col s12 m12 l6">
                    <div class="input-field col s12 m12 l12">
                        <i class="material-icons prefix">account_circle</i>
                        <input id="username" name="username" type="text" class="validate">
                        <label for="username">Username</label>
                    </div>
                    <div class="input-field col s12 m12 l12">
                        <i class="material-icons prefix">lock</i>
                        <input id="password" name="password" type="text" class="validate">
                        <label for="password">Password</label>
                    </div>
                    <div class="row">
                        <div class="col s12">
                            <button class="btn waves-light light-blue lighten-1" type="submit" name="action">
                                Submit<i class="material-icons right">send</i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <br><br>
</div>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        M.updateTextFields()
    });
</script>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>
