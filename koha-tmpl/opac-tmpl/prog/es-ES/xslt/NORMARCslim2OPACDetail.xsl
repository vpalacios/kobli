

<!DOCTYPE stylesheet [<!ENTITY nbsp "&#160;" >]>

<!-- $Id: MARC21slim2DC.xsl,v 1.1 2003/01/06 08:20:27 adam Exp $ -->
<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:items="http://www.koha-community.org/items"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="marc items">
 <xsl:import href="NORMARCslimUtils.xsl"/>
 <xsl:output method = "html" indent="yes" omit-xml-declaration = "yes" encoding="UTF-8"/>
 <xsl:template match="/">
 <xsl:apply-templates/>
 </xsl:template>

 <xsl:template match="marc:record">

 <!-- Sysprefs -->
 <xsl:variable name="UseControlNumber" select="marc:sysprefs/marc:syspref[@name='UseControlNumber']"/>
 <xsl:variable name="SubjectModifier"><xsl:if test="marc:sysprefs/marc:syspref[@name='TraceCompleteSubfields']='1'">,complete-subfield</xsl:if></xsl:variable>
 <xsl:variable name="TraceSubjectSubdivisions" select="marc:sysprefs/marc:syspref[@name='TraceSubjectSubdivisions']"/>
 <xsl:variable name="TracingQuotesLeft">
 <xsl:choose>
 <xsl:when test="marc:sysprefs/marc:syspref[@name='UseICU']='1'">{</xsl:when>
 <xsl:otherwise>"</xsl:otherwise>
 </xsl:choose>
 </xsl:variable>
 <xsl:variable name="TracingQuotesRight">
 <xsl:choose>
 <xsl:when test="marc:sysprefs/marc:syspref[@name='UseICU']='1'">}</xsl:when>
 <xsl:otherwise>"</xsl:otherwise>
 </xsl:choose>
 </xsl:variable>
 <xsl:variable name="DisplayOPACiconsXSLT" select="marc:sysprefs/marc:syspref[@name='DisplayOPACiconsXSLT']"/>

 <xsl:variable name="leader" select="marc:leader"/>
 <xsl:variable name="leader6" select="substring($leader,7,1)"/>
 <xsl:variable name="leader7" select="substring($leader,8,1)"/>
 <xsl:variable name="controlField008" select="marc:controlfield[@tag=008]"/>
 <xsl:variable name="field019b" select="marc:datafield[@tag=019]/marc:subfield[@code='b']"/>
 <xsl:variable name="typeOf008">
 <!-- The logic here should be exactly the same for NORMARCslim2intranetDetail.xsl, NORMARCslim2intranetResults.xsl, NORMARCslim2OPACDetail.xsl and NORMARCslim2OPACResults.xsl -->
 <xsl:choose>
 <xsl:when test="$field019b='b' or $field019b='k' or $field019b='l' or $leader6='b'">Lun</xsl:when>
 <xsl:when test="$field019b='e' or contains($field019b,'ec') or contains($field019b,'ed') or contains($field019b,'ee') or contains($field019b,'ef') or $leader6='g'">FV</xsl:when>
 <xsl:when test="$field019b='c' or $field019b='d' or contains($field019b,'da') or contains($field019b,'db') or contains($field019b,'dc') or contains($field019b,'dd') or contains($field019b,'dg') or contains($field019b,'dh') or contains($field019b,'di') or contains($field019b,'dj') or contains($field019b,'dk') or $leader6='c' or $leader6='d' or $leader6='i' or $leader6='j'">Mus</xsl:when>
 <xsl:when test="$field019b='a' or contains($field019b,'ab') or contains($field019b,'aj') or $leader6='e' or $leader6='f'">Cesta</xsl:when>
 <xsl:when test="$field019b='f' or $field019b='i' or contains($field019b,'ib') or contains($field019b,'ic') or contains($field019b,'fd') or contains($field019b,'ff') or contains($field019b,'fi') or $leader6='k'">gra</xsl:when>
 <xsl:when test="$field019b='g' or contains($field019b,'gb') or contains($field019b,'gd') or contains($field019b,'ge') or $leader6='m'">Archivo</xsl:when>
 <xsl:when test="$leader6='o'">kom</xsl:when>
 <xsl:when test="$field019b='h' or $leader6='r'">trd</xsl:when>
 <xsl:when test="$field019b='j' or $leader6='a'">
 <xsl:choose>
 <xsl:when test="$leader7='a' or $leader7='c' or $leader7='m' or $leader7='p'">Lun</xsl:when>
 <xsl:when test="$field019b='j' or $leader7='b' or $leader7='s'">Por</xsl:when>
 </xsl:choose>
 </xsl:when>
 </xsl:choose>
 </xsl:variable>

 <!-- Tittel og ansvarsopplysninger -->
 <xsl:if test="marc:datafield[@tag=245]">
 <h1 class="title">
 <xsl:for-each select="marc:datafield[@tag=245]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:text> : </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">b</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='h']">
 <xsl:text> </xsl:text>
 (<xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">h</xsl:with-param>
 </xsl:call-template>) </xsl:if>
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">np</xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 </h1>
 </xsl:if>

 <!-- Author Statement -->
 <!-- 245$9 is Koha authority number --> 
 <xsl:choose>
 <xsl:when test="marc:datafield[@tag=100] or marc:datafield[@tag=110] or marc:datafield[@tag=111] or marc:datafield[@tag=700] or marc:datafield[@tag=710] or marc:datafield[@tag=711]">
 <h5 class="author">av <xsl:for-each select="marc:datafield[@tag=100 or @tag=700]">
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9]">
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=au:<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:call-template name="nameABCDQ"/></a>
 <xsl:if test="marc:subfield[@code=9]">
 <a class='authlink'>
 <xsl:attribute name="href">/cgi-bin/koha/opac-authoritiesdetail.pl?authid=<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 <img style="vertical-align:middle" height="15" width="15" src="/opac-tmpl/prog/images/filefind.png"/>
 </a>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>

 <xsl:for-each select="marc:datafield[@tag=110 or @tag=710]">
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9]">
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=au:<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute> 
 </xsl:otherwise>
 </xsl:choose>
 <xsl:call-template name="nameABCDN"/></a>
 <xsl:if test="marc:subfield[@code=9]">
 <a class='authlink'>
 <xsl:attribute name="href">/cgi-bin/koha/opac-authoritiesdetail.pl?authid=<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 <img style="vertical-align:middle" height="15" width="15" src="/opac-tmpl/prog/images/filefind.png"/>
 </a>
 </xsl:if>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>

 <xsl:for-each select="marc:datafield[@tag=111 or @tag=711]">
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9]">
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=au:<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:call-template name="nameACDEQ"/></a>
 <xsl:if test="marc:subfield[@code=9]">
 <a class='authlink'>
 <xsl:attribute name="href">/cgi-bin/koha/opac-authoritiesdetail.pl?authid=<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 <img style="vertical-align:middle" height="15" width="15" src="/opac-tmpl/prog/images/filefind.png"/>
 </a>
 </xsl:if>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>

 </xsl:for-each>
 </h5>
 </xsl:when>
 </xsl:choose>

 <xsl:if test="$DisplayOPACiconsXSLT!='0'">
 <xsl:if test="$typeOf008!=''">
 <span class="results_summary">
 <span class="label">Tipo de material: </span>
 <xsl:choose>
 <xsl:when test="$typeOf008='Mon'"><img alt="Libro" src="/opac-tmpl/lib/famfamfam/BK.png" title="Libro" /> Libro</xsl:when>
 <xsl:when test="$typeOf008='Per'"><img alt="Periódico" src="/opac-tmpl/lib/famfamfam/AR.png" title="Periódico" /> Periódico</xsl:when>
 <xsl:when test="$typeOf008='Fil'"><img alt="Archivo" src="/opac-tmpl/lib/famfamfam/CF.png" title="Archivo" /> Archivo</xsl:when>
 <xsl:when test="$typeOf008='Kar'"><img alt="Cesta" src="/opac-tmpl/lib/famfamfam/MP.png" title="Cesta" /> Cesta</xsl:when>
 <xsl:when test="$typeOf008='FV'"><img alt="Película o vídeo" src="/opac-tmpl/lib/famfamfam/VM.png" title="Película o vídeo" /> Película o vídeo</xsl:when>
 <xsl:when test="$typeOf008='Mus'"><img alt="Partitura o grabaciones de sonido" src="/opac-tmpl/lib/famfamfam/PR.png" title="Partitura o grabaciones de sonido" /> Música</xsl:when>
 <xsl:when test="$typeOf008='gra'"><img alt="Material visual" src="/opac-tmpl/lib/famfamfam/GR.png" title="Material visual" /> Material visual</xsl:when>
 <xsl:when test="$typeOf008='kom'"><img alt="Materiales variados" src="/opac-tmpl/lib/famfamfam/MX.png" title="Materiales variados" /> Materiales variados</xsl:when>
 <xsl:when test="$typeOf008='trd'"><img alt="Objetos tridimensionales" src="/opac-tmpl/lib/famfamfam/TD.png" title="Objetos tridimensionales" /> Objetos tridimensionales</xsl:when>
 </xsl:choose>
 </span>
 </xsl:if>
 </xsl:if>

 <!--Series -->
 <xsl:if test="marc:datafield[@tag=440 or @tag=490]">
 <span class="results_summary"><span class="label">Series: </span>
 <xsl:for-each select="marc:datafield[@tag=440]">
 <a href="/cgi-bin/koha/opac-search.pl?q=se:{marc:subfield[@code='a']}">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">av</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </a>
 <xsl:text> </xsl:text><xsl:call-template name="part"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 
 <xsl:for-each select="marc:datafield[@tag=490][@ind1=0]">
 <a href="/cgi-bin/koha/opac-search.pl?q=se:{marc:subfield[@code='a']}">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">av</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </a>
 <xsl:call-template name="part"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Analytics -->
 <xsl:if test="$leader7='s' or $leader7='c'">
 <span class="results_summary analytics"><span class="label">Analíticas: </span>
 <a>
 <xsl:choose>
 <xsl:when test="$UseControlNumber = '1' and marc:controlfield[@tag=001]">
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=rcn:<xsl:value-of select="marc:controlfield[@tag=001]"/>+and+(bib-level:a+or+bib-level:b)</xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=Host-item:<xsl:value-of select="translate(marc:datafield[@tag=245]/marc:subfield[@code='a'], '/', '')"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:text>Mostrar analíticas</xsl:text>
 </a>
 </span>
 </xsl:if>

 <!-- 773 - Links from child to parent -->
 <xsl:if test="marc:datafield[@tag=773]">
 <xsl:for-each select="marc:datafield[@tag=773]">
 <xsl:if test="@ind1=0">
 <span class="results_summary in"><span class="label">
 <xsl:choose>
 <xsl:when test="@ind2=' '">
 En: </xsl:when>
 <xsl:when test="@ind2=8">
 <xsl:if test="marc:subfield[@code='i']">
 <xsl:value-of select="marc:subfield[@code='i']"/>
 </xsl:if>
 </xsl:when>
 </xsl:choose>
 </span>
 <xsl:variable name="f773">
 <xsl:call-template name="chopPunctuation"><xsl:with-param name="chopString"><xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a_t</xsl:with-param>
 </xsl:call-template></xsl:with-param></xsl:call-template>
 </xsl:variable>
 <xsl:choose>
 <xsl:when test="$UseControlNumber = '1' and marc:subfield[@code='w']">
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=Control-number:<xsl:call-template name="extractControlNumber"><xsl:with-param name="subfieldW" select="marc:subfield[@code='w']"/></xsl:call-template></xsl:attribute>
 <xsl:value-of select="translate($f773, '()', '')"/>
 </a>
 <xsl:if test="marc:subfield[@code='g']"><xsl:text> </xsl:text><xsl:value-of select="marc:subfield[@code='g']"/></xsl:if>
 </xsl:when>
 <xsl:when test="marc:subfield[@code='0']">
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-detail.pl?biblionumber=<xsl:value-of select="marc:subfield[@code='0']"/></xsl:attribute>
 <xsl:value-of select="$f773"/>
 </a>
 </xsl:when>
 <xsl:otherwise>
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=ti,phr:<xsl:value-of select="translate($f773, '()', '')"/></xsl:attribute>
 <xsl:value-of select="$f773"/>
 </a>
 <xsl:if test="marc:subfield[@code='g']"><xsl:text> </xsl:text><xsl:value-of select="marc:subfield[@code='g']"/></xsl:if>
 </xsl:otherwise>
 </xsl:choose>
 </span>
 <xsl:if test="marc:subfield[@code='n']">
 <span class="results_summary"><xsl:value-of select="marc:subfield[@code='n']"/></span>
 </xsl:if>
 </xsl:if>
 </xsl:for-each>
 </xsl:if>

 <!-- Publisher Statement -->
 
 <xsl:if test="marc:datafield[@tag=260]">
 <span class="results_summary"><span class="label">Autor: </span>
 <xsl:for-each select="marc:datafield[@tag=260]">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">bcg</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span> 
 </xsl:if>

 <!-- Edition Statement -->
 
 <xsl:if test="marc:datafield[@tag=250]">
 <span class="results_summary"><span class="label">Número: </span>
 <xsl:for-each select="marc:datafield[@tag=250]">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Description -->
 
 <xsl:if test="marc:datafield[@tag=300]">
 <span class="results_summary"><span class="label">Descripción: </span>
 <xsl:for-each select="marc:datafield[@tag=300]">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abceg</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <abbr class="unapi-id" title="koha:biblionumber:{marc:datafield[@tag=999]/marc:subfield[@code='c']}" ><!-- unAPI --></abbr>

 <xsl:if test="marc:datafield[@tag=020]">
 <span class="results_summary"><span class="label">ISBN: </span>
 <xsl:for-each select="marc:datafield[@tag=020]">
 <xsl:variable name="isbn" select="marc:subfield[@code='a']"/>
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=022]">
 <span class="results_summary"><span class="label">ISSN: </span>
 <xsl:for-each select="marc:datafield[@tag=022]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Other Title Statement -->

 <xsl:if test="marc:datafield[@tag=246]">
 <span class="results_summary"><span class="label">Título paralelo: </span>
 <xsl:for-each select="marc:datafield[@tag=246]">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abhfgnp</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Uniform Title Statement -->

 <xsl:if test="marc:datafield[@tag=130]|marc:datafield[@tag=240]|marc:datafield[@tag=730][@ind2!=2]">
 <span class="results_summary"><span class="label">Título estándar; </span>
 <xsl:for-each select="marc:datafield[@tag=130]|marc:datafield[@tag=240]|marc:datafield[@tag=730][@ind2!=2]">
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield">
 <xsl:if test="(contains('adfklmor',@code) and (not(../marc:subfield[@code='n' or @code='p']) or (following-sibling::marc:subfield[@code='n' or @code='p'])))">
 <xsl:value-of select="text()"/>
 <xsl:text> </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </xsl:variable>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="substring($str,1,string-length($str)-1)"/>
 
 </xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Subjects -->

 <xsl:if test="marc:datafield[substring(@tag, 1, 1) = '6']">
 <span class="results_summary subjects"><span class="label">Temas: </span>
 <xsl:for-each select="marc:datafield[substring(@tag, 1, 1) = '6']">
 <a>
 <xsl:choose>
 <!-- Will implement this later
 <xsl:when test="marc:subfield[@code=9] and $UseAuthoritiesForTracings='1'">
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 </xsl:when>
 -->
 <xsl:when test="$TraceSubjectSubdivisions='1'">
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=<xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcdvxyz</xsl:with-param>
 <xsl:with-param name="delimeter"> Y</xsl:with-param>
 <xsl:with-param name="prefix">(su<xsl:value-of select="$SubjectModifier"/>:<xsl:value-of select="$TracingQuotesLeft"/></xsl:with-param>
 <xsl:with-param name="suffix"><xsl:value-of select="$TracingQuotesRight"/>) </xsl:with-param>
 </xsl:call-template>
 </xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=su<xsl:value-of select="$SubjectModifier"/>:<xsl:value-of select="$TracingQuotesLeft"/><xsl:value-of select="marc:subfield[@code='a']"/><xsl:value-of select="$TracingQuotesRight"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcdvxyz</xsl:with-param>
 <xsl:with-param name="subdivCodes">vxyz</xsl:with-param>
 <xsl:with-param name="subdivDelimiter">-- </xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </a>
 <xsl:if test="marc:subfield[@code=9]">
 <a class='authlink'>
 <xsl:attribute name="href">/cgi-bin/koha/opac-authoritiesdetail.pl?authid=<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 <img style="vertical-align:middle" height="15" width="15" src="/opac-tmpl/prog/images/filefind.png"/>
 </a>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="position()=last()"></xsl:when>
 <xsl:otherwise> | </xsl:otherwise>
 </xsl:choose>

 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=856]">
 <span class="results_summary"><span class="label">Recurso en línea: </span>
 <xsl:for-each select="marc:datafield[@tag=856]">
 <a><xsl:attribute name="href"><xsl:value-of select="marc:subfield[@code='u']"/></xsl:attribute>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code='y' or @code='3' or @code='z']">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">y3z</xsl:with-param>
 </xsl:call-template>
 </xsl:when>
 <xsl:when test="not(marc:subfield[@code='y']) and not(marc:subfield[@code='3']) and not(marc:subfield[@code='z'])">
 Haga clic aquí para acceder</xsl:when>
 </xsl:choose>
 </a>
 <xsl:choose>
 <xsl:when test="position()=last()"></xsl:when>
 <xsl:otherwise> | </xsl:otherwise>
 </xsl:choose> 
 </xsl:for-each>
 </span>
 </xsl:if>
 
 <!-- NORMARC does not define indicators for 505
 <xsl:if test="marc:datafield[@tag=505]">
 <xsl:for-each select="marc:datafield[@tag=505]">
 <span class="results_summary"><span class="label">
 <xsl:choose>
 <xsl:when test="@ind1=0">
 Contents:
 </xsl:when>
 <xsl:when test="@ind1=1">
 Incomplete contents:
 </xsl:when>
 <xsl:when test="@ind1=1">
 Partial contents:
 </xsl:when>
 </xsl:choose> 
 </span>
 <xsl:choose>
 <xsl:when test="@ind2=0">
 <xsl:for-each select="marc:subfield[@code='t']">
 <xsl:value-of select="marc:subfield[@code=t]"/> <xsl:value-of select="marc:subfield[@code=r]"/>
 </xsl:for-each> 
 </xsl:when>
 <xsl:otherwise>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">au</xsl:with-param>
 </xsl:call-template>
 </xsl:otherwise>
 </xsl:choose>
 </span>
 </xsl:for-each>
 </xsl:if>
 -->
 <xsl:if test="marc:datafield[@tag=505]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 
 <!-- 780 -->
 <xsl:if test="marc:datafield[@tag=780]">
 <xsl:for-each select="marc:datafield[@tag=780]">
 <span class="results_summary"><span class="label">
 <xsl:choose>
 <xsl:when test="@ind2=0">
 Continuación de: </xsl:when>
 <xsl:when test="@ind2=1">
 Continuación parcial de: </xsl:when>
 <xsl:when test="@ind2=2">
 Reemplazo: </xsl:when>
 <xsl:when test="@ind2=3">
 Recambio de piezas: </xsl:when>
 <xsl:when test="@ind2=4">
 Fusión de: ... , y ...</xsl:when>
 <xsl:when test="@ind2=5">
 Ha tomado: </xsl:when>
 <xsl:when test="@ind2=6">
 Ha dirigido en parte: </xsl:when>
 <xsl:when test="@ind2=7">
 Separado de: </xsl:when>
 </xsl:choose>
 </span>
 <xsl:variable name="f780">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a_t</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=<xsl:value-of select="translate($f780, '()', '')"/></xsl:attribute>
 <xsl:value-of select="translate($f780, '()', '')"/>
 </a>
 </span>
 
 <xsl:choose>
 <xsl:when test="@ind1=0">
 <span class="results_summary"><xsl:value-of select="marc:subfield[@code='n']"/></span>
 </xsl:when>
 </xsl:choose>

 </xsl:for-each>
 </xsl:if>

 <!-- 785 -->
 <xsl:if test="marc:datafield[@tag=785]">
 <xsl:for-each select="marc:datafield[@tag=785]">
 <span class="results_summary"><span class="label">
 <xsl:choose>
 <xsl:when test="@ind2=0">
 Continuación de: </xsl:when>
 <xsl:when test="@ind2=1">
 Continúa en parte: </xsl:when>
 <xsl:when test="@ind2=2">
 Seguido por: </xsl:when>
 <xsl:when test="@ind2=3">
 En parte por la siguiente: </xsl:when>
 <xsl:when test="@ind2=4">
 Acceso a: </xsl:when>
 <xsl:when test="@ind2=5">
 En parte ha ido a: </xsl:when>
 <xsl:when test="@ind2=6">
 Continuada por: ... y ... </xsl:when>
 <xsl:when test="@ind2=7">
 Se fusionó con: .., hasta: ... </xsl:when>
 </xsl:choose>
 </span>
 <xsl:variable name="f785">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a_t</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>

 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=<xsl:value-of select="translate($f785, '()', '')"/></xsl:attribute>
 <xsl:value-of select="translate($f785, '()', '')"/>
 </a>

 </span>
 </xsl:for-each>
 </xsl:if>

 </xsl:template>

 <xsl:template name="part">
 <xsl:variable name="partNumber">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="axis">n</xsl:with-param>
 <xsl:with-param name="anyCodes">n</xsl:with-param>
 <xsl:with-param name="afterCodes">fghkdlmor</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:variable name="partName">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="axis">p</xsl:with-param>
 <xsl:with-param name="anyCodes">p</xsl:with-param>
 <xsl:with-param name="afterCodes">fghkdlmor</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:if test="string-length(normalize-space($partNumber))">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="$partNumber"/>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="string-length(normalize-space($partName))">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="$partName"/>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>

 <xsl:template name="specialSubfieldSelect">
 <xsl:param name="anyCodes"/>
 <xsl:param name="axis"/>
 <xsl:param name="beforeCodes"/>
 <xsl:param name="afterCodes"/>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield">
 <xsl:if test="contains($anyCodes, @code)      or (contains($beforeCodes,@code) and following-sibling::marc:subfield[@code=$axis])      or (contains($afterCodes,@code) and preceding-sibling::marc:subfield[@code=$axis])">
 <xsl:value-of select="text()"/>
 <xsl:text> </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"/>
 </xsl:template>
</xsl:stylesheet>
