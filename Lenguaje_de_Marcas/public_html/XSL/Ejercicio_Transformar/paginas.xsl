<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : paginas.xsl
    Created on : 2 de abril de 2019, 18:34
    Author     : horabaixa
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <html>
            <head>
                <title>paginas.xsl</title>
            </head>
            <body>
                <ul>
                    <xsl:for-each select="marcadores/marcador">
                        <li>
                            <a>
                                <xsl:if test="nuevaVentana">
                                    <xsl:attribute name="target">_blank</xsl:attribute>
                                </xsl:if>
                                
                                
                                <xsl:attribute name="href">
                                    <xsl:value-of select="destino"/>
                                </xsl:attribute>
                                
                                
                                <xsl:value-of select="titulo"/>
                            </a>
                        </li>
                    </xsl:for-each>
                </ul>
                
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
