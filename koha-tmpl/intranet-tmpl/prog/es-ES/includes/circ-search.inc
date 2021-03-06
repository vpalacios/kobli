<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Circulation Resident Search Box -->

<div id="header_search">
 [% INCLUDE 'patron-search-box.inc' %] [% IF ( CAN_user_circulate ) %] <div id="checkin_search" class="residentsearch">
 <p class="tip">Introduzca el código de barras para devolución:</p>
 <form method="post" action="/cgi-bin/koha/circ/returns.pl" autocomplete="off">
 <input name="barcode" id="ret_barcode" size="40" accesskey="r" />
 <input value="Enviar" class="submit" type="submit" />
 </form>
</div>[% END %] [% IF ( CAN_user_catalogue ) %] <div id="catalog_search" class="residentsearch">
 <p class="tip">Introduzca palabras clave para la búsqueda:</p>
 <form action="/cgi-bin/koha/catalogue/search.pl"  method="get" id="cat-search-block">
 <input type="text" name="q" id="search-form" size="40" accesskey="q" />
 <input value="Enviar" type="submit" class="submit" />
 </form>
</div>[% END %] <ul>
 [% IF ( CAN_user_circulate ) %]<li><a href="#circ_search">Préstamo</a></li>[% END %] [% IF ( CAN_user_circulate ) %]<li><a href="#checkin_search">Devolución</a></li>[% END %] [% IF ( CAN_user_catalogue ) %]<li><a href="#catalog_search">Buscar en el catálogo</a></li>[% END %] </ul> 

</div><!-- /header_search -->
</div><!-- /gradient -->
<!-- End Circulation Resident Search Box -->
