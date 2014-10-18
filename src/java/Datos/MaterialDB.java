package Datos;

import Entidades.Material;
import Entidades.UnidadMedida;
import java.sql.ResultSet;
import java.util.*;


public class MaterialDB extends AccesoDatos {

public MaterialDB() throws Exception{}

	//Todo: agregar metodos custom, if necessary
     public boolean save(Material m){ 
        boolean rta = false;
		//ver si afecta en algo los '' de los float
        	rta = EjecutarNonQuery("insert into materiales (descMaterial, idUnidadMedida, precioMa)  VALUES ( '" + m.getDescMaterial()  + "' , '" + m.getIdUnidadMedida() + "' , '" + m.getPrecioMa() +  "' )");
                if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }

  public boolean update(Material m){
        boolean rta = false;
		rta = EjecutarNonQuery("UPDATE materiales SET descMaterial = '" + m.getDescMaterial() + "', idUnidadMedida = '" + m.getIdUnidadMedida() + "', precioMa = '" + m.getPrecioMa() + "' WHERE idMaterial = " + m.getIdMaterial());
         
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
  
   public boolean delete(String idM){
        boolean rta = false;
		rta = EjecutarNonQuery("delete from materiales WHERE idMaterial = '" + idM + "'");
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
   
       public List getMateriales() throws Exception{
            List listaMat = new ArrayList();
            ResultSet resultado = EjecutarQuery("SELECT  idMaterial, descMaterial, idUnidadMedida, precioMa FROM materiales order by descMaterial");
            while (resultado.next()){
                Material mat = new Material();
                mat.setIdMaterial(resultado.getString(1));
                mat.setDescMaterial(resultado.getString(2));
                mat.setIdUnidadMedida(resultado.getString(3));
                mat.setPrecioMa(resultado.getFloat(4));
            
                listaMat.add(mat);
            }
            closeCon();
            return listaMat;
	}
       
      public Material getMaterial(String idMaterial) throws Exception
    {
        Material mat = new Material();
        ResultSet resultado = EjecutarQuery("SELECT  idMaterial, descMaterial, idUnidadMedida, precioMa FROM materiales WHERE idMaterial = '" + idMaterial + "'");

        while (resultado.next())
        {
			mat.setIdMaterial(resultado.getString(1));
			mat.setDescMaterial(resultado.getString(2));
			mat.setIdUnidadMedida(resultado.getString(3));
			mat.setPrecioMa(resultado.getFloat(4));
        }
        resultado.close();
        return mat;
    }
      
          public boolean updateCantMatEnRubro(String idMat, String idRub, Float cant)
     {
         boolean rta = false;
		rta = EjecutarNonQuery("UPDATE materialesrubro SET  coefStdMat = '" + cant + "' WHERE idMaterial = '" + idMat + "' and idRubro = '" + idRub + "'");
         
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;

    } 
          
        public String getIdMaterial() throws Exception{
        int nuevoId=0;
        String retorno;
        ResultSet resultado = EjecutarQuery("SELECT MAX(idMaterial) FROM materiales") ;
           while (resultado.next())
        {
            if(resultado.getString(1) != null)
            { 
                nuevoId = Integer.parseInt(resultado.getString(1).substring(5,8))+1;
            }
            else
            {
                nuevoId = 551;
            }
           
        }
          retorno= "MA001" + nuevoId ;
           
        resultado.close();
        closeCon();
        return retorno;

    }
}