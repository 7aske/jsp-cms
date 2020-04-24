package com.example.cms.database.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "role")
public class Role implements Serializable {
	@Id
	@GeneratedValue
	@Column(name = "id_role")
	private Long idRole;

	@Column(name = "role_name")
	private String roleName;

	public Role() {
	}

	public Long getIdRole() {
		return idRole;
	}

	public void setIdRole(Long idRole) {
		this.idRole = idRole;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	@Override
	public String toString() {
		return "Role{" +
				"idRole=" + idRole +
				", roleName='" + roleName + '\'' +
				'}';
	}
}
