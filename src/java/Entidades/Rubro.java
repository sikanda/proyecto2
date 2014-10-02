package Entidades;

import Datos.RubroDB;
import java.util.ArrayList;
import java.util.List;

public class Rubro { 
    private String idRubro;
    private String descRubro;
    private String idUnidadMedida;
    private List<Rubro> subrubros ;
    private List<Material> materiales ;
    private List<ManoDeObra> manoDeObra ;
    private float cantPresRub;
 
    public Rubro (){}
	
	
    public Rubro(String idRubro, String descRubro) {
        this.idRubro = idRubro;
        this.descRubro = descRubro;
        this.subrubros = new ArrayList();
    }

       // <editor-fold defaultstate="collapsed" desc="class attributes">
   
    public String getIdRubro() {
        return idRubro;
    }

    public void setIdRubro(String idRubro) {
        this.idRubro = idRubro;
    }

    public String getDescRubro() {
        return descRubro;
    }
    
    public void setDescRubro(String descRubro) {
        this.descRubro = descRubro;
    }
    
    public String getIdUnidadMedida() {
        return idUnidadMedida;
    }
    
    public float getCantPresRub() {
        return cantPresRub;
    }

    public void setCantPresRub(float cantPresRub) {
        this.cantPresRub = cantPresRub;
    }
    
    public void setIdUnidadMedida(String idUnidadMedida) {
        this.idUnidadMedida = idUnidadMedida;
    }
    
    public List getSubrubros() {
        return subrubros;
    }

    public void setSubrubros (List subrubros) {
        this.subrubros = subrubros;
    }
    
        public List getMateriales() {
        return materiales;
    }

    public void setMateriales (List materiales) {
        this.materiales = materiales;
    }
    
        public List getManoDeObra() {
        return manoDeObra;
    }

    public void setManoDeObra (List manoDeObra) {
        this.manoDeObra = manoDeObra;
    }
    // </editor-fold>  
    
    public void addSubrubro(Rubro rubro)
    {
        this.subrubros.add(rubro);
    }
 
     public void addMaterial(Material m) //agregar material al rubro
    {
        this.materiales.add(m);
    }
       
    public void addManoDeObra(ManoDeObra mo) //agregar mo al rubro
    {
        this.manoDeObra.add(mo);
    }
     
     public void deleteManoDeObra(ManoDeObra mo) //sacar mo del rubro
    {
        this.manoDeObra.remove(mo) ;
    }
     
       public void deleteMaterial(Material m) //sacar ma del rubro
    {
        this.materiales.remove(m) ;
    }
          
        public Rubro getRubroPadre(){ 
            Rubro rPadre = null;
            try{
                    RubroDB rDB = new RubroDB();
                    rPadre = rDB.getRubroPadre(idRubro); //TODO: revisar
            }
            catch(Exception e){}
            return rPadre;
	}
        
        public Rubro getRubro(String idR){ 
		Rubro rub = null;
		try{
			RubroDB rDB = new RubroDB();
			rub = rDB.getRubro(idR); //TODO: revisar
		}
		catch(Exception e){}
                return rub;
	}
    
  /*
        //TODO: faltan todos los otros metodos
         public boolean update(){
        boolean rta = true;
        RubroDB RDB = null;
        try{
                RDB = new RubroDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                rta = RDB.update(this);
        }
        return rta;
    }
   */
     public boolean save(){
        boolean rta = true;
        RubroDB RDB = null;
        try{
                RDB = new RubroDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                rta = RDB.saveALLRub(this); //inserta en rubro y tablas derivadas
        }
        return rta;
    }
 
    
    
    		@Override
	public String toString() {
		return this.getDescRubro();
	}
     
}
