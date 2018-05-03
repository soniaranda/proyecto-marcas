<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="smallcase" select="'abcdefghijklmnñopqrstuvwxyz'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ'" />

<xsl:template match="/">
    <html>
       <head>
          
           <script>
               let p;
               let options;
               function load(){
                    p=document.getElementById("toDisplay");
                    options = document.querySelectorAll("option");
                    for(let o of options){
                        o.addEventListener("click",changeP,false);
                    }
               }
               function changeP(event){
                   let element = document.getElementById(""+event.target.innerHTML);
                   p.innerHTML=element.innerHTML;
               }
               window.onload=load; 
           </script>
           
       </head>
       <xsl:value-of select="./*/*/*/@año"/>
        <body> 
           <!-- nombre del instituto -->
           <h1><xsl:value-of select="./ies/@nombre"/></h1>
           
           <!-- página web del instituto -->
           <h2><xsl:value-of select="./ies/@web"/></h2>
           <h3><xsl:value-of select="translate(name(./*/*/*/decretoTitulo),$smallcase,$uppercase)"/></h3>
           
           <!-- año en el que se publicaron los ciclos y su id-->
           <xsl:for-each select="./*/*/*">
               <span style="padding-right:20px">
                   <xsl:value-of select="./@id"/>: 
                   <xsl:value-of select="./*/@año"/>
               </span>
           </xsl:for-each>

           <br/>
           <span style="padding-right:10px">
               <xsl:value-of select="translate(name(./ies/*),$smallcase,$uppercase)"/>
           </span>
           
           <select name="cursos" id="cursos" style="margin-top:40px">
                <xsl:for-each select="ies/ciclos/ciclo">
                    <option class="options">
                       <xsl:value-of select="./@id"/>
                    </option>
                </xsl:for-each>
            </select>
            <p style="display:none" id="ASIR">
                <xsl:value-of select="./*/*/ciclo[@id='ASIR']/*[self::nombre]"/>
            </p>
            <p style="display:none" id="DAW">
                <xsl:value-of select="./*/*/ciclo[@id='DAW']"/>
            </p>
            <p style="display:none" id="SMR">
                <xsl:value-of select="./*/*/ciclo[@id='SMR']/*/@año"/>
            </p>
            <p id="toDisplay"></p>
            
            <!--ciclos formativos de grado medio-->
            <!--EXPRESION XPATH: //ciclos/ciclo[grado='Medio'] -->
           <h3>GRADO MEDIO</h3>
            <xsl:for-each select="//ciclo[grado='Medio']">
                <p><xsl:value-of select="./*[self::nombre]"/></p>
            </xsl:for-each>
            
            <!--nombre de los ciclos formativos de grado superior-->
            <!--EXPRESION XPATH: //ciclos/ciclo[grado='Superior']/nombre -->
            <h3>GRADO SUPERIOR</h3>
            <xsl:for-each select="//ciclo[grado='Superior']">
                <p><xsl:value-of select="./*[self::nombre]"/></p>
            </xsl:for-each>
            
            <!--nombre de los ciclos anteriores a 2010-->
            <!--EXPRESION XPATH: //ciclos/ciclo/decretoTitulo[@año &lt; 2010]/../nombre -->
            <h3>CICLOS FORMATIVOS ANTERIORES A 2010</h3>
            <xsl:for-each select="//ciclo/decretoTitulo[@año &lt; 2010]">
                <p><xsl:value-of select="../nombre"/></p>
            </xsl:for-each>
            
            <!--nombre de los ciclos del año 2008 o 2010-->
            <!--EXPRESION XPATH: //ciclos/ciclo/decretoTitulo[@año=2008 or @año=2010]/../nombre -->
            <h3>CICLOS FORMATIVOS DEL 2008 o 2010</h3>
            <xsl:for-each select="//ciclo/decretoTitulo[@año=2008 or @año=2010]">
                <p><xsl:value-of select="../nombre"/></p>
            </xsl:for-each>
        </body>
        
    </html>
</xsl:template>
</xsl:stylesheet>