# encoding: utf-8

module MiddlemanHelpers

  TITLE = 'Prototype'
  TITLE_SEPARATOR = ' — '

  def meta_title_full(application_name = TITLE)
    clean_separator "#{meta_title}#{TITLE_SEPARATOR}#{application_name}", TITLE_SEPARATOR
  end

  def meta_title(title = nil)
    content_for_separator :meta_title, title, TITLE_SEPARATOR
  end

  def meta_description(desc = nil)
    content_for_separator :meta_description, desc, ' '
  end

  def meta_picture(picture = nil)
    content_for_separator :meta_picture, picture, ''
  end

  def meta_keywords(keywords = nil)
    content_for_separator :meta_keywords, keywords, ' '
  end

  def meta_robots(text = nil)
    content_for_separator :meta_robots, klass, ','
  end

  def body_class(klass = nil)
    content_for_separator :body_class, klass, ' '
  end

  def content_for?(key)
    key = key.to_sym
    @_content_for ||= {}
    @_content_for[key] ||= []
    @_content_for[key].any?
  end

  def content_for(key, content = nil, &block)
    key = key.to_sym
    @_content_for ||= {}
    @_content_for[key] ||= []

    content = yield if block_given?
    if content
      @_content_for[key] << content
      nil
    else
      @_content_for[key].join
    end
  end


  # = render "partials/menu", :locals => {:mylocale => 'un'}
  # = render :partial => "partials/menu", :locals => {:mylocale => 'deux'}
  # = render :slim, "partials/menu", :locals => {:mylocale => 'trois'}
  # = render :slim, :partial => "partials/menu", :locals => {:mylocale => 'quatre'}
  def render(engine, data = nil, options = {}, &block)
    engine, options = nil, engine   if engine.is_a? Hash
    data, options   = nil, data     if data.is_a? Hash
    engine, data    = nil, engine   unless data

    options[:locals] ||= {}
    data = options.delete(:partial) if options[:partial]
    engine ||= :slim

    data = data.to_s
    data = data.gsub(%r{/([^/]+)$}, '/_\\1') unless data.match(%r{/_[^/]+$})

    super engine, data, options, &block
  end

  private

  def content_for_separator(key, value = nil, separator = nil)
    if value
      value = "#{value}#{separator}"
      content_for(key, value.to_s)
    else
      clean_separator content_for(key), separator
    end
  end

  def clean_separator(value, separator)
    value = strip_tags(value.to_s)

    if separator
      escaped_separator = Regexp.escape(separator)
      value.gsub!("\n", ' ')
      value.gsub!(/(#{escaped_separator}){2,}/, separator)
      value.gsub!(/\A(#{escaped_separator})/, ' ')
      value.gsub!(/(#{escaped_separator})\Z/, ' ')
    end

    value = value.gsub(/\s+/, ' ').strip
    value.blank? ? nil : value
  end

  def period(period_start, period_end)
    months_fr = { "January" => "janvier",
                  "February" => "février",
                  "March" => "mars",
                  "April" => "avril",
                  "May" => "mai",
                  "June" => "juin",
                  "July" => "juillet",
                  "August" => "août",
                  "September" => "septembre",
                  "October" => "octobre",
                  "November" => "novembre",
                  "December" => "décembre" }

    start_day   = period_start.strftime('%d')
    start_month = period_start.strftime('%B')
    start_year  = period_start.strftime('%Y')

    end_day   = period_end.strftime('%d')
    end_month = period_end.strftime('%B')
    end_year  = period_end.strftime('%Y')

    text = "Du #{start_day}"

    if start_month != end_month
      text += " #{months_fr[start_month]}"
    end

    if start_year != end_year
      text += " #{start_year}"
    end

    text += " au #{end_day} #{months_fr[end_month]} #{end_year}"

    return text
  end

  def date(date)
    months_fr = { "January" => "janvier",
                  "February" => "février",
                  "March" => "mars",
                  "April" => "avril",
                  "May" => "mai",
                  "June" => "juin",
                  "July" => "juillet",
                  "August" => "août",
                  "September" => "septembre",
                  "October" => "octobre",
                  "November" => "novembre",
                  "December" => "décembre" }

    day   = date.strftime('%d')
    month = date.strftime('%B')
    year  = date.strftime('%Y')
    text  = "#{day} #{months_fr[month]} #{year}"

    return text
  end

end
