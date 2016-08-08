RailsAdmin::Config::Model.module_eval do
  register_instance_option :navigation_label do
    @navigation_label ||= begin
      if (parent_module = abstract_model.model.parent) != Object

        I18n.t("i18n.#{parent_module.name.underscore}", raise: true) rescue parent_module.to_s
      end
    end
  end
end