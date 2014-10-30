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
        	rta = EjecutarNonQuery("insert into manodeobra (idManoDeObra, descManoDeObra, idUnidadMedida, precioMo)  VALUES ( '" + m.getIdManoDeObra()  + "' , '" + m.getDescManoDeObra()  + "' , '" + m.getIdUnidadMedida() + "' , '" + m.getPrecioMo() +  "' )");
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
         if (validarCantMo(idM)==0){
		rta = EjecutarNonQuery("delete from manodeobra WHERE idManoDeObra = '" + idM+"'");
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
   
       public List getManoDeObra() throws Exception{  //lista mano de obra
            List listaMo = new ArrayList();
            //ResultSet resultado = EjecutarQuery("SELECT  idManoDeObra, descManoDeObra, idUnidadMedida, precioMo FROM manodeobra order by descManoDeObra");
           ResultSet resultado = EjecutarQuery("SELECT  idManoDeObra, descManoDeObra, m.idUnidadMedida, descUnidadMedida, precioMo FROM manodeobra m inner join unidadesmedida u on u.idUnidadMedida = m.idUnidadMedida order by descManoDeObra");
            while (resultado.next()){
                ManoDeObra mo = new ManoDeObra();
                mo.setIdManoDeObra(resultado.getString(1));
                mo.setDescManoDeObra(resultado.getString(2));
                mo.setIdUnidadMedida(resultado.getString(3));
                mo.setDescUnidadMedida(resultado.getString(4));
                mo.setPrecioMo(resultado.getFloat(5));
            
                listaMo.add(mo);
            }
            closeCon();
            return listaMo;
	}
       
      public ManoDeObra getManoDeObra(String idManoDeObra) throws Exception
    {
        ManoDeObra mo = new ManoDeObra();
        ResultSet resultado = EjecutarQuery("SELECT  idManoDeObra, descManoDeObra, idUnidadMedida, precioMo FROM manodeobra WHERE idManoDeObra = '" + idManoDeObra +"'");

        while (resultado.next())
        {
                    mo.setIdManoDeObra(resultado.getString(1));
                    mo.setDescManoDeObra(resultado.getString(2));
                    mo.setIdUnidadMedida(resultado.getString(3));
                    mo.setPrecioMo(resultado.getFloat(4));
        }
        resultado.close();
        return mo;
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
                nuevoId = 1; 
            }
           
        }
          retorno= "MO" + String.format("%04d",nuevoId) ;
           
        resultado.close();
        closeCon();
        return retorno;

    }
    public int validarCantMo(String idMo){
    
    int rta = EjecutarQueryInt("Select count(*) from manodeobrarubro where idManoDeObra = '" + idMo+"'" );
   
    return (rta);
       } 
}