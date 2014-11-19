
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
     
        public void clearRubrosPres() //borro lista rubros-pres. usado por editar pres
    {
        this.rubros.clear();
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
      
      //metodo q recibe la nueva lista rubros del presu y modifica la actual
      public void resolverMuestraRubros( List<Rubro> nuevaLista)
      {
       // System.out.println("estos son mis rubros" + this.rubros);
        boolean flag, flagFind;
        List<Rubro>  toAdd = new  ArrayList<Rubro>();
        List<Rubro>  toRemove = new  ArrayList<Rubro>();
        for(int i=0; i< this.rubros.size();i++)
        {
            flag = true;
            for(int k=0; k< nuevaLista.size();k++)
            { 
                if (this.rubros.get(i).getIdRubro().equals(nuevaLista.get(k).getIdRubro())) 
                {
                    flag= false;
                }
            }
            if(flag)
            {
                 toRemove.add(this.rubros.get(i));
            }
        }
        for( Rubro rub: toRemove)
        {
            this.rubros.remove(rub);
        }
       // System.out.println("to remove" + toRemove);
        
          for (int m = 0; m < nuevaLista.size(); m++) 
          {
              flagFind = false;
              for (int j = 0; j < this.rubros.size(); j++) 
              {
                  if ((nuevaLista.get(m).getIdRubro().equals(this.rubros.get(j).getIdRubro()))) {
                      flagFind = true;
                  }
              }
            if(!(flagFind))
            {
                 toAdd.add(nuevaLista.get(m));
                //  System.out.println("agrego este " + nuevaLista.get(m));
            }
          }
         
          for( Rubro rub: toAdd)
        {
            this.rubros.add(rub);
        }
         // System.out.println("to add" + toAdd);
        //  System.out.println( this.rubros);
      }
      
       public boolean update(){
        boolean rta = true;
        PresupuestoDB PDB = null;
        try{
                PDB = new PresupuestoDB();
        }
        catch (Exception e){
            rta = false;
        }
        if(rta){
                rta = PDB.update(this) ;
        }
        return rta;
    }
       
        public boolean preparePrint(){
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
                rta = PDB.loadPresuPrint(this) ; 
        }
        return rta;
    }
}
