class Component{


}

class TextComponent extends Component{
  def text

  TextComponent(textv){
    text=textv
  }

  String toString(){
    text
  }

}

class NumberComponent extends Component {
  def number

  NumberComponent(numberv){
    number=numberv
  }

  String toString(){
    number
  }
}

class DateComponent extends Component{
  def date

  DateComponent(datev){
    date=datev
  }

  String toString(){
    date
  }
}

class CompositeComponent extends Component{
  def components = []
  def add( Component component){
    components << component
  }

  def size(){
    components.size()
  }

  def modify(index, Component component){
    components[index]=component
  }

  String toString(){
    def string=''
    components.each{
      string += it
    }
    string
  }
}
  

textcomponent = new TextComponent("sfa")
numbercomponent = new NumberComponent(2)
datecomponent = new DateComponent("2/2/13")
p = new CompositeComponent()
p.add(new TextComponent("String. Number:"))
p.add(new NumberComponent(1))
p.add(new TextComponent("\n"))
p.add(new TextComponent("Date:"))
p.add(new DateComponent("25/4/13"))
p.add(new TextComponent("\n"))
d = new CompositeComponent()
d.add(new TextComponent("Testing composite"))
d.add(new TextComponent("\n"))
d.add(p)
p = null
println d
d.modify(0, new TextComponent("Beggining modified"))
println d

println 'THE REST'
println textcomponent
println numbercomponent
println datecomponent

