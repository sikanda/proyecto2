package Datos;

import Entidades.Empleado;
import java.sql.ResultSet;
import java.util.*;


public class EmpleadoDB extends AccesoDatos {

public EmpleadoDB() throws Exception{}

	//Todo: agregar metodos custom, if necessary
     public boolean save(Empleado e){ 
        boolean rta = false;
        	rta = EjecutarNonQuery("insert into empleados (nombreEmp, apellidoEmp, direEmp, emailEmp, telEmp)  VALUES ( '" + e.getNombreEmp()  + "' , '" + e.getApellidoEmp() + "' , '" + e.getDireEmp() + "' , '" + e.getEmailEmp() + "' , '" + e.getTelEmp() +  "' )");
                if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }

  public boolean update(Empleado e){
        boolean rta = false;
		rta = EjecutarNonQuery("UPDATE empleados SET nombreEmp = '" + e.getNombreEmp() + "', apellidoEmp = '" + e.getApellidoEmp() + "', direEmp = '" + e.getDireEmp() + "', telEmp = '" + e.getTelEmp() + "', emailEmp = '" + e.getEmailEmp() + "' WHERE idEmpleado = " + e.getIdEmpleado());
         
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
  
   public boolean delete(int idE){
        boolean rta = false;
		rta = EjecutarNonQuery("delete from empleados WHERE idEmpleado = " + idE);
	if(rta){
            rta = commit();
        }
        if(!rta){
            rollback();
        }
		closeCon();
        return rta;
    }
   
       public List getEmpleados() throws Exception{
            List listaEmp = new ArrayList();
            ResultSet resultado = EjecutarQuery("SELECT  idEmpleado, nombreEmp, apellidoEmp, direEmp, emailEmp, telEmp, fechaNacEmp FROM empleados");
            while (resultado.next()){
                Empleado emp = new Empleado();
                emp.setIdEmpleado(resultado.getInt(1));
                emp.setNombreEmp(resultado.getString(2));
                emp.setApellidoEmp(resultado.getString(3));
                emp.setDireEmp(resultado.getString(4));
                emp.setEmailEmp(resultado.getString(5));
                emp.setTelEmp(resultado.getString(6));
            
                listaEmp.add(emp);
            }
            closeCon();
            return listaEmp;
	}
       
      public Empleado getEmpleado(int idEmpleado) throws Exception
    {
        Empleado emp = new Empleado();
        ResultSet resultado = EjecutarQuery("SELECT  idEmpleado, nombreEmp, apellidoEmp, direEmp, emailEmp, telEmp, fechaNacEmp  FROM empleados WHERE idEmpleado = " + idEmpleado);

        while (resultado.next())
        {
			emp.setIdEmpleado(resultado.getInt(1));
			emp.setNombreEmp(resultado.getString(2));
			emp.setApellidoEmp(resultado.getString(3));
			emp.setDireEmp(resultado.getString(4));
			emp.setEmailEmp(resultado.getString(5));
			emp.setTelEmp(resultado.getString(6));

        }
        resultado.close();
        return emp;
    }
      
          public int getIdEmpleado(){
        int rta = EjecutarQueryInt("SELECT MAX(idEmpleado) FROM empleados")+1;
        closeCon();
        return (rta);

    }
}