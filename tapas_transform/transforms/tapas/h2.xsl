<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xd"
  version="1.0">

  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> 2014-04-21 by Syd Bauman</xd:p>
      <xd:p>Reads in an XHTML file (ostensibly generated by htm1.xslt),
      and writes out a copy thereof with a few tweaks:</xd:p>
      <xd:ul>
        <xd:li><xd:i>data-tapas-hashed-ref[-*]=</xd:i> whose target <xd:b>a</xd:b> element is
          in an otherwise empty <xd:b>p</xd:b> are deleted</xd:li>
        <xd:li>elements with only text node children have whitespace normalized on those text nodes
        (This is primarily for human readability, but also because I'm not sure what happens
        if you use CSS *:before and *:after selectors on nodes that have leading or trailing
        whitespace, respectively.)</xd:li>
      </xd:ul>
    </xd:desc>
  </xd:doc>
  
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="@*[ starts-with( local-name(.),'data-tapas-hashed-ref') ]">
    <xsl:variable name="thisRef" select="."/>
    <xsl:if test="count( //html:a[@id=$thisRef]/parent::html:p/* ) > 1">
      <xsl:copy/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="*[
        not( child::* )
    and not( child::comment() )
    and not( child::processing-instruction() )
    ]">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>