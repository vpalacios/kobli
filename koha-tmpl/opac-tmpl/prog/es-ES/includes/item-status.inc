[% USE KohaAuthorisedValues %]

[% IF ( item.datedue ) %]
 [% IF ( OPACShowCheckoutName ) %]
 Checked out to [% item.cardnumber %] [% item.firstname %] [% item.surname %]
 [% ELSE %]
 Checked out
 [% END %]
[% ELSIF ( item.transfertwhen ) %]
 In transit from [% item.transfertfrom %]
 to [% item.transfertto %] since [% item.transfertwhen %]
[% ELSIF ( item.waiting ) %]
 On hold
[% ELSIF ( item.wthdrawn ) %]
 Item withdrawn
[% ELSIF ( item.itemlost ) %]
 [% av_lib_include = KohaAuthorisedValues.GetByCode( 'LOST', item.itemlost, 1 ) %]
 [% IF ( av_lib_include ) %]
 [% av_lib_include %]
 [% ELSE %]
 [% IF ( item.lostimageurl ) %]
 <img src="[% item.lostimageurl %]" alt="[% item.lostimagelabel %]" title="[% item.lostimagelabel %]">
 [% ELSE %]
 Item lost
 [% END %]
 [% END %]
[% ELSIF ( item.itemnotforloan ) %]
 [% IF ( item.notforloanvalue ) %]
 [% item.notforloanvalue %] [% IF ( item.restrictedopac ) %]<span class="restricted">([% item.restrictedopac %])</span>[% END %] [% ELSE %] No disponible para préstamo [% IF ( item.restrictedopac ) %]<span class="restricted">([% item.restrictedopac %])</span>[% END %] [% END %] [% ELSIF ( item.notforloan_per_itemtype ) %] No disponible para préstamo [% IF ( item.restrictedopac ) %]<span class="restricted">([% item.restrictedopac %])</span>[% END %]
[% ELSIF ( item.damaged ) %]
 [% av_lib_include = KohaAuthorisedValues.GetByCode( 'DAMAGED', item.damaged, 1 ) %]
 [% IF av_lib_include %]
 [% av_lib_include %]
 [% ELSE %]
 Item damaged
 [% END %]
[% ELSE %]
 Available [% IF ( item.restrictedopac ) %]<span class="restricted">([% item.restrictedopac %])</span>[% END %] [% END %] 