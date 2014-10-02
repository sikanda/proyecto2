
package Entidades;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import Datos.PresupuestoDB;

public class Presupuesto {
    
    private int idPresupuesto;
    private List<Rubro> rubros ;
    private Usuario usuario ;
    private Cliente cliente;
    private String observaciones;
    private Date fechaCreacion;
    
    
    public Presupuesto(){}
    //constructor: setea rubros vacio
      public Presupuesto (Usuario usr,String obs,Date fec, Cliente cli) 
    { 
        boolean rta = true;
        try{
            PresupuestoDB PDB = new PresupuestoDB();
            idPresupuesto = PDB.getIdPresupuesto();
            }
        catch(Exception e)
            {rta = false;}
        if (rta)
        {
            this.fechaCreacion = fec;
            this.observaciones = obs;
            this.usuario = usr;
            this.cliente = cli;
            this.rubros = new ArrayList();
        }
     }
    
     public void addRubroPres(Rubro rubro) //este rubro es un rubro hoja
    {
        this.rubros.add(rubro);
    }
     // <editor-fold defaultstate="collapsed" desc="class attributes">
   
   
    public int getIdPresupuesto() {
        return idPresupuesto;
    }

    public List<Rubro> getRubros() {
        return rubros;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setIdPresupuesto(int idPresupuesto) {
        this.idPresupuesto = idPresupuesto;
    }

    public void setRubros(List<Rubro> rubros) {
        this.rubros = rubros;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
    
   // </editor-fold>  
    
       public List devolverRubrosPresupuesto()
    {
        Rubro a;
        boolean flag;
        List lista = new ArrayList();
        for(Rubro r : rubros)
        {
         flag = true;   
         Rubro pad = r.getRubroPadre();   	 
         while ((pad.getIdRubro() != null)&&(flag))
	{
            if (enLista(pad,lista)) 
            {
                a= deLista(pad,lista);  
                a.addSubrubro(r);  
                flag = false;
            }
            else 
            {
                 pad.addSubrubro(r); 
            }
            r = pad; 
            pad =  pad.getRubroPadre(); 

        }
            if (flag)
            {
             lista.add(r);
            }
        }
         return lista;
    }
    	 

  
      public boolean save(){
        boolean rta = true;
        PresupuestoDB PDB = null;
        try{
                PDB = new PresupuestoDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                //rta = PDB.save(this) ;
                rta = PDB.saveALLPres(this) ;
        }
        return rta;
    }
      
        // determina si un objeto rubro esta en la lista
        // es recursiva para buscar en los subrubros de los rubros de la lista
      public boolean enLista(Rubro r, List<Rubro> lista)
      {
          boolean esta = false;
          for(int i=0; i<lista.size();i++)
          { 
            if (r.getIdRubro().equals(lista.get(i).getIdRubro()))
               {
                   esta = true;
                   break;
               }
            if ((!esta) && (!lista.get(i).getSubrubros().isEmpty())) 
                {
                    esta = enLista(r,lista.get(i).getSubrubros());
                }
          }
          return esta;
      }
          
         // devuelve el objeto rubro de la lista
        // es recursiva para buscar en los subrubros de los rubros de la lista
      public Rubro deLista(Rubro r, List<Rubro> lista)
      {
          Rubro este = new Rubro();
          for(int i=0; i<lista.size();i++)
          { 
            if (r.getIdRubro().equals(lista.get(i).getIdRubro()))
               {
                   este = lista.get(i) ;
                   break;
               }
            if (( este!= null ) && (!lista.get(i).getSubrubros().isEmpty())) //no esta y subr no esta vacio
                {
                    este = deLista(r,lista.get(i).getSubrubros());
                }
          }
          return este;
      }
 
}
