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
        	rta = EjecutarNonQuery("insert into herramientas (idHerramienta, descHerramienta, cantidad)  VALUES ( '"+ h.getIdHerramienta()+"' , '" + h.getDescHerramienta()  +  "', " + h.getCant()+ " )");
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
		rta = EjecutarNonQuery("UPDATE herramientas SET descHerramienta = '" + h.getDescHerramienta() + "', cantidad = " + h.getCant()+" WHERE idHerramienta = '" + h.getIdHerramienta()+"'");
         
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
  
   public boolean delete(String idH){
        boolean rta = false;
		rta = EjecutarNonQuery("delete from herramientas WHERE idHerramienta = '" + idH +"'");
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
            ResultSet resultado = EjecutarQuery("SELECT  idHerramienta, descHerramienta, cantidad FROM herramientas");
            while (resultado.next()){
                Herramienta he = new Herramienta();
                he.setIdHerramienta(resultado.getString(1));
                he.setDescHerramienta(resultado.getString(2));
                he.setCant(resultado.getInt(3));
         
                listaHe.add(he);
            }
            closeCon();
            return listaHe;
	}
       
      public Herramienta getHerramienta(String idHerramienta) throws Exception
    {
        Herramienta he = new Herramienta();
        ResultSet resultado = EjecutarQuery("SELECT  descHerramienta, cantidad FROM herramientas WHERE idHerramienta = '" + idHerramienta + "'");

        while (resultado.next())
        {
			he.setIdHerramienta(idHerramienta);
			he.setDescHerramienta(resultado.getString(1));
                        he.setCant(resultado.getInt(2));
        }
        resultado.close();
        closeCon();
        return he;
    }
      
      public String getIdHerramienta() throws Exception{
        int nuevoId=0;
        String retorno;
        ResultSet resultado = EjecutarQuery("SELECT MAX(idHerramienta) FROM herramientas") ;
           while (resultado.next())
        {
            if(resultado.getString(1) != null)
            { 
                nuevoId = Integer.parseInt(resultado.getString(1).substring(2,8))+1;
            }
            else
            {
                nuevoId = 1001;
            }
           
        }
          retorno= "HE00" + nuevoId ;
           
        resultado.close();
        closeCon();
        return retorno;

    }
       public int verificaDescHerr(String desc, String idHerr){
        int rta = EjecutarQueryInt("SELECT count(*) FROM herramientas where descHerramienta = '" + desc +"' and idHerramienta != '"+idHerr+"'");
        closeCon();
        return (rta);
    }
}