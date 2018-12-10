class TagBuilder
  def with_name(name)
    @name = name
  end

  def with_attributes(attributes)
    @attributes = attributes
  end

  def with_content(content)
    @content = content
  end

  def prettify
    @pretty = true
  end

  def build
    tokens = []

    if self_closing_tag?
      tokens << "<#{@name}#{attributes}/>"
    else
      tokens << "<#{@name}#{attributes}>"
      tokens << @content
      tokens << "</#{@name}>"
    end

    prettify_tokens!(tokens) if @pretty

    tokens.join
  end

  private

  def self_closing_tag?
    @content.nil?
  end

  def prettify_tokens!(tokens)
    unless self_closing_tag?
      tokens[1] = tokens[1].split("\n")
      .map { |line| "  #{line}" }
      .join("\n")
    end

    tokens.map! { |token| "#{token}\n"  }
  end

  def attributes
    @attributes.map { |k, v| " #{k}='#{v}'" }.join
  end
end 
