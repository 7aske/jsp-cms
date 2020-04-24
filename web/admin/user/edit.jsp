<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
    <title>Blog - Admin</title>
    <jsp:include page="../../include/head.jsp"/>
    <style>
        body {
            min-height: 100vh !important;
            display: flex;
            flex-direction: column;
        }

        .container {
            flex-grow: 4;
        }
    </style>
</head>
<body>
<jsp:include page="../../include/nav.jsp"/>
<nav class="light-blue lighten-2">
    <div class="nav-wrapper container">
        <div class="col s12">
            <a href="${pageContext.request.contextPath}" class="breadcrumb">
                Home
            </a>
            <a href="${pageContext.request.contextPath}/admin/admin.jsp"
               class="breadcrumb">
                Admin
            </a>
            <a href="${pageContext.request.contextPath}/admin/user/users.jsp"
               class="breadcrumb">
                Users
            </a>
            <a href="#" class="breadcrumb">
                Edit
            </a>
        </div>
    </div>
</nav>
<div class="container">
    <br/>
    <jsp:include page="../../fragment/errorList.jsp"/>
    <jsp:include page="../../fragment/adminUserCreateForm.jsp"/>
</div>
<br><br>
<jsp:include page="../../include/footer.jsp"/>
</body>
</html>
