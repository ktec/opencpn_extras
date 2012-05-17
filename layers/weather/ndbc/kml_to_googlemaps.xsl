<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method = "text"  version="1.0" omit-xml-declaration="yes"  />

<xsl:template match="/">
<xsl:apply-templates select="*[local-name()='kml']/*[local-name()='Document']"/>
</xsl:template>

<xsl:template match="*[local-name()='kml']/*[local-name()='Document']">
<xsl:apply-templates select="*[local-name()='Folder']"/>
</xsl:template>

<xsl:template match="*[local-name()='Folder']">
<xsl:apply-templates select="*[local-name()='Folder' or local-name()='Placemark']"/>
</xsl:template>

<xsl:template match="*[local-name()='Placemark']">
<xsl:apply-templates select="*[local-name()='MultiGeometry']"/>
</xsl:template>

<xsl:template match="*[local-name()='MultiGeometry']">
<xsl:apply-templates select="*[local-name()='LineString']"/>
</xsl:template>

<xsl:template match="*[local-name()='LineString']">
<xsl:apply-templates select="*[local-name()='coordinates']"/>
</xsl:template>

<xsl:template match="*[local-name()='coordinates']">&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;
&lt;html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml"&gt;
&lt;head&gt;
&lt;meta http-equiv="content-type" content="text/html; charset=UTF-8"/&gt;
&lt;title&gt;Google Maps API Example - overlay&lt;/title&gt;
&lt;style type="text/css"&gt;
v\:* {
 behavior:url(#default#VML);
}
&lt;/style&gt;
&lt;script src="http://maps.google.com/maps?file=api&amp;v=1&amp;key=ABQIAAAA4Wxrd1ZmQfRHvggZWM0QkxSywvohUEBj468j1bHLctjAi9H1aRTgpH5EJsqp8F3DqOP3spOw36wc2A" type="text/javascript"&gt;&lt;/script&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[
function onLoad() {
    var map = new GMap(document.getElementById("map"));
    map.setMapType(G_HYBRID_TYPE)
    map.addControl(new GSmallMapControl());
    map.addControl(new GMapTypeControl());
    <xsl:call-template name="firstPoint">
      <xsl:with-param name="str" select="normalize-space(.)"/>
    </xsl:call-template>
    var points = [];
    <xsl:call-template name="split">
      <xsl:with-param name="str" select="normalize-space(.)"/>
    </xsl:call-template>
    map.addOverlay(new GPolyline(points));
    }
//]]&gt;
&lt;/script&gt;
&lt;/head&gt;
&lt;body onload="onLoad()"&gt;
&lt;div id="map" style="width: 500px; height: 300px"&gt;&lt;/div&gt;
&lt;div id="message"&gt;&lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;
</xsl:template>

<xsl:template name="firstPoint"><xsl:param name="str"/>
<xsl:if test="contains($str,' ')">    map.centerAndZoom(new GPoint(<xsl:value-of select="substring-before(substring-before($str,' '),',0')"/>), 5);
</xsl:if>
</xsl:template>

<xsl:template name="split"><xsl:param name="str"/>
<xsl:choose><xsl:when test="contains($str,' ')">    points.push(new GPoint(<xsl:value-of select="substring-before(substring-before($str,' '),',0')"/>));
<xsl:call-template name="split">
   <xsl:with-param name="str" select="normalize-space(substring-after($str,' '))"/>
</xsl:call-template></xsl:when>
<xsl:otherwise></xsl:otherwise>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>