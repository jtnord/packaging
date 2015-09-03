<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:wix="http://schemas.microsoft.com/wix/2006/wi"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns='http://schemas.microsoft.com/wix/2006/wi'
    exclude-result-prefixes='wix'>

  <xsl:output method="xml" indent="yes"/>

  <xsl:param name="javaID" select="'___JAVA___EXE___ID___'"/>

  <xsl:template match="wix:File[contains(@Source,'java.exe')]">
     <!-- 
       replace the autogenerate ID with the stable id
       An alternative is to put the firewall rule directly in this file.
     -->
     <File>
         <xsl:copy-of select="@*" />
         <xsl:attribute name="Id">
             <xsl:value-of select="$javaID"/>
         </xsl:attribute>
     </File>
  </xsl:template>


  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

 <xsl:template match="/">
    <xsl:comment>!!!JAMES WAS HERE.</xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  
</xsl:stylesheet> 