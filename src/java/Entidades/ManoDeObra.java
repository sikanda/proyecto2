package Entidades;
import Datos.ManoDeObraDB;

public class ManoDeObra {
    private String idManoDeObra;  
    private String descManoDeObra;   
    private String idUnidadMedida; 
    private float coefStdMO;
    private float cantPres;  
    private float precioMo;
    
    public ManoDeObra (){}

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
    	@Override
	public String toString() {
		return this.getDescManoDeObra();
	} 
}
