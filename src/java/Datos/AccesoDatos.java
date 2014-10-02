package Datos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

public class AccesoDatos
{

    private final String DB_USUARIO = "root";
    private final String DB_CLAVE = "hola";
    private final String DB_HOSTNAME = "localhost";
    private final String DB_PUERTO = "3306";
    private final String DB_NOMBRE = "cimax";
    private final String DB_CONECTOR = String.format("jdbc:mysql://%s:%s/%s?user=%s&password=%s",
    DB_HOSTNAME, DB_PUERTO, DB_NOMBRE, DB_USUARIO, DB_CLAVE);
    
    private Connection conexion;

    public AccesoDatos() throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        conexion = (Connection) DriverManager.getConnection(DB_CONECTOR, DB_USUARIO, DB_CLAVE);
        conexion.setAutoCommit(false);
    }

    public Connection getConexion(){
        return conexion;
    }
	
	public boolean commit()
	{
		boolean rta;
		try
		{
			conexion.commit();
			rta = true;
		}
		catch (SQLException e)
		{
			rta = false;
		}
		return rta;
	}
	
	public void rollback()
	{
		try{conexion.rollback();}
                catch(SQLException e){}
	}
	
    public boolean EjecutarNonQuery(String pNonQuery)
    {
        Statement query;
        boolean rta;
        try{
        query = conexion.createStatement();
        query.executeUpdate(pNonQuery);
        query.close();
        rta = true;
        }
        catch (SQLException e){
            rta = false;
        }
        return rta;
    }
    
    public int EjecutarQueryCount(String pQuery) throws Exception
    {
        int ocurrencias = 0;

        Statement query;
        ResultSet resultado;
        query = conexion.createStatement();
        resultado = query.executeQuery(pQuery);
        resultado.next();
        ocurrencias = resultado.getInt(1);
        query.close();

        return ocurrencias;
    }

    public int EjecutarQueryInt(String pQuery)
    {
        int rta = -1;
        Statement query;
        ResultSet resultado;
        try{
            query = conexion.createStatement();
            resultado = query.executeQuery(pQuery);
            if(resultado.next()){
                rta = resultado.getInt(1);
            }
            else{
                rta=0;
            }
            //query.close();
        }
        catch (Exception e){}
        return rta;
    }

    public ResultSet EjecutarQuery(String pQuery) throws Exception
    {
        ResultSet resultado;
        Statement query;

        query = conexion.createStatement();
        resultado = query.executeQuery(pQuery);

        return resultado;
    }

    protected void closeCon()
    {
        try{
			conexion.close();
		}
		catch (Exception e){}
    }
}