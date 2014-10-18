package Entidades;

import java.util.Date;
import Datos.EmpleadoDB;


public class Empleado {
    private Integer idEmpleado;
    private String nombreEmp;
    private String apellidoEmp;
    private String direEmp;
    private String emailEmp;
    private String telEmp;
    private Date fechaNacEmp;
    
        public Empleado (){}
        public Empleado (String apellido, String nombre,String dir,String mail,String tel) 
    {  
        boolean rta = true;
        try{
            EmpleadoDB EDB = new EmpleadoDB();
            idEmpleado = EDB.getIdEmpleado();
            }
        catch(Exception e)
            {rta = false;}
        if (rta)
        {
		this.apellidoEmp = apellido;
                this.nombreEmp = nombre;
		this.direEmp = dir;
		this.telEmp = tel;
		this.emailEmp = mail;
        }
     }
    
    
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
    
       public boolean update(){
        boolean rta = true;
        EmpleadoDB EDB = null;
        try{
                EDB = new EmpleadoDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                rta = EDB.update(this);
        }
        return rta;
    }

     public boolean save(){
        boolean rta = true;
        EmpleadoDB EDB = null;
        try{
                EDB = new EmpleadoDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                rta = EDB.save(this);
        }
        return rta;
    }
       
}
