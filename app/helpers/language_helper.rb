module LanguageHelper
  def current_language
    t("head.language_#{current_locale}")
  end
  
  def language(l)
    t("head.language_#{l}")
  end
end