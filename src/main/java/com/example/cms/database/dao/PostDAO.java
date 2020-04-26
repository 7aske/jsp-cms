package com.example.cms.database.dao;

import com.example.cms.database.entity.Post;
import com.example.cms.database.entity.Tag;
import com.example.cms.database.entity.User;
import com.example.cms.util.SetUtil;

import javax.persistence.*;
import java.util.*;
import java.util.stream.Collectors;

public class PostDAO extends AbstractDAO<Post> {
	private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("blogpu");
	private final EntityManager em = emf.createEntityManager();

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
			return getEntityManager().createQuery(query, Post.class)
					.setParameter("slug", slug)
					.getSingleResult();
		} catch (NoResultException e) {
			e.printStackTrace();
			return null;
		}
	}

	public List<Post> findByTagName(final String tagName) {
		Set<Tag> tagSet = new HashSet<>();
		Tag tag = new TagDAO().findByName(tagName);
		if (tag != null) {
			tagSet.add(tag);
		}
		return findByTagList(tagSet);
	}

	public List<Post> findByTagList(final Collection<Tag> tags) {
		// SCREW YOU JPA
		List<Post> posts = findAll();
		return posts.stream().filter(p -> SetUtil.inter(p.getTags(), tags).size() > 0).collect(Collectors.toList());
	}

	public List<Post> findPublishedByTagName(final String tagName) {
		Set<Tag> tagSet = new HashSet<>();
		Tag tag = new TagDAO().findByName(tagName);
		if (tag != null) {
			tagSet.add(tag);
		}
		return findPublishedByTagList(tagSet);
	}

	public List<Post> findPublishedByTagName(final String tagName, int limit) {
		Set<Tag> tagSet = new HashSet<>();
		Tag tag = new TagDAO().findByName(tagName);
		if (tag != null) {
			tagSet.add(tag);
		}
		return findPublishedByTagList(tagSet, limit);
	}

	public List<Post> findPublishedByTagList(final Collection<Tag> tags) {
		// SCREW YOU JPA
		List<Post> posts = findAllPublished();
		return posts.stream().filter(p -> SetUtil.inter(p.getTags(), tags).size() > 0).collect(Collectors.toList());
	}

	public List<Post> findPublishedByTagList(final Collection<Tag> tags, int limit) {
		// SCREW YOU JPA
		List<Post> posts = findAllPublished();
		return posts.stream().limit(limit).filter(p -> SetUtil.inter(p.getTags(), tags).size() > 0).collect(Collectors.toList());
	}

	public List<Post> findAllPublished() {
		final String query = "select bp from Post bp where bp.published = :published order by bp.datePosted desc";
		try {
			return getEntityManager().createQuery(query, Post.class)
					.setParameter("published", true)
					.getResultList();
		} catch (NoResultException e) {
			e.printStackTrace();
			return null;
		}
	}
	public List<Post> findAllPublished(int limit) {
		final String query = "select bp from Post bp where bp.published = :published order by bp.datePosted desc";
		try {
			return getEntityManager().createQuery(query, Post.class)
					.setParameter("published", true)
					.setMaxResults(limit)
					.getResultList();
		} catch (NoResultException e) {
			e.printStackTrace();
			return null;
		}
	}
}
