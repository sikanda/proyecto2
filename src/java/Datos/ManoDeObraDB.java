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
		rta = EjecutarNonQuery("UPDATE manodeobra SET descManoDeObra = '" + m.getDescManoDeObra() + "', idUnidadMedida = '" + m.getIdUnidadMedida() + "', precioMo = '" + m.getPrecioMo() + "' WHERE idManoDeObra = " + m.getIdManoDeObra());
         
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
  
   public boolean delete(int idM){
        boolean rta = false;
		rta = EjecutarNonQuery("delete from manodeobra WHERE idManoDeObra = " + idM);
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
   
       public List getManoDeObraes() throws Exception{
            List listaMat = new ArrayList();
            ResultSet resultado = EjecutarQuery("SELECT  idManoDeObra, descManoDeObra, idUnidadMedida, precioMo FROM manodeobra");
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
       
      public ManoDeObra getManoDeObra(int idManoDeObra) throws Exception
    {
        ManoDeObra mat = new ManoDeObra();
        ResultSet resultado = EjecutarQuery("SELECT  idManoDeObra, descManoDeObra, idUnidadMedida, precioMo FROM manodeobra WHERE idManoDeObra = " + idManoDeObra);

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
      
          public int getIdManoDeObra(){
        int rta = EjecutarQueryInt("SELECT MAX(idManoDeObra) FROM manodeobra")+1;
        closeCon();
        return (rta);

    }
}