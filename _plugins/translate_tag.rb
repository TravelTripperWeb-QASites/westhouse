require 'i18n'

module Jekyll
  class TranslateTag < Liquid::Tag
   
    def initialize(tag_name, text, tokens)      
      super
      params = text.to_s.strip.split(',')
      @token = eval(params[0].strip)
      @locale = nil
      options = params[1] ? params[1].strip : ''
      if options != ''
        options = options.split(':')
        if options[0].strip == 'locale'
          @locale = eval(options[1].strip)
        end
      end
    end

    def render(context)
      site = context.registers[:site]
      load_translations(site.source)
      locale = @locale || site.active_lang || site.default_lang || 'en'
      I18n.available_locales = site.languages || [site.default_lang || 'en']

      I18n.t @token, locale: locale
    end

    private
      def load_translations(path)
        unless I18n::backend.instance_variable_get(:@translations)
          I18n.backend.load_translations Dir[File.join(path, '_locales/*.yml')]
        end
      end
  end
end

Liquid::Template.register_tag('t', Jekyll::TranslateTag)
