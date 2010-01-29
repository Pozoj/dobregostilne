module SpotsHelper
  def format_category(cat, type)
    category = ""
    image = (type == 1) ? "apple" : "star"
    cat.times { category += image_tag("icons/#{image}.gif") }    
    if cat < 5
      (5-cat).times { category += image_tag("icons/#{image}_no.gif") }
    end
    category
  end
end
