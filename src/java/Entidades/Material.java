package Entidades;
import Datos.MaterialDB;

public class Material {
    private String idMaterial;  
    private String descMaterial;   
    private String idUnidadMedida; 
    private float coefStdMat;
    private float cantPres;  
    private float precioMa;
    
    public Material (){}

     public Material (String desc, String um,Float prec) 
    {  
        boolean rta = true;
        try{
            MaterialDB MDB = new MaterialDB();
            this.idMaterial = MDB.getIdMaterial();
            }
        catch(Exception e)
            {rta = false;}
        if (rta)
        {
		this.idUnidadMedida = um;
                this.descMaterial = desc;
		this.precioMa = prec;
        }
     }
    public void setIdMaterial(String idMaterial) {
        this.idMaterial = idMaterial;
    }

    public void setDescMaterial(String descMaterial) {
        this.descMaterial = descMaterial;
    }

    public void setIdUnidadMedida(String idUnidadMedida) {
        this.idUnidadMedida = idUnidadMedida;
    }

    public void setCoefStdMat(float coefStdMat) {
        this.coefStdMat = coefStdMat;
    }

    public void setCantPres(float cantPres) {
        this.cantPres = cantPres;
    }
    
     public void setPrecioMa(float precioMa) {
        this.precioMa = precioMa;
    }
     
    public float getPrecioMa() {
        return precioMa;
    }

    public String getIdMaterial() {
        return idMaterial;
    }

    public String getDescMaterial() {
        return descMaterial;
    }

    public String getIdUnidadMedida() {
        return idUnidadMedida;
    }

    public float getCoefStdMat() {
        return coefStdMat;
    }

    public float getCantPres() {
        return cantPres;
    }

        public boolean updateCantMatEnRubro(String idRubro, Float cant){
        boolean rta = true;
        MaterialDB MDB = null;
        try{
                MDB = new MaterialDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                 rta = MDB.updateCantMatEnRubro(this.idMaterial, idRubro, cant) ;
        }
        return rta;
    }
    
        
        public boolean update(){
        boolean rta = true;
          MaterialDB MDB = null;
        try{
                MDB = new MaterialDB();
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
        MaterialDB MDB = null;
        try{
                MDB = new MaterialDB();
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
		return this.getDescMaterial();
	} 
}
