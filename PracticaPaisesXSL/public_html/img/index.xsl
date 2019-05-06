<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : index.xsl
    Created on : 8 de abril de 2019, 16:48
    Author     : horabaixa
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:my="http://whatever">
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->

    <xsl:function name="my:format">
        <xsl:param name="number"/>
        
        <xsl:choose>
            <xsl:when test="not(number($number) = number($number))">
                <xsl:value-of select="$number"/>
            </xsl:when>
            <xsl:when test="number($number[1]) = 0">
                <xsl:value-of select="'0'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="replace(format-number(number($number[1]),'###,###,###,###,###,###'),',','.')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
    <xsl:function name="my:comprobarDatos">
        <xsl:param name="nodo"/>
        <xsl:choose>
            <xsl:when test="$nodo">
                <xsl:value-of select="$nodo"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'No hay datos disponibles!'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
       
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Resultado</title>
                <meta charset="utf-8"></meta>
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"></meta>               
                <!--BOOTSTRAP--> 
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"></link>
                <!--MY CSS--> 
                <link rel="stylesheet" type="text/css" href="css/main.css"></link>
                <!--SCRIPTS--> 
                <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
            </head>
            <body>
                <!--Hecho utilizando saxon-->
                
                <xsl:call-template name="navBar"/>
                
                <div class="container-fluid mt-5">
                    
                    <xsl:call-template name="tarjetaPais">
                        <xsl:with-param name="continent" select="'europe'"/>
                        <xsl:with-param name="poblacion" select="'100000'"/>
                    </xsl:call-template>
                
                </div>
                
                         
                              
                <xsl:call-template name="footer"/>     
            </body>
        </html>
    </xsl:template>

    <!--**********************************************************************************************************************-->

    <xsl:template name="navBar">
        <div class="navbar navbar-expand-md navbar-dark bg-dark sticky-top">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarHiden">
                <sapn class="navbar-toggler-icon"></sapn>
            </button>
            <div class="collapse navbar-collapse" id="navbarHiden">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a href="index.html" class="nav-link">Home</a>
                    </li>
                </ul>
            </div>
        </div>
    </xsl:template>
    <!--*******************************************************************************************************************************-->
    <xsl:template name="footer">
        <div class="footer footer-copyright text-center text-muted bg-dark p-3">
            <div class="container-fluid">
                <p>Informacón países</p>
            </div>
        </div>
    </xsl:template>


    <!--************************************************************************************************************************************-->
    <xsl:template name="tarjetaPais">
        <xsl:param name="continent"/>
        <xsl:param name="poblacion"/>
        
        <xsl:variable name="continentName" select="mondial/continent[contains(lower-case(@name), lower-case($continent))]/@name"/>
        <xsl:variable name="continentId" select="mondial/continent[contains(lower-case(@name), lower-case($continent))]/@id"/>
        
        <div class="d-flex justify-content-center">
            <h1 class="badge badge-primary">Países del continente de <xsl:value-of select="$continentName"/></h1>
            
        </div>
        <img class="mx-auto d-block bigImg">
            <xsl:attribute name="src">img/continents/<xsl:value-of select="replace($continentName,'/','_')"/>.svg</xsl:attribute>
        </img>
            
        
        <div class="row justify-content-center">
            <xsl:for-each select="mondial/country[encompassed/@continent = $continentId]">
                <xsl:sort select="name[1]"/>
                    
                <!--Variables para cada pais-->
                
                <xsl:variable name="capital" select="@capital"/>
                
                <xsl:variable name="maxEtinia" select="max(ethnicgroups/@percentage)"/>
                
                <xsl:variable name="maxReligion" select="max(religions/@percentage)"/>
                
                <xsl:variable name="countryId" select="@id"/>
                
                <xsl:variable name="getReligion">
                    <xsl:choose>
                        <xsl:when test="religions">
                            <xsl:value-of select="religions[@percentage = $maxReligion]/text()"/> 
                            <xsl:value-of select="religions[@percentage = $maxReligion]/@percentage"/>%
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>No hay datos disponibles!</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                
                <xsl:variable name="getEtinia">
                    <xsl:choose>
                        <xsl:when test="ethnicgroups">
                            <xsl:value-of select="ethnicgroups[@percentage = $maxEtinia]/text()"/> 
                            <xsl:value-of select="ethnicgroups[@percentage = $maxEtinia]/@percentage"/>%
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>No hay datos disponibles!</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
            
                <xsl:variable name="inflationColor">
                    <xsl:choose>
                        <xsl:when test="@inflation &lt; 2.5">
                            <xsl:text>verde list-group-item</xsl:text>
                        </xsl:when>
                        <xsl:when test="@inflation &gt; 2.5 and @inflation &lt; 5">
                            <xsl:text>amarillo list-group-item</xsl:text>
                        </xsl:when>
                        <xsl:when test="@inflation &gt; 5 and @inflation &lt; 10">
                            <xsl:text>naranja list-group-item</xsl:text>
                        </xsl:when>
                        <xsl:when test="@inflation &gt; 10">
                            <xsl:text>rojo list-group-item</xsl:text>                        
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>list-group-item</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
            
                <!--____________________________________________________________________________________________________________________________-->
                
                <div class="card col-md-4">
                
                    <img class="card-img-top img-fluid img-thumbnail">
                        <xsl:attribute name="src">img/flags/<xsl:value-of select="lower-case(@car_code)"/>.svg</xsl:attribute>
                    </img>
                    <div class="card-body">
                    
                        <h3 class="card-title">
                            <xsl:value-of select="name"/>
                        </h3>
                    
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">Capital: <xsl:value-of select="my:comprobarDatos(descendant::city[@id = $capital]/name)"/></li>
                            <li class="list-group-item">Población: <xsl:value-of select="my:format(my:comprobarDatos(@population))"/></li>
                            <li class="list-group-item">Área: <xsl:value-of select="my:format(my:comprobarDatos(@total_area))"/> m<sup>2</sup></li>
                            <li class="list-group-item">Religión: <xsl:value-of select="$getReligion"/></li>
                            <li class="list-group-item">Étinia: <xsl:value-of select="$getEtinia"/></li>
                            
                        </ul>
                    </div>
                    <div class="card-footer d-flex justify-content-center">
                        <button type="button" class="btn btn-primary" data-toggle="modal">
                            <xsl:attribute name="data-target">
                                #<xsl:value-of select="$countryId"/>
                            </xsl:attribute>Más información</button>
                    </div>
                     
                    <div class="modal fade">
                        <xsl:attribute name="id">
                            <xsl:value-of select="$countryId"/>
                        </xsl:attribute>
                    
                        <div class="modal-dialog modal-xl ">
                        
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">
                                        <xsl:value-of select="name"/>
                                    </h4>
                                    <button type="button" class="close" data-dismiss="modal">x</button>
                                </div>
                            
                                <div class="modal-body">
                                
                                    <h1 class="badge badge-secondary mt-4">Información general</h1>
                                    <ul class="list-group list-group-striped">
                                        <li class="list-group-item">Capital: <xsl:value-of select="my:comprobarDatos(descendant::city[@id = $capital]/name)"/></li>
                                        <li class="list-group-item">Población: <xsl:value-of select="my:format(my:comprobarDatos(@population))"/></li>
                                        <li class="list-group-item">Área: <xsl:value-of select="my:format(my:comprobarDatos(@total_area))"/> m<sup>2</sup></li>
                                        <li class="list-group-item">Religión: <xsl:value-of select="$getReligion"/></li>
                                        <li class="list-group-item">Étinia: <xsl:value-of select="$getEtinia"/></li>
                                        <li class="list-group-item">GPD: <xsl:value-of select="my:format(my:comprobarDatos(@gdp_total))"/></li>
                                        <li class="list-group-item">
                                            <xsl:attribute name="class">
                                                <xsl:value-of select="$inflationColor"/>
                                            </xsl:attribute>
                                            Inflación: <xsl:value-of select="my:comprobarDatos(@inflation)"/>
                                        </li>    
                                        <li class="list-group-item">Número de organizaciones a que pertenece: <xsl:value-of select="count(/mondial/organization/members[@country = $countryId])"/></li>                    
                                    </ul>
                                
                                    <xsl:if test="border">
                                        <h1 class="badge badge-secondary mt-4">Países con el cual hace frontera</h1>
                                        <ul class="list-group list-group-striped">
                                            <xsl:call-template name="border">
                                                <xsl:with-param name="border" select="border"/>
                                            </xsl:call-template>
                                        </ul>
                                    </xsl:if>
                                    
                                    <h1 class="badge badge-secondary mt-4">Accidentes geográficos</h1>
                                    <ul class="list-group list-group-striped">
                                        <xsl:call-template name="accidentesGeograficos">
                                            <xsl:with-param name="country" select="$countryId"/>
                                        </xsl:call-template>
                                    </ul>
                                    
                                    <xsl:if test="descendant::city[population/number() > number($poblacion)]">
                                        <h1 class="badge badge-secondary mt-4">Ciudades con población mayor a <xsl:value-of select="my:format($poblacion)"/></h1>
                                        <table class="table table-bordered table-striped">
                                            <xsl:call-template name="ciudades">
                                                <xsl:with-param name="poblacion" select="$poblacion"/>
                                                <xsl:with-param name="country" select="$countryId"/>
                                            </xsl:call-template>
                                        </table>
                                    </xsl:if>
                                </div>
                            
                            
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                                </div>
                            </div>
                        
                        </div>
                    </div>
 
                </div>
            </xsl:for-each> 
        </div>  
        
    </xsl:template>

    <!--*******************************************************************************************************************************************-->
    <xsl:template name="border">
        <xsl:param name="border"/>
        <xsl:variable name="borderCountry" select="$border/@country"/>
        <xsl:for-each select="/mondial/country[@id = $borderCountry]">
            <li class="list-group-item">
                <xsl:value-of select="name"/>
            </li>
        </xsl:for-each>
    </xsl:template>
    <!--***************************************************************************************************************************************************-->
    <xsl:template name="ciudades">
        <xsl:param name="poblacion"/>
        <xsl:param name="country"/>
        <thead class="thead-dark">
            <tr>
                <td scope="col">Ciudad</td>
                <td scope="col">Población</td>
                <td scope="col">Latitud</td>
                <td scope="col">Longitud</td>
                <td scope="col">Provincia</td>
            </tr>
        </thead>
        <tbody>
            <xsl:for-each select="/mondial/country[@id = $country]/descendant::city[population/number() &gt; number($poblacion)]">
                <xsl:sort select="population[1]/number()"/>
                <tr>
                    <td scope="row">
                        <xsl:value-of select="name"/>
                    </td>
                    <td>
                        <xsl:value-of select="my:format(population)"/>
                    </td>
                    <td>
                        <xsl:value-of select="@latitude"/>
                    </td>
                    <td>
                        <xsl:value-of select="@longitude"/>
                    </td>
                    <td>
                        <xsl:value-of select="parent::province/@name"/>
                    </td>
                </tr>
            </xsl:for-each>
        </tbody>
    </xsl:template>
    <!--**********************************************************************************************************************************-->
    <xsl:template name="accidentesGeograficos">
        <xsl:param name="country"/>
        <li class="list-group-item">Montañas: <xsl:value-of select="my:format(count(/mondial/mountain[located/@country = $country]))"/></li>
        <li class="list-group-item">Desiertos: <xsl:value-of select="my:format(count(/mondial/desert[located/@country = $country]))"/></li>
        <li class="list-group-item">Mares: <xsl:value-of select="my:format(count(/mondial/sea[located/@country = $country]))"/></li>
        <li class="list-group-item">Mares: <xsl:value-of select="my:format(count(/mondial/river[located/@country = $country]))"/></li>
        <li class="list-group-item">Lagos: <xsl:value-of select="my:format(count(/mondial/lake[located/@country = $country]))"/></li>
        <li class="list-group-item">Islas: <xsl:value-of select="my:format(count(/mondial/island[located/@country = $country]))"/></li>
    </xsl:template>

</xsl:stylesheet>
