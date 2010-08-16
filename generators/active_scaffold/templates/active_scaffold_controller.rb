class <%= class_name %>Controller < <%= controller_superclass %>
  active_scaffold do |config|
    config.columns = [
      <%=
        (column_names).map(&:inspect).join(', ')
      %>
    ]
    config.create.columns.exclude :id
    config.update.columns.exclude :id
    <%- association_names.each do |column_name| -%>
    config.columns[:<%= column_name %>].form_ui = :select
    <%- end -%>
  end
end
