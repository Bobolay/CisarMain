module LoadData

  def self.compute_data(resources_data, defaults = [])
    if defaults.present?
      puts "LoadData.load_resources: defaults: #{defaults.inspect}"
      defaults.each_with_index do |entry, index|
        resource_data = resources_data[index] || {}
        resources_data[index] = (entry.deep_merge(resource_data)).deep_stringify_keys
      end
    end

    resources_data
  end

  def self.load_resources(resource_name, associations = {}, defaults = [])
    if resource_name.is_a?(String)
      resource_class = Object.const_get(resource_name.classify)
    else
      resource_class = resource_name
      resource_name = resource_class.name.underscore
    end



    project_attachment_keys = resource_class.try(:attachment_definitions).keys rescue []
    default_attributes = { published: "t" }.deep_stringify_keys
    pluralized_resource_name = resource_name.pluralize
    resources_data = YAML.load(File.open(Rails.root.join("db/seeds.#{pluralized_resource_name}.yml").to_s))[pluralized_resource_name] rescue []

    resources_data = self.compute_data(resources_data, defaults)




    resources_data.each_with_index do |project_data, index|
      normalized_project_data = project_data
      attachment_file_names = Hash[project_attachment_keys.map do |k, v|
        file_name = "#{index + 1}.*"
        if normalized_project_data.has_key?(k.to_s)
          data_file_name = normalized_project_data.delete(k.to_s)
          file_name = data_file_name if data_file_name.present?
        end


        full_file_name = Rails.root.join("db/data/#{pluralized_resource_name}/#{k}/", file_name).to_s
        existsing_file_names = Dir["#{full_file_name}"]


        if existsing_file_names.any?
          next [k, existsing_file_names.first]
        else
          next [k, nil]
        end


      end.select{|pair| pair && pair[1].present? }]

      translations = normalized_project_data.delete("translations") || {}
      normalized_translations = translations.map do |k, v|
        v[:locale] = k
        v
      end
      if associations.present?
        associations.each do |k, v|

          default_attributes[k] = (rand(2) + 1).times.map{ v.sample  }.uniq
        end
      end

      normalized_project_data = default_attributes.merge(normalized_project_data)

      p = resource_class.new(normalized_project_data)
      if normalized_translations.present?
        normalized_translations.each do |t|
          p.translations.new(t)
        end
      end
      puts "attachment_file_names: ", attachment_file_names.inspect
      attachment_file_names.each do |attachment_name, file_name|

        p.send("#{attachment_name}=", File.open(file_name)) rescue nil
      end

      p.save
      # p.translations.each do |t|
      #   #t.try(:initialize_url_fragment)
      # end
    end
  end

  module ClassMethods
    def load_data(*args)
      LoadData.load_resources(self, *args)
    end
  end
end