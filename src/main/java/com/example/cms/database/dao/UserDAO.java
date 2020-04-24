package com.example.cms.database.dao;

import com.example.cms.database.entity.Role;
import com.example.cms.database.entity.User;
import com.example.cms.util.SetUtil;

import javax.persistence.*;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class UserDAO extends AbstractDAO<User> {
	private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("blogpu");
	private final EntityManager em = emf.createEntityManager();

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public UserDAO() {
		super(User.class);
	}

	public User findByUsername(final String username) {
		final String query = "select u from User u where u.username = :username";
		try {
			return getEntityManager().createQuery(query, User.class)
					.setParameter("username", username)
					.getSingleResult();
		} catch (NoResultException e) {
			e.printStackTrace();
			return null;
		}
	}

	public List<User> findByRole(final Role role) {
		final Set<Role> roles = new HashSet<>();
		roles.add(role);
		return findByRoleList(roles);
	}

	public List<User> findByRoleName(final String roleName) {
		final Set<Role> roles = new HashSet<>();
		Role role = new RoleDAO().findByName(roleName);
		if (role != null) {
			roles.add(role);
		}
		return findByRoleList(roles);
	}

	public List<User> findByRoleList(final Set<Role> roles) {
		// Screw you JPA
		List<User> users = findAll();
		return users.stream().filter(u-> SetUtil.inter(u.getRoles(), roles).size() > 0).collect(Collectors.toList());
	}
}
