module ElementComponent
  class Form < Element
    def initialize
      super 'form', closing_tag: false

      add_attribute :method, 'GET'
      add_attribute :action, '/'
    end
  end
end
