package com.dao;

import java.sql.*;
import java.util.*;
import com.model.User;

public class UserDAO {
	private Connection connection = null;

	public boolean register(User u) {
		String sql = "INSERT INTO users(name,email,password,mobile,role) VALUES(?,?,?,?, 'USER')";
		connection = ConnectionManager.getConnection();
		PreparedStatement p = null;
		try {
			p = connection.prepareStatement(sql);
			p.setString(1, u.getName());
			p.setString(2, u.getEmail());
			p.setString(3, u.getPassword());
			p.setString(4, u.getMobile());
			System.out.println(u.getName());
			return p.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public User login(String email, String password) {
		String sql = "SELECT * FROM users WHERE email=? AND password=?";
		connection = ConnectionManager.getConnection();
		PreparedStatement p = null;
		try {
			p = connection.prepareStatement(sql);
			p.setString(1, email);
			p.setString(2, password);
			try (ResultSet r = p.executeQuery()) {
				if (r.next())
					return read(r);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<User> getAllUsers() {
		connection = ConnectionManager.getConnection();
		PreparedStatement p = null;
		List<User> list = new ArrayList<>();
		try {
			p = connection.prepareStatement("SELECT id,name,email,mobile,role FROM users ORDER BY id DESC");
			ResultSet r = p.executeQuery();
			while (r.next()) {
				User u = new User();
				u.setId(r.getInt("id"));
				u.setName(r.getString("name"));
				u.setEmail(r.getString("email"));
				u.setMobile(r.getString("mobile"));
				u.setRole(r.getString("role"));
				list.add(u);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	private User read(ResultSet r) throws SQLException {
		User u = new User();
		u.setId(r.getInt("id"));
		u.setName(r.getString("name"));
		u.setEmail(r.getString("email"));
		u.setPassword(r.getString("password"));
		u.setMobile(r.getString("mobile"));
		u.setRole(r.getString("role"));
		return u;
	}

	public void commit() {
		try {
			connection.commit();
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void rollback() {

		try {
			connection.rollback();
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
