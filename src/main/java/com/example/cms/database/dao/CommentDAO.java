package com.example.cms.database.dao;

import com.example.cms.database.entity.Comment;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class CommentDAO extends AbstractDAO<Comment> {
	private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("blogpu");
	private final EntityManager em = emf.createEntityManager();

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public CommentDAO() {
		super(Comment.class);
	}
}
