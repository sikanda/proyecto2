package Entidades;

import Datos.HerramientaDB;

public class Herramienta {
    
    private String idHerramienta;
    private String descHerramienta; 
    private int cant; 
    
    public Herramienta (){}
    
    	public Herramienta( String desc, int cant ) {
        super();
         try{
             String he;
            HerramientaDB hDB = new HerramientaDB();
            he = hDB.getIdHerramienta();  
            
            this.idHerramienta = he;
            this.descHerramienta = desc;
            this.cant = cant;
            }
            catch(Exception e){}
        }
        
        
    public void setIdHerramienta(String idHerramienta) {
        this.idHerramienta = idHerramienta;
    }

    public void setDescHerramienta(String descHerramienta) {
        this.descHerramienta = descHerramienta;
    }

    public String getIdHerramienta() {
        return idHerramienta;
    }

    public String getDescHerramienta() {
        return descHerramienta;
    }
       
    public int getCant() {
        return cant;
    }

    public void setCant(int cant) {
        this.cant = cant;
    }

        public boolean update(){
        boolean rta = true;
        HerramientaDB hDB = null;
        try{
                hDB = new HerramientaDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                rta = hDB.update(this);
        }
        return rta;
    }

     public boolean save(){
        boolean rta = true;
        HerramientaDB hDB = null;
        try{
                hDB = new HerramientaDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                rta = hDB.save(this);
        }
        return rta;
    }
}
