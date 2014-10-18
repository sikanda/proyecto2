package Datos;

import Entidades.Proveedor;
import java.sql.ResultSet;
import java.util.*;


public class ProveedorDB extends AccesoDatos {

public ProveedorDB() throws Exception{}

	//Todo: agregar metodos custom, if necessary
     public boolean save(Proveedor u){ 
        boolean rta = false;
		rta = EjecutarNonQuery("insert into proveedores (razonSocial, direProv, emailProv, telProv)  VALUES ( '" + u.getRazonSocial()  + "' , '" + u.getDireProv() + "' , '" + u.getEmailProv() + "' , '" + u.getTelProv() +  "' )");
		if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }

  public boolean update(Proveedor u){
        boolean rta = false;
		rta = EjecutarNonQuery("UPDATE proveedores SET razonSocial = '" + u.getRazonSocial() + "', direProv = '" + u.getDireProv() + "', telProv = '" + u.getTelProv() + "', emailProv = '" + u.getEmailProv() + "' WHERE idProveedor = " + u.getIdProveedor());
                
         
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
  
   public boolean delete(int idP){
        boolean rta = false;
		rta = EjecutarNonQuery("delete from proveedores WHERE idProveedor = " + idP);
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
   
       public List getProveedores() throws Exception{
            List listaProv = new ArrayList();
            ResultSet resultado = EjecutarQuery("SELECT idProveedor, razonSocial, direProv, emailProv, telProv FROM proveedores");
            while (resultado.next()){
                Proveedor prov = new Proveedor();
                prov.setIdProveedor(resultado.getInt(1));
                prov.setRazonSocial(resultado.getString(2));
                prov.setDireProv(resultado.getString(3));
                prov.setEmailProv(resultado.getString(4));
                prov.setTelProv(resultado.getString(5));
            
                listaProv.add(prov);
            }
            closeCon();
            return listaProv;
	}
       
      public Proveedor getProveedor(int idProveedor) throws Exception
    {
        Proveedor prov = new Proveedor();
        ResultSet resultado = EjecutarQuery("SELECT idProveedor, razonSocial, direProv, emailProv, telProv  FROM proveedores WHERE idProveedor = " + idProveedor);

        while (resultado.next())
        {
            prov.setIdProveedor(resultado.getInt(1));
            prov.setRazonSocial(resultado.getString(2));
            prov.setDireProv(resultado.getString(3));
            prov.setEmailProv(resultado.getString(4));
            prov.setTelProv(resultado.getString(5));

        }
        resultado.close();
        closeCon();
        return prov;
    }
      
          public int getIdProveedor(){
        int rta = EjecutarQueryInt("SELECT MAX(idProveedor) FROM proveedores")+1;
        closeCon();
        return (rta);

    }
}