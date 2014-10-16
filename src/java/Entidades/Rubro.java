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
             RubroDB rDB = new RubroDB();
            if (!(listaMat.equals("vacio"))) //lista mat esta lleno
            {
                boolean flagFindDel = false;
                boolean flagFind;
                ArrayList<Material> matAlta = new ArrayList<Material>();
                ArrayList<Material> matBaja = new ArrayList<Material>();
              //parts es array de idMat:cantStd 
                String[] parts = listaMat.split(";");
                for (int i = 0; i < parts.length; i++) {
                    //parts2[0] es id mat,  parts2[1] es cant
                    String[] parts2 = parts[i].split(":");
                    flagFind = false;
                    for (int j = 0; j < materiales.size(); j++) {
                        //busco el mat en la lista de mats del rubro
                        if ((parts2[0]).equals(materiales.get(j).getIdMaterial())) {
                            flagFind = true;
                            int k = Float.compare(Float.parseFloat(parts2[1]), (materiales.get(j).getCoefStdMat()));
                            if (k != 0) //solo actualizar bd si la cant se cambio
                            {
                            materiales.get(j).setCoefStdMat(Float.parseFloat(parts2[1]));
                            materiales.get(j).updateCantMatEnRubro(this.idRubro, Float.parseFloat(parts2[1]));
 //                               System.out.println("actualizo mat " + parts2[0] + " a " + parts2[1]);
                            }
                        }
                    }
                    if (!flagFind) //no lo encontro y hay q darlo de alta
                    {
                        Material nuevoMaterial = new Material();
                        nuevoMaterial.setIdMaterial(parts2[0]);
                        nuevoMaterial.setCoefStdMat(Float.parseFloat(parts2[1]));
                        matAlta.add(nuevoMaterial);
//                       //agregarlo a la lista de mats del rub?
 //                       System.out.println("agrego a mats para dar de alta " + parts2[0]);
                    }
                }
                if (!matAlta.isEmpty())//si hay por lo menos un mat nuevo hay q darlo de alta en el rub
                {
                     rDB.saveMatEnRub(this.idRubro, matAlta);
                   // System.out.println("doy de alta mats " + matAlta);
                }
                //inicio borrado de materiales
                for (int j = 0; j < materiales.size(); j++) {
                    flagFindDel = false;
                    for (int i = 0; i < parts.length; i++) {
                        //parts2[0] es id mat,  parts2[1] es cant
                        String[] parts2 = parts[i].split(":");
                        if (materiales.get(j).getIdMaterial().equals(parts2[0])) {
                            flagFindDel = true;
                        }
                    }
                    if (!flagFindDel)//no lo encontro y hay q agregarlo a la lista para borrar
                    {
                        matBaja.add(materiales.get(j));
                    }
                }
                if (!matBaja.isEmpty()) //no lo encontro y hay q borrarlo
                {
                //borro material
                     rDB.deleteMatEnRub(this.idRubro, matBaja);
                 //   System.out.println("borro esta lista d material " + matBaja);
                }
            } else //listaMat esta vacio
            {
                if (!(materiales.isEmpty())) //array mat esta lleno, pero listamat esta vacio, los borro
                {
                    //System.out.println("borro todos los materiales ");
                     rDB.deleteAllMatEnRub(this.idRubro);
                    //quitar la lista de mats del rub?
                }
            }

        } catch (Exception e) {
        }
    }

    public void modificarListaMo(String listaMo) {

        //listaMo viene en formato idMat:cantStd  
        try {
            RubroDB rDB = new RubroDB();
            if (!(listaMo.equals("vacio"))) //lista mo esta lleno
            {
                boolean flagFindDel = false;
                boolean flagFind;
                ArrayList<ManoDeObra> moAlta = new ArrayList<ManoDeObra>();
                ArrayList<ManoDeObra> moBaja = new ArrayList<ManoDeObra>();   
                //parts es array de idMo:cantStd 
                String[] parts = listaMo.split(";");
                for (int i = 0; i < parts.length; i++) {
                    //parts2[0] es id mo,  parts2[1] es cant
                    String[] parts2 = parts[i].split(":");
                    flagFind = false;
                    for (int j = 0; j < manoDeObra.size(); j++) {
                        //busco el mo en la lista de mats del rubro
                        if ((parts2[0]).equals(manoDeObra.get(j).getIdManoDeObra())) {
                            flagFind = true;
                            int k = Float.compare(Float.parseFloat(parts2[1]), (manoDeObra.get(j).getCoefStdMO()));
                            if (k != 0) //solo actualizar bd si la cant se cambio
                            {
                            manoDeObra.get(j).setCoefStdMO(Float.parseFloat(parts2[1]));
                            manoDeObra.get(j).updateCantMoEnRubro(this.idRubro, Float.parseFloat(parts2[1]));
                          //      System.out.println("actualizo mo " + parts2[1]);
                            }
                        }
                    }
                    if (!flagFind) //no lo encontro y hay q darlo de alta
                    {
                        ManoDeObra nuevoManoDeObra = new ManoDeObra();
                        nuevoManoDeObra.setIdManoDeObra(parts2[0]);
                        nuevoManoDeObra.setCoefStdMO(Float.parseFloat(parts2[1]));
                        moAlta.add(nuevoManoDeObra);
//                       //agregarlo a la lista de mo del rub?
                       // System.out.println("agrego a mo para dar de alta " + parts2[0]);
                    }
                }
                if (!moAlta.isEmpty())//si hay por lo menos un mo nuevo hay q darlo de alta en el rub
                {
                    rDB.saveMoEnRub(this.idRubro, moAlta);
                    //System.out.println("doy de alta mo " + moAlta);
                }
                //inicio borrado de manoDeObra
                for (int j = 0; j < manoDeObra.size(); j++) {
                    flagFindDel = false;
                    for (int i = 0; i < parts.length; i++) {
                        //parts2[0] es id mat,  parts2[1] es cant
                        String[] parts2 = parts[i].split(":");
                        if (manoDeObra.get(j).getIdManoDeObra().equals(parts2[0])) {
                            flagFindDel = true;
                        }
                    }
                    if (!flagFindDel)//no lo encontro y hay q agregarlo a la lista para borrar
                    {
                        moBaja.add(manoDeObra.get(j));
                    }
                }
                if (!moBaja.isEmpty()) {
                    //borro mo
                  rDB.deleteMoEnRub(this.idRubro, moBaja);
                   // System.out.println("borro esta lista mo " + moBaja);
                }
            } else //listaMat esta vacio
            {
                if (!(manoDeObra.isEmpty())) //array mo esta lleno, pero listamo esta vacio, los borro
                {
                  //  System.out.println("borro todos los manoDeObra ");
                     rDB.deleteAllMoEnRub(this.idRubro);
                    //quitar la lista de mo del rub?
                }
            }
        } catch (Exception e) {
        }
    }
  
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
         
   /*
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
                rta = RDB.save(this); 
        }
        return rta;
    }
 */
    
    
    		@Override
	public String toString() {
		return this.getDescRubro();
	}
     
}
