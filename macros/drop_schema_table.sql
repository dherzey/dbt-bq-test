{#
    Macro to drop schemas created after a pull request. Some schemas might not
    be automatically removed after closing the PR due to permissions in the
    data warehouse.

    Run this macro using dbt run-operation
#}

{%- set project="tmhomework" -%}

{%- set to_remove = [
    {
        "type": "table",
        "dataset": "dbt_staging",
        "table": "stg_remote_data_job"
    },

    {
        "type": "table",
        "dataset": "dbt_dev",
        "table": "stg_student_private"
    },

    {
        "type": "schema",
        "dataset": "dbt_sample"
    },

    {
        "type": "null",
        "dataset": "dbt_sample"
    }

] -%}

{%- macro drop_schema_tables(project, to_remove, dry_run="true") -%}

{% if execute and dry_run=="false" %}
    {%- for path in to_remove -%}
        {%- set drop_object_sql -%}
            {% if path["type"]=="table" %}
                drop {{ path["type"] }} if exists from `{{ project }}.{{ path["dataset"] }}.{{ path["table"] }}`;
            {% elif path["type"]=="schema" %}
                drop {{ path["type"] }} if exists from `{{ project }}.{{ path["dataset"] }}`;
            {% else %}
                {{ log("Please add what object type is being removed: schema or table.") }}
            {% endif %}
        {%- endset -%}
        {% do run_query(drop_object_sql) %}
    {%- endfor -%}
{% endif %}
{% endmacro %}