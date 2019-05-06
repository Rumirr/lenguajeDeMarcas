<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : prova.xsl
    Created on : 1 de abril de 2019, 18:48
    Author     : horabaixa
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <html>
            <head>
                <title>prova.xsl</title>
            </head>
            <body>
                <h1>Prova</h1>
                <ul>
                    <xsl:for-each select="prova/node">
                        <xsl:sort/>
                        
                        <li>
                            <xsl:value-of select="."/>
                        </li>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
