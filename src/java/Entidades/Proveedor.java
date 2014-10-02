package Entidades;

import Datos.ProveedorDB;

public class Proveedor { 
    private Integer idProveedor;
    private String razonSocial;
    private String direProv;
    private String emailProv;
    private String telProv;
 
    public Proveedor (){}
	
	public Proveedor(int id, String razonSoc, String direccion,
			String telefono, String mail) {
		super();
		this.idProveedor = id;
		this.razonSocial = razonSoc;
		this.direProv = direccion;
		this.telProv = telefono;
		this.emailProv = mail;
	}
        
        
    public Proveedor (String razonSoc,String dir,String mail,String tel) 
    {  
        boolean rta = true;
        try{
            ProveedorDB EDB = new ProveedorDB();
            idProveedor = EDB.getIdProveedor();
            }
        catch(Exception e)
            {rta = false;}
        if (rta)
        {
		this.razonSocial = razonSoc;
		this.direProv = dir;
		this.telProv = tel;
		this.emailProv = mail;
        }
     }

  
        //TODO: faltan todos los otros metodos
         public boolean update(){
        boolean rta = true;
        ProveedorDB UDB = null;
        try{
                UDB = new ProveedorDB();
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
        ProveedorDB UDB = null;
        try{
                UDB = new ProveedorDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                rta = UDB.save(this);
        }
        return rta;
    }
        
        public Integer getIdProveedor() {
        return idProveedor;
    }

    public void setIdProveedor(Integer idProveedor) {
        this.idProveedor = idProveedor;
    }

    public String getRazonSocial() {
        return razonSocial;
    }

    public void setRazonSocial(String razonSoc) {
        this.razonSocial = razonSoc;
    }

    public String getDireProv() {
        return direProv;
    }

    public void setDireProv(String direProv) {
        this.direProv = direProv;
    }

    public String getEmailProv() {
        return emailProv;
    }

    public void setEmailProv(String emailProv) {
        this.emailProv = emailProv;
    }

    public String getTelProv() {
        return telProv;
    }

    public void setTelProv(String telProv) {
        this.telProv = telProv;
    }
}
