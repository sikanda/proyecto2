package Base;

public class Config {
    private final String nombrePag = "Cimax construcciones";
    private final String adminID = "admin";
    private final String adminPass = "1234";
    private final String separador = "&#8594;";
  

    public String nombrePag()
    {
        return nombrePag;
    }

    public boolean adminLogin(String id , String pass)
    {
        boolean rta = false;
        if (id.equals(adminID) && pass.equals(adminPass) )
        {
            rta = true;
        }
        return rta;
    }

    public String separador()
    {
        return separador;
    }
    


    public static String generarMD5(java.util.Date date) throws Exception
    {
        java.security.MessageDigest digest = java.security.MessageDigest.getInstance("MD5");
        digest.update(date.toString().getBytes());
        return digest.digest().toString();
    }

}