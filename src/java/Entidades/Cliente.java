package Entidades;

import java.util.Date;
import Datos.ClienteDB;

public class Cliente {
    
    private Integer idCliente;
    private String nomApeCli;
    private String direCli;
    private String emailCli;
    private String telCli;

     public Cliente (){}
    
    public void setIdCliente(Integer idCliente) {
        this.idCliente = idCliente;
    }

    public void setNomApeCli(String nombreCli) {
        this.nomApeCli = nombreCli;
    }

    public void setDireCli(String direCli) {
        this.direCli = direCli;
    }

    public void setEmailCli(String emailCli) {
        this.emailCli = emailCli;
    }

    public void setTelCli(String telCli) {
        this.telCli = telCli;
    }

    public Integer getIdCliente() {
        return idCliente;
    }

    public String getNomApeCli() {
        return nomApeCli;
    }

    public String getDireCli() {
        return direCli;
    }

    public String getEmailCli() {
        return emailCli;
    }

    public String getTelCli() {
        return telCli;
    }

    
         public boolean save(){
        boolean rta = true;
        ClienteDB CDB = null;
        try{
                CDB = new ClienteDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                rta = CDB.save(this); 
        }
        return rta;
    }
 }
