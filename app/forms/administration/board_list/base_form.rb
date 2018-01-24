module Administration
  module BoardList
    class BaseForm
      include ActiveModel::Model

      attr_accessor :name

      validates :name, presence: true

      def self.model_name
        ::BoardList.model_name
      end
    end
  end
end
