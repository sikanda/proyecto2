package Entidades;

import Datos.RubroDB;
import java.util.ArrayList;
import java.util.Iterator;
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
	
	
    public Rubro(String idRubro) {
        this.idRubro = idRubro;
            Rubro rub = null;
            try{
                    RubroDB rDB = new RubroDB();
                    rub = rDB.getRubro(idRubro); //TODO: revisar
            }
            catch(Exception e){}
             this.descRubro = rub.getDescRubro();
             this.idUnidadMedida = rub.getIdUnidadMedida();
             this.manoDeObra = rub.getManoDeObra();
             this.materiales = rub.getMateriales();
             this.subrubros = rub.getSubrubros();
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
        
        
    public void modificarListaMat(String listaMat) {

        //listaMat viene en formato idMat:cantStd  
        try {
            boolean flagHayMat=false;
            boolean flagFind;
            ArrayList<Material> matAlta = new ArrayList<Material>();
            RubroDB rDB = new RubroDB();
            //parts es array de idMat:cantStd 
            String[] parts = listaMat.split(";");
            for (int i = 0; i < parts.length; i++) {
                //parts2[0] es id mat,  parts2[1] es cant
                String[] parts2 = parts[i].split(":");
                flagFind=false;
                flagHayMat=false;
                for (int j = 0; j < materiales.size(); j++) 
                {
                    //busco el mat en la lista de mats del rubro
                    if (parts2[0].equals(materiales.get(j).getIdMaterial())) 
                    {
                        flagFind = true;
                        int k=  Float.compare(Float.parseFloat(parts2[1]),(materiales.get(j).getCoefStdMat()));
                        if (k!=0) //no quiero actualizar bd si la cant no se cambio
                        { 
                            materiales.get(j).setCoefStdMat(Float.parseFloat(parts2[1]));
                            materiales.get(j).updateCantMatEnRubro(this.idRubro, Float.parseFloat(parts2[1]));
                        }
                    }
                }    
                    if (!flagFind) //no lo encontro y hay q darlo de alta
                    {
                       Material nuevoMaterial = new Material();
                       nuevoMaterial.setIdMaterial(parts2[0]);
                       nuevoMaterial.setCoefStdMat(Float.parseFloat(parts2[1]));
                       matAlta.add(nuevoMaterial);
                       flagHayMat=true;
                       //agregarlo a la lista de mats del rub?
                   }
             }
            if(flagHayMat)//si hay por lo menos un mat nuevo hay q darlo de alta en el rub
            {
                 rDB.saveMatEnRub(this.idRubro, matAlta);
            }
        } catch (Exception e) {}
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
