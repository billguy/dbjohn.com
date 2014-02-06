module BlogsHelper

  def process(text)
    regex = /\[cc.*lang="(.+?)\](.+?)\[\/cc\]/m
    text.gsub!(regex) do
      "<pre class='brush:#{$1}'>#{$2}</pre>"
    end
    text.html_safe
  end

end
