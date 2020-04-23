package com.example.cms.database.dao;

import com.example.cms.database.entity.Post;

import javax.persistence.*;
import java.util.Comparator;
import java.util.List;

public class PostDAO extends AbstractDAO<Post> {
	private EntityManagerFactory emf = Persistence.createEntityManagerFactory("blogpu");
	private EntityManager em = emf.createEntityManager();

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public PostDAO() {
		super(Post.class);
	}

	@Override
	public List<Post> findAll() {
		List<Post> posts = super.findAll();
		posts.sort(Comparator.comparing(Post::getDatePosted).reversed());
		return posts;
	}

	public Post findBySlug(final String slug) {
		final String query = "select bp from Post bp where bp.slug = :slug";
		try {
			return em.createQuery(query, Post.class)
					.setParameter("slug", slug)
					.getSingleResult();
		} catch (NoResultException e) {
			e.printStackTrace();
			return null;
		}
	}

	public List<Post> findAllPublished() {
		final String query = "select bp from Post bp where bp.published = :published order by datePosted desc";
		try {
			return em.createQuery(query, Post.class)
					.setParameter("published", true)
					.getResultList();
		} catch (NoResultException e) {
			e.printStackTrace();
			return null;
		}
	}
}
