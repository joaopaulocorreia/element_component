module ElementComponent
  class Element
    attr_reader :element, :contents, :attributes

    def initialize(element, closing_tag: true)
      @element, @closing_tag = element, closing_tag

      reset_attributes!
      reset_contents!
    end

    def add_content(content, reset: false)
      reset_contents! if reset
      @contents.push(content)

      return content
    end

    def reset_contents!
      @contents = []
    end

    def add_attribute(attribute, value, reset: false)
      reset_attributes! if reset

      if @attributes.key?(attribute.to_sym)
        return @attributes[attribute.to_sym].push(value)
      end

      return @attributes[attribute.to_sym] = [value]
    end

    # TODO: add test
    def remove_attribute_value(attribute, value)
      attributes[attribute].delete(value)
    end

    def reset_attributes!
      @attributes = {}
    end

    def render
      partial = open_tag
      @contents.each do |content|
        partial << (content.kind_of?(Element) ? content.render : content.to_s)
      end
      partial << close_tag
    end

    def to_file(file_name, directory, format: 'html')
      full_path = "#{directory}/#{file_name}.#{format}"
      File.open(full_path, 'w') { |f| f.write(render) }
    end

    private

    def open_tag
      partial = "<#{@element}"
      @attributes.to_a.inject(partial) do |acc, attr|
        acc << " #{attr[0].to_sym}=\"#{attr[1].join(' ')}\""
      end

      partial << ">"
    end

    def close_tag
      return '' unless @closing_tag

      "</#{@element}>"
    end
  end
end