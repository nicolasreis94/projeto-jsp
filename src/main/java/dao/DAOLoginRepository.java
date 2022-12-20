package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import connection.SingleConnectionBanco;
import entities.ModelLogin;

public class DAOLoginRepository {
	
	private Connection connection;

	public DAOLoginRepository() {
		
		connection = SingleConnectionBanco.getConnection();
	}
	
	public boolean validarAuth(ModelLogin modelLogin) throws Exception{
		
		
		String sql = "select * from model_login where login = ? and senha = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, modelLogin.getLogin());
		preparedStatement.setString(2, modelLogin.getSenha());

		
		ResultSet resultSet = preparedStatement.executeQuery();
		
		if(resultSet.next()) {
			return true; // autenticado
			
		}
		
		return false;// não autenticado
		
		
	}
	
	

}
