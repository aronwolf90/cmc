module Administration::Board
  module Cell
    class Show < Trailblazer::Cell
      include ActionView::RecordIdentifier
      include ActionView::Helpers::FormOptionsHelper
      include SimpleForm::ActionViewExtensions::FormHelper
      include Webpacker::Helper
    end
  end
end
