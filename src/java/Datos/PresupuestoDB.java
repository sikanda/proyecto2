package Datos;
import Entidades.Cliente;
import Entidades.Presupuesto;
import Entidades.Rubro;
import Entidades.ManoDeObra;
import Entidades.Material;
import Entidades.Usuario;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class PresupuestoDB extends AccesoDatos {
    
    
    public PresupuestoDB() throws Exception{}
    
    public int getIdPresupuesto(){
        int rta = EjecutarQueryInt("SELECT MAX(idPresupuesto) FROM presupuestos")+1;
        closeCon();
        return (rta);
           }
       
    public boolean saveALLPres(Presupuesto p){ 
        boolean rta = false;
        boolean rta1,rta2,rta3,rta4 ;
        boolean flag = true;
       // Rubro r = new Rubro();
       java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
       String fechaCreac = sdf.format(p.getFechaCreacion());
        rta1 = EjecutarNonQuery("insert into presupuestos (observaciones, idUsuario, idCliente, fechaCreacion)  VALUES ( '" + p.getObservaciones()  + "' , " + p.getUsuario().getIdUsuario() + " , " + p.getCliente().getIdCliente()  + ", '" + fechaCreac +   "' )");
        
        int idPres = EjecutarQueryInt("SELECT MAX(idPresupuesto) FROM presupuestos");
        
           Iterator itRub = p.getRubros().iterator();
           while(itRub.hasNext())
           {
                Rubro  r = (Rubro)itRub.next();
                //System.out.println( r.getIdRubro()); 
                 flag = true;
                //OJO! esto sirve para rubros hoja... no puede venir con los padres, sino hay q iterar en profundidad tb
                rta4 = EjecutarNonQuery("INSERT INTO rubrospresupuesto (idPresupuesto,idRubro,cantPresRub) VALUES (  " + idPres + " , '" + r.getIdRubro() +  "' , " +r.getCantPresRub() + " )");
                Iterator itMat = r.getMateriales().iterator();
                while(itMat.hasNext())
                {
                    Material  ma = (Material)itMat.next();
                    rta2 = EjecutarNonQuery("INSERT INTO materialespresupuesto (idPresupuesto,idRubro,idMaterial,cantPresMat)  VALUES ( " + idPres + " , '" + r.getIdRubro() + "' , '" + ma.getIdMaterial()  + "' , " +ma.getCantPres() +   " )");
                    if(rta2 && rta4 && rta1)
                    {
                         rta = commit();
                         flag = false;
                         // System.out.println("commit ma");
                     }
                     if(!(rta2 && rta4 && rta1))
                     {
                         rollback();
                     }    
                 }
                Iterator itMo = r.getManoDeObra().iterator();
                while(itMo.hasNext())
                {
                 ManoDeObra  mo = (ManoDeObra)itMo.next();    
                 rta3 = EjecutarNonQuery("INSERT INTO manodeobrapresupuesto (idPresupuesto,idRubro,idManoDeObra,cantPresMO)  VALUES ( " + idPres + " , '" + r.getIdRubro() + "' , '" + mo.getIdManoDeObra()  + "' , " +mo.getCantPres() +   " )");
                    if(rta3 && rta4 && rta1)
                    {
                        rta = commit();
                         flag = false;
                        // System.out.println("commit mo");
                    }
                    if(!(rta3 && rta4 && rta1))
                    {
                        rollback();
                    }
                }
           }    
            if(rta1 && flag)
            {
                 rta = commit();
                 //System.out.println("commit rta y flag");
             }
            if(!(rta1 && flag))
            {
                rollback();
            }
        closeCon();
        return rta;
    }
        
    public List getPresupuestos() throws Exception {
        List<Presupuesto> listaPresupuestos = new ArrayList();
        List<Rubro> listaRubPres;
        String obs;

        ResultSet resultado = EjecutarQuery("select idPresupuesto, observaciones, idUsuario, idCliente, fechaCreacion from presupuestos ");
        while (resultado.next()) {
            Presupuesto pres = new Presupuesto();

            pres.setIdPresupuesto(resultado.getInt(1));

            if ( resultado.getString(2).equals("null")){
                obs="";
            }
            else {
                obs=resultado.getString(2);
            }
            pres.setObservaciones(obs);
            pres.setUsuario(getUsuarioPresupuesto(resultado.getInt(3)));
            pres.setCliente(getClientePresupuesto(resultado.getInt(4)));
            pres.setFechaCreacion(resultado.getDate(5));

            listaRubPres = getRubrosDelPresupuesto(resultado.getInt(1));
            pres.setRubros(listaRubPres);

            listaPresupuestos.add(pres);
        }
        closeCon();
        return listaPresupuestos;
    }
     
    public Usuario getUsuarioPresupuesto(int idUsuario) throws Exception  {
        Usuario user = new Usuario();
        ResultSet resultado = EjecutarQuery("SELECT idUsuario, nombreUsuario, pass  FROM usuarios WHERE idUsuario = " + idUsuario);

        while (resultado.next())
        {
            user.setIdUsuario(idUsuario);
            user.setNombreUsuario(resultado.getString(2));
            user.setPass(resultado.getString(3));

        }
        //resultado.close();
        return user;
    }
      
    public Cliente getClientePresupuesto(int idCliente) throws Exception    {
        Cliente cli = new Cliente();
        ResultSet resultado = EjecutarQuery("SELECT nomApeCli, direCli, telCli,emailCli  FROM clientes WHERE idCliente = " + idCliente);

        while (resultado.next())
        {
            cli.setIdCliente(idCliente); 
            cli.setNomApeCli(resultado.getString(1));
            cli.setDireCli(resultado.getString(2));
            cli.setTelCli(resultado.getString(3));
            cli.setEmailCli(resultado.getString(4));

        }
       // resultado.close();
        return cli;
    }
        
    public List getRubrosDelPresupuesto(int idPresup) throws Exception {
        List<Rubro> listaRub = new ArrayList();
        List<Rubro> listaSubRub = new ArrayList();
        List<Material> listaMat;
        List<ManoDeObra> listaMO;

        ResultSet resultado = EjecutarQuery("select r.idRubro,r.descRubro,r.idUnidadMedida, rp.cantPresRub from rubros r inner join rubrospresupuesto rp on r.idRubro = rp.idrubro and rp.idPresupuesto = " + idPresup);
        while (resultado.next()) {
            Rubro rub = new Rubro();
            rub.setIdRubro(resultado.getString(1));
            rub.setDescRubro(resultado.getString(2));
            rub.setIdUnidadMedida(resultado.getString(3));
            rub.setCantPresRub(resultado.getFloat(4));
            rub.setSubrubros(listaSubRub); //fix

            listaMat = getMaterialesEnRubroPresup(resultado.getString(1), idPresup);
            rub.setMateriales(listaMat);

            listaMO = getMOEnRubroPresup(resultado.getString(1), idPresup);
            rub.setManoDeObra(listaMO);

            listaRub.add(rub);
        }
        return listaRub;
    }
          
    /*metodo que busca los materiales para un id de rubro*/ 
    public List getMaterialesEnRubroPresup(String idRubro, int idPresupuesto) throws Exception{
        List listaMat = new ArrayList();
        ResultSet resultado = EjecutarQuery("select m.idMaterial, mp.cantPresMat , m.descMaterial, m.idUnidadMedida, m.precioMa from materialespresupuesto mp inner join  materiales m on mp.idMaterial = m.idMaterial where mp.idrubro = '" + idRubro + "' and mp.idPresupuesto = " + idPresupuesto);
        while (resultado.next()){
            Material mat = new Material();
            mat.setIdMaterial(resultado.getString(1));
            mat.setCantPres(resultado.getFloat(2));
            mat.setDescMaterial(resultado.getString(3));
            mat.setIdUnidadMedida(resultado.getString(4));
            mat.setPrecioMa(resultado.getFloat(5));

            listaMat.add(mat);
        }
        return listaMat;
    } 

    /*metodo que busca la mano de obra para un id de rubro*/ 
    public List getMOEnRubroPresup(String idRubro, int idPresupuesto) throws Exception{
        List listaMO = new ArrayList();
        ResultSet resultado = EjecutarQuery("select m.idManoDeObra, mp.cantPresMO , m.descManoDeObra, m.idUnidadMedida, m.precioMo from manodeobrapresupuesto mp inner join  manodeobra m on mp.idManoDeObra = m.idManoDeObra where mp.idrubro = '" + idRubro + "' and mp.idPresupuesto = " + idPresupuesto);
        while (resultado.next()){
            ManoDeObra mo = new ManoDeObra();
            mo.setIdManoDeObra(resultado.getString(1));
            mo.setCantPres(resultado.getFloat(2));
            mo.setDescManoDeObra(resultado.getString(3));
            mo.setIdUnidadMedida(resultado.getString(4));
            mo.setPrecioMo(resultado.getFloat(5));

            listaMO.add(mo);
        }
        return listaMO;
    }
     
    //borra pres y tablas relac.  
    public boolean delete(String idP) { 
	boolean rta = false;
	boolean rta1,rta2,rta3,rta4;

	rta1 =  EjecutarNonQuery("delete from presupuestos WHERE idPresupuesto = " + idP);
        rta2 =  EjecutarNonQuery("delete from rubrospresupuesto WHERE idPresupuesto = " + idP);
	rta3 =  EjecutarNonQuery("delete from manodeobrapresupuesto WHERE idPresupuesto = " + idP);
	rta4 =  EjecutarNonQuery("delete from materialespresupuesto WHERE idPresupuesto = " + idP);

        if(rta1 && rta2 && rta3 && rta4)
       {
             rta = commit();
         }
        else
         {
                 rollback();
         } 
        closeCon();
	return rta;
					 
    }
    
    public Presupuesto getPresupuesto( int idPresupuesto) throws Exception {
        Presupuesto pres = new Presupuesto();
        List<Rubro> listaRubPres;
        String obs;

        ResultSet resultado = EjecutarQuery("select idPresupuesto, observaciones, idUsuario, idCliente, fechaCreacion from presupuestos where idPresupuesto = " + idPresupuesto);
        while (resultado.next()) {

            pres.setIdPresupuesto(resultado.getInt(1));
            if ( resultado.getString(2).equals("null"))
            {
                obs="";
            }
             else {
                obs=resultado.getString(2);
            }
            pres.setObservaciones(obs);
            pres.setUsuario(getUsuarioPresupuesto(resultado.getInt(3)));
            pres.setCliente(getClientePresupuesto(resultado.getInt(4)));
            pres.setFechaCreacion(resultado.getDate(5));

            listaRubPres = getRubrosDelPresupuesto(resultado.getInt(1));
            pres.setRubros(listaRubPres);

  
        }
        closeCon();
        return pres;
    }
     
    public boolean update(Presupuesto p) {
        boolean rta=false;
        boolean rta1,rta2,rta3,rta4,rta5,rta6,rta7,rtaPred ;
        boolean flag = true;
        int idP = p.getIdPresupuesto();
        rta1 = EjecutarNonQuery("update presupuestos set observaciones = '" +p.getObservaciones()+"'   WHERE idPresupuesto = "  +  idP );

        rta2 =  EjecutarNonQuery("delete from rubrospresupuesto WHERE idPresupuesto = " + idP);
        rta3 =  EjecutarNonQuery("delete from manodeobrapresupuesto WHERE idPresupuesto = " + idP);
        rta4 =  EjecutarNonQuery("delete from materialespresupuesto WHERE idPresupuesto = " + idP);
        
        rtaPred = rta1 && rta2 && rta3 && rta4;
         if(rtaPred){
           Iterator itRub = p.getRubros().iterator();
           while(itRub.hasNext())
           {
                Rubro  r = (Rubro)itRub.next();
                flag = true;
                rta5 = EjecutarNonQuery("INSERT INTO rubrospresupuesto (idPresupuesto,idRubro,cantPresRub) VALUES (  " + idP + " , '" + r.getIdRubro() +  "' , " +r.getCantPresRub() + " )");
                Iterator itMat = r.getMateriales().iterator();
                while(itMat.hasNext())
                {
                Material  ma = (Material)itMat.next();
                rta6 = EjecutarNonQuery("INSERT INTO materialespresupuesto (idPresupuesto,idRubro,idMaterial,cantPresMat)  VALUES ( " + idP + " , '" + r.getIdRubro() + "' , '" + ma.getIdMaterial()  + "' , " +ma.getCantPres() +   " )");
                 if(rta6 && rta5 && rtaPred)
                    {
                         rta = commit();
                         flag = false;
                         // System.out.println("commit ma");
                     }
                     if(!(rta6 && rta5 && rtaPred))
                     {
                         rollback();
                     } 
                 }
                Iterator itMo = r.getManoDeObra().iterator();
                while(itMo.hasNext())
                {
                 ManoDeObra  mo = (ManoDeObra)itMo.next();    
                 rta7 = EjecutarNonQuery("INSERT INTO manodeobrapresupuesto (idPresupuesto,idRubro,idManoDeObra,cantPresMO)  VALUES ( " + idP + " , '" + r.getIdRubro() + "' , '" + mo.getIdManoDeObra()  + "' , " +mo.getCantPres() +   " )");
                   if(rta7 && rta5 && rtaPred)
                    {
                        rta = commit();
                         flag = false;
                        // System.out.println("commit mo");
                    }
                    if(!(rta7 && rta5 && rtaPred ))
                    {
                        rollback();
                    }
                }
           }   
         }
          if(rtaPred && flag)
            {
                 rta = commit();
             }
            if(!(rtaPred && flag))
            {
                rollback();
            }   
        closeCon();
        return rta;
     }
}
