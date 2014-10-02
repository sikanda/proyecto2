package Entidades;

public class Material {
    private String idMaterial;  
    private String descMaterial;   
    private String idUnidadMedida; 
    private float coefStdMat;
    private float cantPres;  
    private float precioMa;
    
    public Material (){}

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

    	@Override
	public String toString() {
		return this.getDescMaterial();
	} 
}
