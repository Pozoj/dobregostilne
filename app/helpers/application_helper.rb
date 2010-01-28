# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper  
  def javascripts(*args)
    content_for(:head) do
     javascript_include_tag(*args)
    end
  end

  def admin_section(klass=nil, &block)
    if admin?
     concat content_tag(:div, capture(&block), :class => 'admin')
    end
  end
  
  def link_to_lightbox(string, image, album = 'album', title = '')
    ret = "<a href='#{image}' rel='lightbox[#{album}]'"
    ret += " title='#{title}'" unless title.blank?
    ret += "class='lightbox'>#{string}</a>"
  end

  # WillPaginate localization hax
  include WillPaginate::ViewHelpers 

  def will_paginate_with_i18n(collection, options = {})
    will_paginate_without_i18n(collection, options.merge(:previous_label => I18n.t(:previous), :next_label => I18n.t(:next))) 
  end 

  alias_method_chain :will_paginate, :i18n


  def destroy_confirmation(obj)
    if obj.respond_to? :title
     str = obj.title
    elsif obj.respond_to? :name
     str = obj.name
    else
     str = 'Neznani vnos'
    end

    "'#{str}' - Ste prepričani o izbrisu?"
  end

  def link_to_back(id=nil)
    content_tag :p, link_to("Nazaj", (id) ? object_path(id) : collection_path), :class => 'backlink'
  end
  
  def link_to_span(text, url)
    link_to content_tag(:span, text), url
  end
  
  def link_to_language(l)
    l = l.to_s
    klass = l
    klass += " active" if l == current_locale
    link_to content_tag(:span, t("head.language_#{l}")), {:locale => l}, :class => klass, :title => t("head.language_#{l}")
  end
  
  def title(string, header = true)
    content_for(:title) { string }
    if header
      content_tag :h1, string
    end
  end
end
