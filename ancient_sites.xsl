<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:template match="/">
  <html>
    <head>
      <meta charset="utf-8"></meta>
      <title>Ancient Places in China</title>
      <!-- css styles -->
      <link rel="stylesheet" type="text/css" href="styles.css"></link>
    </head>
    <body>
      <header>
        <h3>Details of Ancient Places in China</h3>
      </header>
  <table summary="Ancient Places to visit in China">
        <thead>
          <tr>
            <th>Site</th>
            <th>Appearance Year</th>
            <th>Dynasty</th>
            <th>Existence</th>
            <th colspan="2">Size</th>
            <th>Overview</th>
            <th>Images</th>
            <th>Example</th>
            <th>Description</th>
          </tr>
        </thead>
      
        <tbody>
          <xsl:apply-templates select="ancient_sites/site">
            <xsl:sort select="location" order="ascending" data-type="string" />
          </xsl:apply-templates>
        </tbody>
      </table>
      <table summary="Modern Places in China">
        <thead>
          <tr>
            <th>Site</th>
            <th>Appearance Year</th>
            <th>Dynasty</th>
            <th>Existence</th>
            <th colspan="2">Size</th>
            <th>Overview</th>
            <th>Images</th>
            <th>Example</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          <xsl:apply-templates select="ancient_sites/site[./history/year &gt; 710]">
            <xsl:sort select="year" order="descending" data-type="number" />
          </xsl:apply-templates>
        </tbody>
      </table>
    </body>
  </html>
</xsl:template>

<xsl:template match="site">
  <tr>
    <xsl:apply-templates select="name[@language='english']"/>
    <xsl:apply-templates select="history"/>
    <xsl:choose>
      <xsl:when test="dimensions">
        <xsl:apply-templates select="dimensions"/>
      </xsl:when>
      <xsl:otherwise>
        <td>
          N/A
        </td>
        <td>
          N/A
        </td>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates select="links/overview[@type='general']"/>
    <xsl:apply-templates select="images"/>
    <xsl:apply-templates select="notes/note[@type='notes']"/>
  </tr>
</xsl:template>

<xsl:template match="name[@language='english']">
  <td>
    <xsl:value-of select="."/>
  </td>
</xsl:template>

<xsl:template match="history">
  <td>
    <xsl:value-of select="year"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="year/@era"/>
  </td>
  <td>
    <xsl:value-of select="./dynasty"/>
  </td>
  <td>
    <xsl:choose>
      <xsl:when test="year[@range='end']">
        <xsl:value-of select="2020 - year[@range='start']"/>
      </xsl:when>
      <xsl:otherwise>
       <xsl:value-of select="2020 - year[@range='start']"/>
      </xsl:otherwise>
    </xsl:choose>
  </td>
</xsl:template>

<xsl:template match="dimensions">
  <td>
    approx. <xsl:value-of select="ceiling(./width * ./width)"/> m<sup>2</sup>
  </td>
  <td>
    avg. height <xsl:value-of select="sum(./height) div count(./height)"/>
  </td>
</xsl:template>

<xsl:template match="links/overview[@type='general']">
  <td>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="./@url"/>
      </xsl:attribute>
      <xsl:value-of select="translate(., 'w', 'W')"/>
    </a>
  </td>
</xsl:template>

<xsl:template match="images">
  <td><xsl:value-of select="count(./image)"/></td>
  <td>
    <a href=""><xsl:value-of select="image[@type='jpg'][position() = last()]"/></a>
  </td>
</xsl:template>

<xsl:template match="notes/note[@type='notes']">
  <td>
    <xsl:value-of select="substring(.,1,75)"/>
    ...
  </td>
</xsl:template>

</xsl:stylesheet>