class Component
   
end

class TextComponent < Component
    attr_writer :text
    def initialize( text = nil )
        @text=text
    end
    def toString
        return @text
    end
end
class NumberComponent < Component
    attr_writer :number
    def initialize( number = nil )
        @number=number
    end
    def toString
        return @number.to_s
    end
end
class DateComponent < Component
    attr_writer :date
    def initialize( date = nil )
        @date=date
    end
    def toString
        return @date
    end
end
class CompositeComponent < Component
    def initialize
        @composite=Array.new()
    end
    def add(component)
        raise 'ERROR IT IS NOT A COMPONENT' unless component.kind_of?(Component)
        @composite.push(component)
    end
    def size
        return @composite.size
    end
    def modify(index,component)
        raise 'ERROR IT IS NOT A COMPONENT' unless component.kind_of?(Component)
        @composite[index]=component
    end
    def toString
        result=String.new()
        @composite.each{|item| result+=item.toString}
        return result
    end
end


p= CompositeComponent.new()
p.add(TextComponent.new('This is string. Next a number'))
p.add(NumberComponent.new(1))
p.add(TextComponent.new("\n"))
p.add(TextComponent.new("Date: "))
p.add(DateComponent.new("Today"))
p.add(TextComponent.new("\n"))
p.add(TextComponent.new("Yesterday:"))
p.add(DateComponent.new('yesterday'))
p.add(TextComponent.new("\n"))
d = CompositeComponent.new()
d.add(TextComponent.new('Testing composite'))
d.add(TextComponent.new("\n"))
d.add(p)
p=nil
d.add(TextComponent.new('End testing composite'))
print d.toString
d.modify(0,TextComponent.new('Beginning modified'))
print d.toString

