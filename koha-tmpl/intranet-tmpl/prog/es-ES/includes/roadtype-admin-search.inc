<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Roads Resident Search Box -->
<div id="header_search">
 <div id="roadtype_search" class="residentsearch ui-tabs-panel">
 <p class="tip">Búsqueda de tipo de camino:</p>
 <form action="[% script_name %]" method="post">
 <input type="text" name="road_type" value="[% searchfield %]" size="40" />
 <input type="submit" name="submit" value="OK" class="submit" />
 </form>
 </div>

 [% INCLUDE 'patron-search-box.inc' %] [% IF ( CAN_user_catalogue ) %] <div id="catalog_search" class="residentsearch">
 <p class="tip">Ingrese palabras clave para la búsqueda:</p>
 <form action="/cgi-bin/koha/catalogue/search.pl"  method="get" id="cat-search-block">
 <input value="" name="q" type="text" id="search-form" title="Ingrese los términos de búsqueda." class="form-text" size="40" />
 <input value="Enviar" type="submit" class="submit" />
 </form>
 </div>

 [% END %] <ul>
 <li><a href="#roadtype_search">Buscar tipos de caminos</a></li>
 [% IF ( CAN_user_circulate ) %]<li><a href="#circ_search">Préstamo</a></li>[% END %] [% IF ( CAN_user_catalogue ) %]<li><a href="#catalog_search">Buscar en el catálogo</a></li>[% END %] </ul> 
</div>
</div>
<!-- End Roads Resident Search Box -->