<%@ page import="java.time.LocalDate" %>
<%
    Long idComment = Long.parseLong(request.getParameter("idComment"));
    Long idPost = Long.parseLong(request.getParameter("idPost"));
    String commenterEmail = request.getParameter("commenterEmail");
    String commenterName = request.getParameter("commenterName");
    String body = request.getParameter("body");
    LocalDate dateCommented = LocalDate.parse(request.getParameter("dateCommented"));
%>

<div class="row" id="comment-<%=idComment%>">
    <h5>
        <%=commenterName%>
        <span style="font-size: .55em;">&nbsp;on <%=dateCommented%></span>
    </h5>
    <p class="truncate comment-body">
        <%=body%>
    </p>
    <button class="show-more" id="show-<%=idComment%>" onclick="(function() {
        const b = document.querySelector('#comment-<%=idComment%> .comment-body');
        b.classList.toggle('truncate');
    })()">Show More</button>
    <button class="show-less" id="hide-<%=idComment%>" onclick="(function() {
        const b = document.querySelector('#comment-<%=idComment%> .comment-body');
        b.classList.toggle('truncate');
    })()">Show Less</button>
</div>
