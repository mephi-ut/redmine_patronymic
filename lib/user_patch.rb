# encoding: UTF-8

require_dependency 'user'

module PatronymicPluginUserPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
  end
  module InstanceMethods
    def get_patronymic
      if defined?(@patronymic)
         return @patronymic
      end
      custom_field_values.each do |v|
        if v.custom_field.attributes['name'] == 'Отчество'
          @patronymic = v.value
          return @patronymic
        end
      end
    end
  end
end

User::USER_FORMATS.merge!(
  :lastname_letterfirstname_letterpatronymicfromfirstname => {
      :string => '#{lastname} #{firstname[0,1]}#{firstname.split(/ /)[1].nil? ? "" : " #{firstname.split(/ /)[1][0,1]}"}',
      :order => %w(lastname firstname id),
      :setting_order => 8
    },
  :lastname_firstname_patronymic => {
      :string => '#{lastname} #{firstname} #{get_patronymic}',
      :order => %w(lastname firstname id),
      :setting_order => 8
    },
  :lastname_letterfirstname_letterpatronymic => {
      :string => '#{lastname} #{firstname[0,1]} #{get_patronymic.nil? ? "" : get_patronymic[0,1]}',
      :order => %w(lastname firstname id),
      :setting_order => 8
    }
)

User.send(:include, PatronymicPluginUserPatch)
