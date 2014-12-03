package Datos;

import Entidades.Cliente;
import java.sql.ResultSet;
import java.util.*;


public class ClienteDB extends AccesoDatos {

public ClienteDB() throws Exception{}


    //Ubicado aqui pq se da de alta con pres
    public int getIdCliente(){
    int rta = EjecutarQueryInt("SELECT MAX(idCliente) FROM clientes")+1;
    closeCon();
    return (rta);
       } 
        
    public boolean save(Cliente c){ 
       boolean rta = false;
       String direEsc = c.getDireCli().replace("'", "\\'");
       String nomEsc =  c.getNomApeCli().replace("'", "\\'");
               rta = EjecutarNonQuery("insert into clientes ( idCliente, nomApeCli, direCli, telCli,emailCli)  VALUES ( "  + c.getIdCliente() + ", '"+ nomEsc  + "' , '" + direEsc + "' , '" + c.getTelCli() + "' , '" + c.getEmailCli() +  "' )");
               if(rta){
           rta = commit();
       }
       if(!rta){
           rollback();
       }
               closeCon();
       return rta;
   }

      public boolean update(Cliente c){ 
       boolean rta = false;
       String direEsc = c.getDireCli().replace("'", "\\'");
       String nomEsc =  c.getNomApeCli().replace("'", "\\'");
               rta = EjecutarNonQuery("update clientes set nomApeCli = '" +nomEsc+ "', direCli = '"+direEsc+ "', telCli = '"+c.getTelCli()+"'   WHERE idCliente = "  + c.getIdCliente() );
               if(rta){
           rta = commit();
       }
       if(!rta){
           rollback();
       }
               closeCon();
       return rta;
   }
}
