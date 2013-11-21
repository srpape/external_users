class PopulateCustomFields < ActiveRecord::Migration
    def self.up
      external_field = self.custom_value_for UserCustomField.where( :name=>"External User" ).first
      if(!external_field)
        UserCustomField.create!(:name => 'External User', :visible => '1', :editable => false, :field_format => 'bool', :default_value => '0' )
      end
    end
    def self.down
    end
end
