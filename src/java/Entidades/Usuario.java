package Entidades;

import Datos.UsuarioDB;

public class Usuario { 
    private Integer idUsuario;
    private String nombreUsuario;
    private String pass;
 
    public Usuario (){}
	
	
    public Usuario( String nombreUsu, String pass) {
         boolean rta = true;
        try{
            UsuarioDB EDB = new UsuarioDB();
            this.idUsuario = EDB.getIdUsuario();
            }
        catch(Exception e)
            {rta = false;}
        if (rta)
        {
        this.nombreUsuario = nombreUsu;
        this.pass = pass;
         }
    }

    public Integer getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsu) {
        this.nombreUsuario = nombreUsu;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

 
  
         public boolean update(){
        boolean rta = true;
        UsuarioDB UDB = null;
        try{
                UDB = new UsuarioDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                rta = UDB.update(this);
        }
        return rta;
    }

     public boolean save(){
        boolean rta = true;
        UsuarioDB UDB = null;
        try{
                UDB = new UsuarioDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                rta = UDB.save(this);
        }
        return rta;
    }
 
     
}
