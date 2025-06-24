<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="1.0">

    <!-- Output in HTML -->
    <xsl:output method="html" encoding="UTF-8" indent="yes" />

    <!-- =========================
           Parametri globali
    ===========================-->
    <xsl:param name="mostraIndice" select="'si'"/>
    <xsl:param name="mostraIntroduzione" select="'si'"/>
    <xsl:param name="mostraConclusione" select="'si'"/>

    <!-- =========================
           Variabili globali
    ===========================-->
    <xsl:variable name="titoloOpera"
        select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title" />

    <!-- =========================
           MAIN TEMPLATE
    ===========================-->
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="$titoloOpera" /></title>
                <link rel="stylesheet" type="text/css" href="./mycss.css" />
                <style>h1{ color:blue; }</style>
            </head>
            <body>
                <!-- INDICE DEI CAPITOLI -->
                <xsl:if test="$mostraIndice='si'">
                    <div class="index">
                        <h1>INDEX</h1>
                        <ul>
                            <xsl:apply-templates select="//div[@type='chapter']" mode="index" />
                        </ul>
                    </div>
                </xsl:if>

                <!-- INTRODUZIONE -->
                <xsl:if test="$mostraIntroduzione='si'">
                    <xsl:call-template name="stampaSezione">
                        <xsl:with-param name="elemento" select="//div[@type='introduction']" />
                        <xsl:with-param name="classe" select="'introduzione'" />
                    </xsl:call-template>
                </xsl:if>

                <!-- CONTENUTO PRINCIPALE -->
                <div>
                    <xsl:apply-templates select="child::node()" />
                </div>

                <!-- CONCLUSIONE -->
                <xsl:if test="$mostraConclusione='si'">
                    <xsl:call-template name="stampaSezione">
                        <xsl:with-param name="elemento" select="//div[@type='conclusion']" />
                        <xsl:with-param name="classe" select="'conclusione'" />
                    </xsl:call-template>
                </xsl:if>
            </body>
        </html>
    </xsl:template>

    <!-- =========================
           TEMPLATE per INDEX
    ===========================-->
    <xsl:template match="div" mode="index">
        <xsl:for-each select=".">
            <li>
                <xsl:call-template name="stampaTitoloCapitolo">
                    <xsl:with-param name="capitolo" select="head" />
                </xsl:call-template>
            </li>
        </xsl:for-each>
    </xsl:template>

    <!-- NAMED TEMPLATE per stampare il TITOLO dei CAPITOLI -->
    <xsl:template name="stampaTitoloCapitolo">
        <xsl:param name="capitolo" />
        <h3><xsl:value-of select="$capitolo" /></h3>
    </xsl:template>

    <!-- NAMED TEMPLATE GENERICO per SEZIONI INTRODUZIONE / CONCLUSIONE -->
    <xsl:template name="stampaSezione">
        <xsl:param name="elemento" />
        <xsl:param name="classe" />
        <div>
            <xsl:attribute name="class"><xsl:value-of select="$classe"/></xsl:attribute>
            <h2><xsl:value-of select="$elemento/head"/></h2>
            <div class="content">
                <xsl:apply-templates select="$elemento/*[not(self::head)]"/>
            </div>
        </div>
    </xsl:template>

    <!-- =========================
           Altri TEMPLATE BASE
    ===========================-->
    <xsl:template match="titleStmt/title">
        <h2><xsl:value-of select="." /></h2>
    </xsl:template>

    <xsl:template match="div/head">
        <h3><xsl:value-of select="." /></h3>
    </xsl:template>

    <xsl:template match="tei:persName">
        <a href="http://"><xsl:value-of select="." /></a>
    </xsl:template>

    <xsl:template match="teiHeader">
        <span>[identificativo del documento: <xsl:value-of select="@xml:id" />]</span>
    </xsl:template>

</xsl:stylesheet>
