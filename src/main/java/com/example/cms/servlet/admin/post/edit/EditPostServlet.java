package com.example.cms.servlet.admin.post.edit;

import com.example.cms.config.Config;
import com.example.cms.database.dao.PostDAO;
import com.example.cms.database.dao.TagDAO;
import com.example.cms.database.dao.UserDAO;
import com.example.cms.database.entity.Post;
import com.example.cms.database.entity.Tag;
import com.example.cms.database.entity.User;
import com.example.cms.util.UrlUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@WebServlet("/admin/post/edit/*")
public class EditPostServlet extends HttpServlet {
	// TODO: all these idPost should be changed to blog post
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idPost = UrlUtil.getUrlBase(request.getRequestURL().toString());
		request.setAttribute("idPost", idPost);
		request.getRequestDispatcher("/admin/post/edit.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idPostString = request.getParameter("id_post");
		String idUserString = request.getParameter("id_user");
		long idPost;
		int idUser;

		String title = request.getParameter("title");
		String slug = request.getParameter("slug");
		String excerpt = request.getParameter("excerpt");
		String body = request.getParameter("body");
		boolean published = false;
		if (request.getParameter("published") != null && request.getParameter("published").equals("on")) {
			published = true;
		}
		UserDAO userDAO = new UserDAO();
		TagDAO tagDAO = new TagDAO();
		Set<Tag> tagList = new HashSet<>();
		String[] tags = request.getParameter("tags").split(",");
		for (String tagName : tags) {
			Tag tag = tagDAO.findByName(tagName);
			if (tag != null) {
				tagList.add(tag);
			}
		}
		User user = null;
		try {
			idUser = Integer.parseInt(idUserString);
			user = userDAO.find(idUser);
		} catch (NumberFormatException ignored){
		}
		PostDAO blogPostDAO = new PostDAO();
		try {
			idPost = Long.parseLong(idPostString);
			Post post = blogPostDAO.find(idPost);
			post.setTitle(title);
			post.setSlug(UrlUtil.encodeValue(slug));
			post.setBody(body);
			post.setExcerpt(excerpt);
			post.setPublished(published);
			post.setTags(tagList);
			blogPostDAO.update(post);
		} catch (NumberFormatException ex) {
			Post post = new Post();
			post.setTitle(title);
			post.setSlug(UrlUtil.encodeValue(slug));
			post.setBody(body);
			post.setExcerpt(excerpt);
			post.setPublished(published);
			post.setDatePosted(LocalDate.now());
			post.setTags(tagList);
			post.setIdUser(user);
			// FIXME
			// post.setAuthor((String) Config.getProperties().get("author"))
			blogPostDAO.create(post);
		}
		response.sendRedirect(request.getContextPath() + "/admin/post/edit/" + idPostString);
	}
}
