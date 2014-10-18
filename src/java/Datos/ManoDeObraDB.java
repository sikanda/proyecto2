package Datos;

import Entidades.ManoDeObra;
import java.sql.ResultSet;
import java.util.*;


public class ManoDeObraDB extends AccesoDatos {

public ManoDeObraDB() throws Exception{}

	//Todo: agregar metodos custom, if necessary
     public boolean save(ManoDeObra m){ 
        boolean rta = false;
		//ver si afecta en algo los '' de los float
        	rta = EjecutarNonQuery("insert into manodeobra (descManoDeObra, idUnidadMedida, precioMo)  VALUES ( '" + m.getDescManoDeObra()  + "' , '" + m.getIdUnidadMedida() + "' , '" + m.getPrecioMo() +  "' )");
                if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }

  public boolean update(ManoDeObra m){
        boolean rta = false;
		rta = EjecutarNonQuery("UPDATE manodeobra SET descManoDeObra = '" + m.getDescManoDeObra() + "', idUnidadMedida = '" + m.getIdUnidadMedida() + "', precioMo = '" + m.getPrecioMo() + "' WHERE idManoDeObra = '" + m.getIdManoDeObra()+"'");
         
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
		rta = EjecutarNonQuery("delete from manodeobra WHERE idManoDeObra = '" + idM+"'");
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
   
       public List getManoDeObra() throws Exception{
            List listaMat = new ArrayList();
            ResultSet resultado = EjecutarQuery("SELECT  idManoDeObra, descManoDeObra, idUnidadMedida, precioMo FROM manodeobra order by descManoDeObra");
            while (resultado.next()){
                ManoDeObra mat = new ManoDeObra();
                mat.setIdManoDeObra(resultado.getString(1));
                mat.setDescManoDeObra(resultado.getString(2));
                mat.setIdUnidadMedida(resultado.getString(3));
                mat.setPrecioMo(resultado.getFloat(4));
            
                listaMat.add(mat);
            }
            closeCon();
            return listaMat;
	}
       
      public ManoDeObra getManoDeObra(String idManoDeObra) throws Exception
    {
        ManoDeObra mat = new ManoDeObra();
        ResultSet resultado = EjecutarQuery("SELECT  idManoDeObra, descManoDeObra, idUnidadMedida, precioMo FROM manodeobra WHERE idManoDeObra = '" + idManoDeObra +"'");

        while (resultado.next())
        {
			mat.setIdManoDeObra(resultado.getString(1));
			mat.setDescManoDeObra(resultado.getString(2));
			mat.setIdUnidadMedida(resultado.getString(3));
			mat.setPrecioMo(resultado.getFloat(4));
        }
        resultado.close();
        return mat;
    }
      
      public boolean updateCantMoEnRubro(String idMo, String idRub, Float cant)
     {
         boolean rta = false;
		rta = EjecutarNonQuery("UPDATE manodeobrarubro SET  coefStdMo = '" + cant + "' WHERE idManoDeObra = '" + idMo + "' and idRubro = '" + idRub + "'");
         
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;

    }
      
       public String getIdManoDeObra() throws Exception{
        int nuevoId=0;
        String retorno;
        ResultSet resultado = EjecutarQuery("SELECT MAX(idManoDeObra) FROM manodeobra") ;
           while (resultado.next())
        {
            if(resultado.getString(1) != null)
            { 
                nuevoId = Integer.parseInt(resultado.getString(1).substring(2,6))+1;
            }
            else
            {
                nuevoId = 0001; //si no respeta los ceros mandar 1000
            }
           
        }
          retorno= "MO" + nuevoId ;
           
        resultado.close();
        closeCon();
        return retorno;

    }
      
}