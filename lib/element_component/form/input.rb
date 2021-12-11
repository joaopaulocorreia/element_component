module ElementComponent
  class Input < Element
    def initialize
      super('input', closing_tag: false)

      add_attribute(:type, 'text')
    end
  end
end
