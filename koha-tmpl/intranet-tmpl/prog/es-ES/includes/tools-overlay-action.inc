 <select name="overlay_action" id="overlay_action">
 [% IF ( overlay_action_replace ) %] <option value="replace"  selected="selected">
 [% ELSE %] <option value="replace">
 [% END %] Reemplace un registro existente con uno nuevo</option>
 [% IF ( overlay_action_create_new ) %] <option value="create_new" selected="selected">
 [% ELSE %] <option value="create_new">
 [% END %] Agregar registro ingresante</option>
 [% IF ( overlay_action_ignore ) %] <option value="ignore" selected="selected">
 [% ELSE %] <option value="ignore">
 [% END %] Ignorar el registro ingresante (sus ítem pueden todavía ser procesados)</option>
 </select>