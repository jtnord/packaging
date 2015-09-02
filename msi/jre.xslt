<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
    xmlns="http://schemas.microsoft.com/wix/2006/wi"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />

  <xsl:param name="javaID" select="'___JAVA___EXE___ID___'"/>
  
  <xsl:template match="//File/@Id[contains(@Source,'\java.exe')]">
     <!-- 
       replace the autogenerate ID with the stable id
       An alternative is to put the firewall rule directly in this file.
     -->
     <xsl:attribute name="Id">
         <xsl:value-of select="$javaID"/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet> 