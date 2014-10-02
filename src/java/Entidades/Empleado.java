package Entidades;

import java.util.Date;


public class Empleado {
    private Integer idEmpleado;
    private String nombreEmp;
    private String apellidoEmp;
    private String direEmp;
    private String emailEmp;
    private String telEmp;
    private Date fechaNacEmp;

    public Integer getIdEmpleado() {
        return idEmpleado;
    }

    public String getNombreEmp() {
        return nombreEmp;
    }

    public String getApellidoEmp() {
        return apellidoEmp;
    }

    public String getDireEmp() {
        return direEmp;
    }

    public String getEmailEmp() {
        return emailEmp;
    }

    public String getTelEmp() {
        return telEmp;
    }

    public Date getFechaNacEmp() {
        return fechaNacEmp;
    }

    public void setIdEmpleado(Integer idEmpleado) {
        this.idEmpleado = idEmpleado;
    }

    public void setNombreEmp(String nombreEmp) {
        this.nombreEmp = nombreEmp;
    }

    public void setApellidoEmp(String apellidoEmp) {
        this.apellidoEmp = apellidoEmp;
    }

    public void setDireEmp(String direEmp) {
        this.direEmp = direEmp;
    }

    public void setEmailEmp(String emailEmp) {
        this.emailEmp = emailEmp;
    }

    public void setTelEmp(String telEmp) {
        this.telEmp = telEmp;
    }

    public void setFechaNacEmp(Date fechaNacEmp) {
        this.fechaNacEmp = fechaNacEmp;
    }
}
