package Datos;

import Entidades.Usuario;
import java.sql.ResultSet;
import java.util.*;


public class UsuarioDB extends AccesoDatos {

public UsuarioDB() throws Exception{}

	//Todo: agregar metodos custom, if necessary
     public boolean save(Usuario u){ 
        boolean rta = false;
		rta = EjecutarNonQuery("insert into usuarios (nombreUsuario, pass)  VALUES ( '" + u.getNombreUsuario()  + "' , '" + u.getPass() +  "' )");
		if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }

  public boolean update(Usuario u){
        boolean rta = false;
		rta = EjecutarNonQuery("UPDATE usuarios SET nombreUsuario = '" + u.getNombreUsuario() + "', pass = '" + u.getPass() + "' WHERE idUsuario = " + u.getIdUsuario());
        
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
  
   public boolean delete(int idUser){
        boolean rta = false;
		rta = EjecutarNonQuery("delete from usuarios WHERE idUsuario = " + idUser);
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
   
       public List getUsuarios() throws Exception{
            List listaUser = new ArrayList();
            ResultSet resultado = EjecutarQuery("SELECT idUsuario, nombreUsuario, pass FROM usuarios");
            while (resultado.next()){
                Usuario user = new Usuario();
                user.setIdUsuario(resultado.getInt(1));
                user.setNombreUsuario(resultado.getString(2));
                user.setPass(resultado.getString(3));
            
                listaUser.add(user);
            }
            closeCon();
            return listaUser;
	}
       
      public Usuario getUsuario(int idUsuario) throws Exception
    {
        Usuario user = new Usuario();
        ResultSet resultado = EjecutarQuery("SELECT idUsuario, nombreUsuario, pass  FROM usuarios WHERE idUsuario = " + idUsuario);

        while (resultado.next())
        {
            user.setIdUsuario(idUsuario);
            user.setNombreUsuario(resultado.getString(2));
            user.setPass(resultado.getString(3));

        }
        resultado.close();
        return user;
    }
      
      public Usuario loginUsuario (String usuario, String pass) throws Exception
	{
		ResultSet resultado = EjecutarQuery("SELECT idUsuario, nombreUsuario, pass  FROM usuarios WHERE nombreUsuario = '" + usuario + "' AND pass = '" + pass + "'");
			Usuario user = null;
			while (resultado.next())
			{
				user = new Usuario();
				user.setIdUsuario(resultado.getInt(1));
				user.setNombreUsuario(usuario);
				user.setPass(pass);
        		 }
			resultado.close();
			closeCon();
			return user;
	}
      
        public int getIdUsuario(){
        int rta = EjecutarQueryInt("SELECT MAX(idUsuario) FROM usuarios")+1;
        closeCon();
        return (rta);

    }
        
       public int verificaNomUsuario(String nom, String idUs){
        int rta = EjecutarQueryInt("SELECT count(*) FROM usuarios where nombreUsuario = '" + nom +"' and idUsuario != '" + idUs+"'");
        closeCon();
        return (rta);

    }
}