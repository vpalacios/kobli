[% IF ( opacfacets ) %] [% IF ( facets_loop ) %] <div id="search-facets">
<h4>Refinar su búsqueda</h4>
<ul>
 <li>Disponibilidad<ul><li>[% IF ( available ) %]Mostrando solamente <strong>disponible</strong> ítems. <a href="/cgi-bin/koha/catalogue/search.pl?[% query_cgi |html %][% limit_cgi_not_availablity %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by %][% END %]">Mostrar todos los ítems:</a>[% ELSE %]Limitar a <a href="/cgi-bin/koha/catalogue/search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by %][% END %]&amp;limit=available">ítems actualmente disponibles</a>[% END %]</li></ul>
 [% IF ( related ) %] <li>(búsquedas relacionadas: [% FOREACH relate IN related %][% relate.related_search %][% END %])</li>[% END %] </li>

 [% FOREACH facets_loo IN facets_loop %] <li id="[% facets_loo.type_id %]">
[% facets_loo.type_label %]
[% IF ( facets_loo.type_label_Authors ) %]Authors[% END %]
[% IF ( facets_loo.type_label_Titles ) %]Titles[% END %]
[% IF ( facets_loo.type_label_Topics ) %]Topics[% END %]
[% IF ( facets_loo.type_label_Places ) %]Places[% END %]
[% IF ( facets_loo.type_label_Series ) %]Series[% END %]
[% IF ( facets_loo.type_label_ItemTypes ) %]Item types[% END %]
[% IF ( facets_loo.type_label_Libraries ) %]Libraries[% END %]
[% IF ( facets_loo.type_label_Location ) %]Locations[% END %]
<ul>
 [% FOREACH facet IN facets_loo.facets %]<li><a href="/cgi-bin/koha/catalogue/search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by %][% END %]&amp;limit=[% facet.type_link_value %]:[% facet.facet_link_value %]" title="[% facet.facet_title_value %]">[% facet.facet_label_value %]</a> [% IF ( displayFacetCount ) %]([% facet.facet_count %])[% END %]</li>[% END %][% IF ( facets_loo.expandable ) %] <li class="showmore"><a href="/cgi-bin/koha/catalogue/search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by %][% END %][% IF ( offset ) %]&amp;offset=[% offset %][% END %]&amp;expand=[% facets_loo.expand %]#[% facets_loo.type_id %]">Mostar más</a></li>
[% END %] </ul></li>
[% END %] </ul>
</div>
[% END %] [% END %] 