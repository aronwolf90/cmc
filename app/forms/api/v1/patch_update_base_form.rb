module Api
  module V1
    class PatchUpdateBaseForm
      include ActiveModel::Model

      class << self
        def attributes(*array)
          attr_accessor(*array)

          @attributes = array
        end

        def clazz(constant)
          @clazz = constant
        end

        def associations(array)
          @associations = array
        end

        def perform(params)
          #['Invalid'] unless valid_structure?

          ActiveRecord::Base.transaction do
            params.each do |item, index|
              case item[:op]
              when 'add' then add(item)
              when 'update' then update(item)
              when 'destroy' then destroy(item)
              end
            end
          end

          []
        end

        private

        def add(item)
          if (form = self.class.new(item[:value][:attributes])).invalid?
            return form.errors
          end

          db_entry = @clazz.new(item[:value][:attributes])
          db_entry.save!
          assigen_relationships(db_entry, item[:value][:relationships])
          []
        end

        def update(item)
          db_entry = @clazz.find(item[:value][:id])

          if (form = new(db_entry.attributes.slice(*@attributes.map(&:to_s)).merge(item[:value][:attributes]))).invalid?
            return form.errors
          end

          db_entry.update!(item[:value][:attributes])
          assigen_relationships(db_entry, item[:value][:relationships])
          []
        end

        def destroy(item)
          @clazz.find(item[:value][:id]).destroy!
        end

        def assigen_relationships(db_entry, relationships)
          relationships.each do |name, data|
            next if @associations.include?(name.to_sym)
            db_entry.send(
              name + '=', data[:data].map do |entry|
                name.singularize.capitalize.find(entry[:id])
              end
            )
          end
        end
      end
    end
  end
end
