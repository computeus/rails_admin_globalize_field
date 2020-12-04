# frozen_string_literal: true

module RailsAdminGlobalizeField
  class Tab
    LABEL_KEY = 'admin.globalize_field.tab_label'

    attr_reader :locale, :translation, :dummy_id

    def initialize(locale, translation, validate: true)
      @locale = locale
      @translation = translation
      @validate = validate
      @dummy_id = translation.translated_model.present? ? translation.translated_model.id : rand(1000000)
    end

    def id
      ['pane', translation.model_name.param_key, dummy_id, locale].join('-')
    end

    def label
      if I18n.exists?(LABEL_KEY, locale: locale)
        I18n.t(LABEL_KEY, locale: locale)
      else
        locale
      end
    end

    def active!
      @active = true
    end

    def active?
      @active
    end

    def valid?
      !@validate || translation.valid?
    end

    def invalid?
      !valid?
    end
  end
end
