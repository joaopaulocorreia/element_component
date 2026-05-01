module ElementComponent
  class Notification < Element
    attr_reader :icon, :title, :message

    VARIANTS = [ :danger, :success ]

    def initialize
      super('div', class: 'notification')

      @icon = element 'i', class: 'fa-solid fa-eye'

      @title = element 'strong', class: 'text-black font-bold'
      @title.add_content 'Login'

      @message = element 'div', class: 'bg-red-300 text-red-800'
      @message.add_content 'Login e/ou senha incorretos OASKJDOKSDOKSD'

      add_content @icon
      add_content @title
      add_content @message
    end

    def variant(var)
      case var
      in :success
        set_icon('fa-solid fa-minus')
        add_attribute class: 'notification-success'
      in :danger
        set_icon('fa-solid fa-plus')
        add_attribute class: 'notification-danger'
      end
    end

    def around_render
      puts 'BEFORE_RENDER'
      html = yield
      puts html
      html << 'HTML FINAL'
      puts 'AFTER_RENDER'
    end

    private

    def set_icon(icon)
      @icon.add_attribute! class: icon
    end
  end
end
