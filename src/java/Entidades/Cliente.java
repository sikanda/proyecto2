package Entidades;

import java.util.Date;

public class Cliente {
    
    private Integer idCliente;
    private String nombreCli;
    private String apellidoCli;
    private String direCli;
    private String emailCli;
    private String telCli;
    private Date fechaNacCli;

     public Cliente (){}
    
    public void setIdCliente(Integer idCliente) {
        this.idCliente = idCliente;
    }

    public void setNombreCli(String nombreCli) {
        this.nombreCli = nombreCli;
    }

    public void setApellidoCli(String apellidoCli) {
        this.apellidoCli = apellidoCli;
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

    public void setFechaNacCli(Date fechaNacCli) {
        this.fechaNacCli = fechaNacCli;
    }
 

    public Integer getIdCliente() {
        return idCliente;
    }

    public String getNombreCli() {
        return nombreCli;
    }

    public String getApellidoCli() {
        return apellidoCli;
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

    public Date getFechaNacCli() {
        return fechaNacCli;
    }

}
