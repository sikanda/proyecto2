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
               rta = EjecutarNonQuery("insert into clientes ( nomApeCli, direCli, telCli,emailCli)  VALUES ( '" + c.getNomApeCli()  + "' , '" + c.getDireCli() + "' , '" + c.getTelCli() + "' , '" + c.getEmailCli() +  "' )");
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
