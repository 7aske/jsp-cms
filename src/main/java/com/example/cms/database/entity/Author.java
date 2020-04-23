package com.example.cms.database.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "author")
public class Author extends User implements Serializable {
	@JoinColumn(name = "id_user", referencedColumnName = "id_user")
	@ManyToOne
	private User idUser;

	@Column(name = "email")
	private String email;

	@Column(name = "username")
	private String username;

	@Column(name = "password")
	private String password;

	@Column(name = "active")
	private Boolean active;

	public Author() {
	}

	@Override
	public String getEmail() {
		return email;
	}

	@Override
	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String getUsername() {
		return username;
	}

	@Override
	public void setUsername(String username) {
		this.username = username;
	}

	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public Boolean getActive() {
		return active;
	}

	@Override
	public void setActive(Boolean active) {
		this.active = active;
	}

	@Override
	public String toString() {
		return "Author{" +
				"email='" + email + '\'' +
				", username='" + username + '\'' +
				", password='" + password + '\'' +
				", active=" + active +
				'}';
	}
}
