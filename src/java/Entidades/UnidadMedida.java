
package Entidades;
import Datos.UnidadMedidaDB;

public class UnidadMedida {
    private String idUnidadMedida;
    private String descUnidadMedida;

    public UnidadMedida(){}

    public UnidadMedida( String um,String desc) {
      this.idUnidadMedida = um;
      this.descUnidadMedida = desc;
       
    }

    public String getIdUnidadMedida() {
        return idUnidadMedida;
    }

    public String getDescUnidadMedida() {
        return descUnidadMedida;
    }

    public void setIdUnidadMedida(String idUnidadMedida) {
        this.idUnidadMedida = idUnidadMedida;
    }

    public void setDescUnidadMedida(String descUnidadMedida) {
        this.descUnidadMedida = descUnidadMedida;
    }
    

        public boolean update(){
        boolean rta = true;
        UnidadMedidaDB UDB = null;
        try{
                UDB = new UnidadMedidaDB();
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
        UnidadMedidaDB UDB = null;
        try{
                UDB = new UnidadMedidaDB();
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
