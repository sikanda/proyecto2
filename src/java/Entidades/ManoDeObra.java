package Entidades;
import Datos.ManoDeObraDB;

public class ManoDeObra {
    private String idManoDeObra;  
    private String descManoDeObra;   
    private String idUnidadMedida; 
    private String descUnidadMedida; 
    private float coefStdMO;
    private float cantPres;  
    private float precioMo;
    
    public ManoDeObra (){}
    
        public ManoDeObra (String desc, String um,Float prec) 
    {  
        boolean rta = true;
        try{
            ManoDeObraDB MDB = new ManoDeObraDB();
            this.idManoDeObra = MDB.getIdManoDeObra();
            }
        catch(Exception e)
            {rta = false;}
        if (rta)
        {
                this.descManoDeObra = desc;
                this.idUnidadMedida = um;
		this.precioMo = prec;
        }
     }

    public void setIdManoDeObra(String idManoDeObra) {
        this.idManoDeObra = idManoDeObra;
    }

    public void setDescManoDeObra(String descManoDeObra) {
        this.descManoDeObra = descManoDeObra;
    }

    public void setIdUnidadMedida(String idUnidadMedida) {
        this.idUnidadMedida = idUnidadMedida;
    }

    public void setCoefStdMO(float coefStdMO) {
        this.coefStdMO = coefStdMO;
    }

    public void setCantPres(float cantPres) {
        this.cantPres = cantPres;
    }

    public void setPrecioMo(float precioMo) {
        this.precioMo = precioMo;
    }
    
    public float getPrecioMo() {
        return precioMo;
    }   
  
    public String getIdManoDeObra() {
        return idManoDeObra;
    }

    public String getDescManoDeObra() {
        return descManoDeObra;
    }

    public String getIdUnidadMedida() {
        return idUnidadMedida;
    }

    public float getCoefStdMO() {
        return coefStdMO;
    }

    public float getCantPres() {
        return cantPres;
    }

    public String getDescUnidadMedida() {
        return descUnidadMedida;
    }

    public void setDescUnidadMedida(String descUnidadMedida) {
        this.descUnidadMedida = descUnidadMedida;
    }
    
        public boolean updateCantMoEnRubro(String idRubro, Float cant){
        boolean rta = true;
        ManoDeObraDB MDB = null;
        try{
                MDB = new ManoDeObraDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                 rta = MDB.updateCantMoEnRubro(this.idManoDeObra, idRubro, cant) ;
        }
        return rta;
    }
        
             public boolean update(){
        boolean rta = true;
          ManoDeObraDB MDB = null;
        try{
                MDB = new ManoDeObraDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                rta = MDB.update(this);
        }
        return rta;
    }

     public boolean save(){
        boolean rta = true;
        ManoDeObraDB MDB = null;
        try{
                MDB = new ManoDeObraDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                rta = MDB.save(this);
        }
        return rta;
    }
     
     
    	@Override
	public String toString() {
		return this.getDescManoDeObra();
	} 
}
