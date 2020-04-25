<div class="col s12 m12 l12 xl3">
    <div class="card light-blue darken-1">
        <div class="card-content white-text">
            <span>Posted on <%=request.getParameter("datePosted")%></span> by <span class="orange-text"><%=request.getParameter("display_name")%></span>
            <h5 class="card-title">
                <%=request.getParameter("title")%>
            </h5>
            <p class="light">
                <%=request.getParameter("excerpt")%>
            </p>
            <div style="margin-top: .5em;">
                <%
                    String[] tags = request.getParameter("tags").split(",");
                    for (String tag : tags) {
                    	if(!tag.trim().equals("")){
                            out.print(String.format("<div style=\"font-size: 1em; height: 1.75em; line-height: 1.75em\" class=\"chip\"><a href=\"%s/?tag=%s\">%s</a></div>", request.getContextPath(), tag, tag));
                        }
                    }
                %>
            </div>
        </div>
        <div class="card-action">
            <a class="btn orange" href="${pageContext.request.contextPath}/post/${pageContext.request.getParameter("slug")}">Read more</a>
        </div>
    </div>
</div>
