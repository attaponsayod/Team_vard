{% macro capitalize_firs_letter(column) %}
case
    when {{column }} IS NULL THEN NULL
    ELSE UPPER(substr({{column}}, 1, 1)) || lower(substr({{column}}, 2)) 
end
{% endmacro %}