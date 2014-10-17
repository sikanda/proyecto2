package Datos;

import Entidades.Herramienta;
import java.sql.ResultSet;
import java.util.*;


public class HerramientaDB extends AccesoDatos {

public HerramientaDB() throws Exception{}

	//Todo: agregar metodos custom, if necessary
     public boolean save(Herramienta h){ 
        boolean rta = false;
		//ver si afecta en algo los '' de los float
        	rta = EjecutarNonQuery("insert into herramientas (descHerramienta)  VALUES ( '" + h.getDescHerramienta()  +  "' )");
                if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }

  public boolean update(Herramienta h){
        boolean rta = false;
		rta = EjecutarNonQuery("UPDATE herramientas SET descHerramienta = '" + h.getDescHerramienta() + "' WHERE idHerramienta = " + h.getIdHerramienta());
         
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
  
   public boolean delete(int idH){
        boolean rta = false;
		rta = EjecutarNonQuery("delete from herramientas WHERE idHerramienta = " + idH);
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
   
       public List getHerramientas() throws Exception{
            List listaHe = new ArrayList();
            ResultSet resultado = EjecutarQuery("SELECT  idHerramienta, descHerramienta FROM herramientas");
            while (resultado.next()){
                Herramienta he = new Herramienta();
                he.setIdHerramienta(resultado.getString(1));
                he.setDescHerramienta(resultado.getString(2));
         
                listaHe.add(he);
            }
            closeCon();
            return listaHe;
	}
       
      public Herramienta getHerramienta(int idHerramienta) throws Exception
    {
        Herramienta he = new Herramienta();
        ResultSet resultado = EjecutarQuery("SELECT  idHerramienta, descHerramienta FROM herramientas WHERE idHerramienta = " + idHerramienta);

        while (resultado.next())
        {
			he.setIdHerramienta(resultado.getString(1));
			he.setDescHerramienta(resultado.getString(2));
        }
        resultado.close();
        return he;
    }
      
          public int getIdHerramienta(){
        int rta = EjecutarQueryInt("SELECT MAX(idHerramienta) FROM herramientas")+1;
        closeCon();
        return (rta);

    }
}