<%
    Long idPost = Long.parseLong(request.getParameter("idPost"));

%>
<form class="row" method="post" action="${pageContext.request.contextPath}/comment">
    <input hidden type="text" id="idPost" name="idPost" value="<%=idPost%>">
    <div class="row" style="margin-bottom: 0">
        <div class="input-field col s6">
            <input id="commenter_name" name="commenter_name" type="text" class="validate">
            <label for="commenter_name">Name</label>
        </div>
        <div class="input-field col s6">
            <input id="commenter_email" name="commenter_email" type="email" class="validate" required>
            <label for="commenter_email">E-Mail</label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 0">
        <div class="input-field col s12">
            <textarea required id="body" name="body" class="materialize-textarea"></textarea>
            <label for="body">Message</label>
        </div>
    </div>
    <div class="row">
        <button class="btn orange">submit</button>
    </div>
</form>