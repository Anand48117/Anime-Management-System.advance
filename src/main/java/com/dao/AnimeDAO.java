package com.dao;

import java.sql.*;
import java.util.*;
import com.model.Anime;

public class AnimeDAO {
	private Connection connection = null;

	private Anime read(ResultSet r) throws SQLException {
		Anime a = new Anime();
		a.setId(r.getInt("id"));
		a.setName(r.getString("name"));
		a.setYear(r.getInt("release_year"));
		a.setSeasons(r.getInt("seasons"));
		a.setDescription(r.getString("description"));
		a.setImageUrl(r.getString("image_url"));
		a.setRating(r.getDouble("rating"));

		return a;
	}

	public List<Anime> getAll() {
		List<Anime> list = new ArrayList<>();
		String sql = "SELECT * FROM animes ORDER BY id DESC";
		connection = ConnectionManager.getConnection();
		PreparedStatement p = null;
		try {
			p = connection.prepareStatement(sql);
			ResultSet r = p.executeQuery();
			while (r.next())
				list.add(read(r));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public Anime getById(int id) {
		try (Connection c = ConnectionManager.getConnection();
				PreparedStatement p = c.prepareStatement("SELECT * FROM animes WHERE id=?")) {
			p.setInt(1, id);
			try (ResultSet r = p.executeQuery()) {
				if (r.next())
					return read(r);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean save(Anime a) {
		connection = ConnectionManager.getConnection();
		PreparedStatement p = null;
		String sql = "INSERT INTO animes(name,release_year,seasons,description,image_url,rating) VALUES(?,?,?,?,?,?)";
		try {
			p = connection.prepareStatement(sql);
			p.setString(1, a.getName());
			p.setInt(2, a.getYear());
			p.setInt(3, a.getSeasons());
			p.setString(4, a.getDescription());
			p.setDouble(5, a.getRating());
			p.setDouble(6, a.getRating());
			return p.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean update(Anime a) {
		String sql = "UPDATE animes SET name=?,release_year=?,seasons=?,description=?,image_url=?,rating=? WHERE id=?";
		connection = ConnectionManager.getConnection();
		PreparedStatement p = null;
		try {
			p = connection.prepareStatement(sql);
			p.setString(1, a.getName());
			p.setInt(2, a.getYear());
			p.setInt(3, a.getSeasons());
			p.setString(4, a.getDescription());
			p.setString(5, a.getImageUrl());
			p.setDouble(6, a.getRating());
			p.setInt(7, a.getId());
			return p.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean delete(int id) {
		connection = ConnectionManager.getConnection();
		PreparedStatement p = null;
		String query = "Delete from animes where id=?";
		try {
			p = connection.prepareStatement(query);
			p.setInt(1, id);
			return p.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean addFavorite(int userId, int animeId) {
		String sql = "INSERT IGNORE INTO favorites(user_id,anime_id) VALUES(?,?)";
		connection = ConnectionManager.getConnection();
		try {
			PreparedStatement p = connection.prepareStatement(sql);
			p.setInt(1, userId);
			p.setInt(2, animeId);
			return p.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<Anime> getFavorites(int userId) {
		List<Anime> list = new ArrayList<>();
		String sql = "SELECT a.* FROM animes a JOIN favorites f ON a.id=f.anime_id WHERE f.user_id=? ORDER BY a.name";
		connection = ConnectionManager.getConnection();
		PreparedStatement p = null;
		try {
			p = connection.prepareStatement(sql);
			p.setInt(1, userId);
			try (ResultSet r = p.executeQuery()) {
				while (r.next())
					list.add(read(r));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean rate(int userId, int animeId, double rating) {
		String sql = "INSERT INTO anime_ratings(user_id,anime_id,rating) VALUES(?,?,?) ON DUPLICATE KEY UPDATE rating=VALUES(rating)";
		connection = ConnectionManager.getConnection();
		PreparedStatement p = null;
		try {
			p = connection.prepareStatement(sql);
			p.setInt(1, userId);
			p.setInt(2, animeId);
			p.setDouble(3, rating);
			return p.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
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
