<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns="http://www.topografix.com/GPX/1/0"
  xmlns:regex="http://exslt.org/regular-expressions"
  xmlns:gml="http://www.opengis.net/gml"
  xmlns:vliz="http://www.vliz.be/gis"
  extension-element-prefixes="regex"
  version="1.0">
  <xsl:output method="text" version="1.0" omit-xml-declaration="yes"  />

  <xsl:template match="/">
    <xsl:apply-templates select="*[local-name()='FeatureCollection']/*[local-name()='FeatureCollection']"/>
  </xsl:template>

  <xsl:template match="*[local-name()='kml']/*[local-name()='FeatureCollection']">
  <?xml version="1.0" encoding="UTF-8"?>
  <gpx
    version="1.0"
    creator="GPSBabel - http://www.gpsbabel.org"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="http://www.topografix.com/GPX/1/0"
    xsi:schemaLocation="http://www.topografix.com/GPX/1/0 http://www.topografix.com/GPX/1/0/gpx.xsd">
    <time>2012-05-16T10:01:42Z</time>
    <xsl:apply-templates select="*[local-name()='featureMember']"/>
  </gpx>
  </xsl:template>

  <xsl:template match="gml:featureMember">
    <xsl:element name="wpt">
      <xsl:element name="name">
        <xsl:value-of select="kml:name/text()"/>
      </xsl:element>    
      <xsl:element name="desc">
        <xsl:value-of select="kml:Snippet/text()"/>
        <xsl:value-of select="kml:description/text()"/>
      </xsl:element>
      <xsl:choose>
        <xsl:when test="contains(kml:description/text(),'href')">
          <xsl:element name="link">
            <xsl:attribute name="href">
                  <xsl:value-of select="substring-before(substring-after(kml:description, 'href=&quot;'),'&quot;')" />
            </xsl:attribute>
            <xsl:element name="text">
              <xsl:value-of select="substring-before(substring-after(kml:description, '&quot;&gt;'), '&lt;')" />
            </xsl:element>
          </xsl:element>
        </xsl:when>
        <xsl:when test="contains(kml:description/text(),'src=')">
          <xsl:element name="link">
            <xsl:attribute name="href">
                  <xsl:value-of select="substring-before(substring-after(kml:description, 'src=&quot;'),'&quot;')" />
            </xsl:attribute>
            <xsl:element name="text">
              <xsl:value-of select="substring-before(substring-after(kml:description, 'alt=&quot;'), '&quot;')" />
            </xsl:element>
          </xsl:element>
        </xsl:when>
      </xsl:choose>
      <xsl:apply-templates select="kml:Style" />
    </xsl:element>
  </xsl:template>

  <xsl:template match="kml:LookAt">
    <xsl:attribute name="lat">
      <xsl:value-of select="kml:latitude"/>
    </xsl:attribute>
    <xsl:attribute name="lon">
      <xsl:value-of select="kml:longitude"/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="kml:Point">
    <xsl:attribute name="lat">
      <xsl:value-of select="substring-before(kml:Point/kml:coordinates,',')"/>
    </xsl:attribute>
    <xsl:attribute name="lon">
      <xsl:value-of select="substring-before(substring-after(kml:Point/kml:coordinates,','),',')"/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="kml:Style">
    <sym>
      <!--xsl:value-of select="reverse(substring-before(reverse(),','))"/-->
      <xsl:call-template name="substring-before-last">
        <xsl:with-param name="input">
          <xsl:call-template name="substring-after-last">
            <xsl:with-param name="input" select="kml:IconStyle/kml:Icon/kml:href" />
            <xsl:with-param name="substr">/</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="substr">.</xsl:with-param>
      </xsl:call-template>
    </sym>
  </xsl:template>

  <xsl:template match="kml:description">
    <desc>
    </desc>
  </xsl:template>

  <xsl:template name="substring-before-last">
    <xsl:param name="input" />
    <xsl:param name="substr" />
    <xsl:if test="$substr and contains($input, $substr)">
      <xsl:variable name="temp" select="substring-after($input, $substr)" />
      <xsl:value-of select="substring-before($input, $substr)" />
      <xsl:if test="contains($temp, $substr)">
        <xsl:value-of select="$substr" />
        <xsl:call-template name="substring-before-last">
          <xsl:with-param name="input" select="$temp" />
          <xsl:with-param name="substr" select="$substr" />
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>
     
  <xsl:template name="substring-after-last">
    <xsl:param name="input"/>
    <xsl:param name="substr"/>
       
    <!-- Extract the string which comes after the first occurrence -->
    <xsl:variable name="temp" select="substring-after($input,$substr)"/>
       
    <xsl:choose>
         <!-- If it still contains the search string the recursively process -->
         <xsl:when test="$substr and contains($temp,$substr)">
              <xsl:call-template name="substring-after-last">
                   <xsl:with-param name="input" select="$temp"/>
                   <xsl:with-param name="substr" select="$substr"/>
              </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
              <xsl:value-of select="$temp"/>
         </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>