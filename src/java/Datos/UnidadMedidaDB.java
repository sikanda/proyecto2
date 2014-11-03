package Datos;

import Entidades.UnidadMedida;
import java.sql.ResultSet;
import java.util.*;


public class UnidadMedidaDB extends AccesoDatos {

public UnidadMedidaDB() throws Exception{}


    public List getUnidadesDeMedida() throws Exception{
      List listaUm = new ArrayList();
      ResultSet resultado = EjecutarQuery("SELECT  idUnidadMedida, descUnidadMedida FROM unidadesmedida order by descUnidadMedida");
      while (resultado.next()){
          UnidadMedida um = new UnidadMedida();
          um.setIdUnidadMedida(resultado.getString(1));
          um.setDescUnidadMedida(resultado.getString(2));

          listaUm.add(um);
      }
      closeCon();
      return listaUm;
  }  
    
      public boolean save(UnidadMedida u){ 
        boolean rta = false;
		rta = EjecutarNonQuery("insert into unidadesmedida (idUnidadMedida, descUnidadMedida)  VALUES ( '" + u.getIdUnidadMedida()  + "' , '" + u.getDescUnidadMedida() +  "' )");
		if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }

  public boolean update(UnidadMedida u){
        boolean rta = false;
		rta = EjecutarNonQuery("UPDATE unidadesmedida SET descUnidadMedida = '" + u.getDescUnidadMedida()  + "' WHERE idUnidadMedida = '" + u.getIdUnidadMedida()+"'");
        
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
  
   public boolean delete(String idUm){
        boolean rta = false;
        if (validarCantUM(idUm)==0){
		rta = EjecutarNonQuery("delete from unidadesmedida WHERE idUnidadMedida = '" + idUm + "'");
        }
        if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
   
   
         public UnidadMedida getUnidadMedida(String idUm) throws Exception
    {
        UnidadMedida um = new UnidadMedida();
        ResultSet resultado = EjecutarQuery("SELECT  descUnidadMedida FROM unidadesmedida WHERE idUnidadMedida = '" + idUm +"'");

        while (resultado.next())
        {
            um.setIdUnidadMedida(idUm);
            um.setDescUnidadMedida( resultado.getString(1));

        }
        resultado.close();
        return um;
    }
         
               
    public int validarCantUM(String idUM){
   // int rta = EjecutarQueryInt("SELECT Count(*) FROM unidadesmedida u LEFT join rubros r on u.idUnidadMedida = r.idUnidadMedida  LEFT join  materiales ma on u.idUnidadMedida = ma.idUnidadMedida LEFT join manodeobra mo on u.idUnidadMedida = mo.idUnidadMedida  where u.idunidadmedida = '" + idUM+"'" );
    //closeCon();
    
    int rta1 = EjecutarQueryInt("Select count(*) from rubros where idUnidadMedida = '" + idUM+"'" );
    int rta2 = EjecutarQueryInt("Select count(*) from manodeobra where idUnidadMedida = '" + idUM+"'" );
    int rta3 = EjecutarQueryInt("Select count(*) from materiales where idUnidadMedida = '" + idUM+"'" );
   
    int rta = rta1+rta2+rta3;
    return (rta);
       } 
      
      
    public int verificaCodUm(String cod){
        int rta = EjecutarQueryInt("SELECT count(*) FROM unidadesmedida where idUnidadMedida = '" + cod +"'");
        closeCon();
        return (rta);

    }
}
