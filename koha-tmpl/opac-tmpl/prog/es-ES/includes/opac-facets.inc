[% IF ( opacfacets ) %] [% IF ( facets_loop ) %] <div id="facets">
[% UNLESS ( advsearch ) %] <div id="left_search">
 [% IF ( OpacPublic ) %] <form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform">
 <h4 class="new_search">Nueva búsqueda</h4>
 <label for="masthead_search" class="left"> Buscar [% UNLESS ( OpacAddMastheadLibraryPulldown ) %] [% IF ( mylibraryfirst ) %] (en [% mylibraryfirst %] solamente)[% END %] [% END %] </label>

 <select name="idx" id="masthead_search" class="left">
 [% IF ( ms_kw ) %] <option selected="selected" value="">Catálogo</option>
 [% ELSE %] <option value="">Catálogo</option>
 [% END %] [% IF ( ms_ti ) %] <option selected="selected" value="ti">Título</option>
 [% ELSE %] <option value="ti">Título</option>
 [% END %] [% IF ( ms_au ) %] <option selected="selected" value="au">Autor</option>
 [% ELSE %] <option value="au">Autor</option>
 [% END %] [% IF ( ms_su ) %] <option selected="selected" value="su">Tema</option>
 [% ELSE %] <option value="su">Tema</option>
 [% END %] [% IF ( ms_nb ) %] <option selected="selected" value="nb">ISBN</option>
 [% ELSE %] <option value="nb">ISBN</option>
 [% END %] [% IF ( ms_se ) %] <option selected="selected" value="se">Series</option>
 [% ELSE %] <option value="se">Series</option>
 [% END %] [% IF ( ms_callnum ) %] <option selected="selected" value="callnum">Signatura topográfica</option>
 [% ELSE %] <option value="callnum">Signatura topográfica</option>
 [% END %]</select>
[% IF ( ms_value ) %] <input type="text" id = "transl1" name="q" value="[% ms_value |html %]" class="left"/><div id="translControl"></div>
[% ELSE %] <input type="text" id = "transl1" name="q" class="left"/><div id="translControl"></div>
[% END %] [% IF ( OpacAddMastheadLibraryPulldown ) %] <select name="limit" id="masthead_search" class="left">
 <option value="">Todas las bibliotecas</option>
 [% FOREACH BranchesLoo IN BranchesLoopOpac %] <option [% IF ( BranchesLoo.selected ) %]SELECTED[% END %] value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>
 [% END %] </select>
 [% ELSE %] [% IF ( opac_limit_override ) %] [% IF ( opac_search_limit ) %] <input name="limit" value="[% opac_search_limit %]" type="hidden" />
 [% END %] [% ELSE %] [% IF ( mylibraryfirst ) %] <input name="limit" value="branch:[% mylibraryfirst %]" type="hidden" />
 [% END %] [% END %] [% END %] <input value="Ir" type="submit" id="searchsubmit" class="left" />
 </form>
 </div>
[% END %] <div id="search-facets">
<h4>Refina su búsqueda</h4>
<ul>
 <li>Disponibilidad<ul><li>[% IF ( available ) %]Mostrando sólo <strong>disponible</strong> ítems<a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi_not_availablity %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html%][% END %]">Mostrar todos los ítems</a>[% ELSE %]Limitar a <a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html%][% END %]&amp;limit=available">ítems disponibles actualmente.</a>[% END %]</li></ul>
 [% IF ( related ) %] <li>(búsquedas relacionadas: [% FOREACH relate IN related %][% relate.related_search %][% END %])</li>[% END %] </li>
 
[% FOREACH facets_loo IN facets_loop %] <li id="[% facets_loo.type_id %]">
[% IF ( facets_loo.type_label_Authors ) %]Authors[% END %]
[% IF ( facets_loo.type_label_Titles ) %]Titles[% END %]
[% IF ( facets_loo.type_label_Topics ) %]Topics[% END %]
[% IF ( facets_loo.type_label_Places ) %]Places[% END %]
[% IF ( facets_loo.type_label_Series ) %]Series[% END %]
[% IF ( facets_loo.type_label_ItemTypes ) %]Item types[% END %]
[% UNLESS ( singleBranchMode ) %]
[% IF ( facets_loo.type_label_Libraries ) %]Libraries[% END %]
[% END %]
[% IF ( facets_loo.type_label_Location ) %]Locations[% END %]
<ul>
 [% FOREACH facet IN facets_loo.facets %]<li><a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html %][% END %]&amp;limit=[% facet.type_link_value %]:[% facet.facet_link_value %]" title="[% facet.facet_title_value |html %]">[% facet.facet_label_value %]</a> [% IF ( displayFacetCount ) %]([% facet.facet_count %])[% END %]</li>[% END %][% IF ( facets_loo.expandable ) %] <li class="showmore"><a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html %][% END %][% IF ( offset ) %]&amp;offset=[% offset %][% END %]&amp;expand=[% facets_loo.expand %]#[% facets_loo.type_id %]">Mostrar más</a></li>
[% END %] </ul></li>
[% END %] </ul>
</div>
[% IF ( OPACResultsSidebar ) %] <div id="opacresultssidebar">
[% OPACResultsSidebar %] </div>
[% END %] [% END %] [% END %] [% END %] 