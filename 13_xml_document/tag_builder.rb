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
    @prettify = true
  end

  def result
    tokens = []
    tokens << "<#{@name}"

    unless @attributes.nil?
      tokens << @attributes.map { |k, v| " #{k}='#{v}'" }
    end

    if @content.nil?
      tokens << '/>'
    else
      tokens << '>'
      content = @content
      
      if @prettify
        tokens << "\n"
        
        content = content.split("\n")
          .map { |line| "  #{line}" }
          .join("\n")
      end

      tokens << content
      
      if @prettify
        tokens << "\n"
      end
      
      tokens << "</#{@name}>"
    end

    tokens.join
  end
end 
