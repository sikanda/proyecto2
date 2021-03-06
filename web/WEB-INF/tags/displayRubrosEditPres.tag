<%@tag description="usado por editPres" pageEncoding="UTF-8"%>
 <%@ taglib tagdir="/WEB-INF/tags" prefix="myTagsEditPres" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@ attribute name="rub" required="true" type="Entidades.Rubro" %>

<%-- any content can be specified here e.g.: --%>    
<tr>
    <td><c:out value= "${rub.descRubro}" /></td>
    <td><input type="text" class= "edit" name ="${rub.idRubro}" style="width: 40px;" onkeypress="return numbersOnly(this, event);" value= "${rub.cantPresRub}" /></td><%-- cantidad --%>  
    <td class= "unit"><c:out value= "${rub.idUnidadMedida}"/></td>
    <td><c:out value= "${rub.idRubro}" /></td> 
 </tr>

<c:forEach items="${rub.materiales}" var="mat" >
    <tr >
        <td><c:out value= "${mat.descMaterial}"/></td> 
<td><input type="text" class= "edit" name="${rub.idRubro}" style="width: 40px;" onkeypress="return numbersOnly(this, event);" value="${mat.cantPres}"  /></td> <%--mat.coefStdMat--%>
        <td><c:out value= "${mat.idUnidadMedida}"/></td> 
       <%-- la clase hidRub existe para saber q rubros tengo q cambiar (en cant numericas) cuando cambia la cantidad del padre.--%>   
        <td class="hidRub"><c:out value= "${rub.idRubro}" /></td> 
        <td><c:out value= "${mat.cantPres}" /></td>  
         <td><c:out value= "${mat.coefStdMat}" /></td>  
    </tr>
</c:forEach>

<c:forEach items="${rub.manoDeObra}" var="mo">
    <tr >
        <td><c:out value= "${mo.descManoDeObra}"  /></td>
        <td> <input type="text" class= "edit" name = "${rub.idRubro}" style="width: 40px;" onkeypress="return numbersOnly(this, event);" value= "${mo.cantPres}"/></td>  <%--mo.coefStdMO--%>
        <td><c:out value= "${mo.idUnidadMedida}" /></td> 
        <td class="hidRub"><c:out value= "${rub.idRubro}" /></td> 
        <td><c:out value= "${mo.cantPres}" /></td>  
          <td><c:out value= "${mo.coefStdMO}" /></td>  
 </tr>
</c:forEach>
<c:forEach items="${rub.subrubros}" var="srub">
    <myTagsEditPres:displayRubrosEditPres rub="${srub}"/>       
</c:forEach>



