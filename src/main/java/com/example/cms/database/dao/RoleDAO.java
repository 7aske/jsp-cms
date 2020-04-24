package com.example.cms.database.dao;

import com.example.cms.database.entity.Role;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;

public class RoleDAO extends AbstractDAO<Role> {
	private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("blogpu");
	private final EntityManager em = emf.createEntityManager();

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


	public RoleDAO() {
		super(Role.class);
	}

	public Role findByName(final String roleName) {
		final String query = "select r from Role r where r.roleName = :roleName";
		try {
			return getEntityManager().createQuery(query, Role.class)
					.setParameter("roleName", roleName)
					.getSingleResult();
		} catch (NoResultException e) {
			e.printStackTrace();
			return null;
		}
	}
}
