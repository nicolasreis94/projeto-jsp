package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionBanco;
import entities.ModelLogin;

public class DAOUsuarioRepository {

	private Connection connection;

	public DAOUsuarioRepository() {
		connection = SingleConnectionBanco.getConnection();

	}

	public ModelLogin gravarUser(ModelLogin objeto) throws Exception {
		
		if (objeto.isNovo()) {// grava um novo 

		String sql = "INSERT INTO model_login(login, senha, nome, email) VALUES (?, ?, ?, ?);";
		PreparedStatement preparaSql = connection.prepareStatement(sql);

		preparaSql.setString(1, objeto.getLogin());
		preparaSql.setString(2, objeto.getSenha());
		preparaSql.setString(3, objeto.getNome());
		preparaSql.setString(4, objeto.getEmail());

		preparaSql.execute();

		connection.commit();
		
		}else {
			String sql = "UPDATE model_login SET login=?, senha=?, nome=?, email=?	WHERE id = "+objeto.getId()+";";
			PreparedStatement prepararSql = connection.prepareStatement(sql);
			prepararSql.setString(1, objeto.getLogin());
			prepararSql.setString(2, objeto.getSenha());
			prepararSql.setString(3, objeto.getNome());
			prepararSql.setString(4, objeto.getEmail());
			
			prepararSql.executeUpdate();
			connection.commit();
			
			
		}
		

		return this.consultaUser(objeto.getLogin());

	}

	public ModelLogin consultaUser(String login) throws Exception {

		ModelLogin modelLogin = new ModelLogin();
		String sql = "select * from model_login where upper(login) = upper('" + login + "')";
		PreparedStatement stat = connection.prepareStatement(sql);

		ResultSet resultado = stat.executeQuery();

		while (resultado.next()) {

			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setNome(resultado.getString("nome"));
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setSenha(resultado.getString("senha"));

		}

		return modelLogin;

	}
	
	
	public ModelLogin consultaUserId(String id) throws Exception {

		ModelLogin modelLogin = new ModelLogin();
		String sql = "select * from model_login where id= ?";
		PreparedStatement stat = connection.prepareStatement(sql);
		stat.setLong(1, Long.parseLong(id));
		
		ResultSet resultado = stat.executeQuery();

		while (resultado.next()) {

			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setNome(resultado.getString("nome"));
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setSenha(resultado.getString("senha"));

		}

		return modelLogin;

	}
	
	public ModelLogin listarTodos () throws SQLException {
		ModelLogin modelLogin = new ModelLogin();
		String sql = "select * from model_login";
		PreparedStatement stat = connection.prepareStatement(sql);		
		ResultSet resultado = stat.executeQuery();
		
		while (resultado.next()) {

			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setNome(resultado.getString("nome"));
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setSenha(resultado.getString("senha"));
			System.out.println(modelLogin);

		}
		return modelLogin;
		
	}

	public boolean validarLogin(String login) throws Exception {
		String sql = "select count(1) > 0 as existe from model_login where upper(login) = upper('" + login + "');";

		PreparedStatement stat = connection.prepareStatement(sql);
		ResultSet resultado = stat.executeQuery();

		resultado.next();
		return resultado.getBoolean("existe");

	}
	
	public void deletarUser (String idUser) throws Exception {
		
		String sql = "delete from model_login where id = ? ;";
		PreparedStatement prepararSql = connection.prepareStatement(sql);
		prepararSql.setLong(1, Long.parseLong(idUser));
		prepararSql.executeUpdate();
		connection.commit();	
		
		
	}
	
public List<ModelLogin> consultaUsuarioList(String nome) throws Exception {
		
		List<ModelLogin> retorno = new ArrayList<ModelLogin>();
		
		String sql = "select * from model_login  where upper(nome) like upper(?) ";
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setString(1, "%" + nome + "%");
		
		ResultSet resultado = statement.executeQuery();
		
		while (resultado.next()) { /*percorrer as linhas de resultado do SQL*/
			
			ModelLogin modelLogin = new ModelLogin();
			
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setNome(resultado.getString("nome"));
			//modelLogin.setSenha(resultado.getString("senha"));
			
			retorno.add(modelLogin);
		}
		
		
		return retorno;
	}
}
