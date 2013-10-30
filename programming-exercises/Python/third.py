import copy

class Component:
  pass


class TextComponent(Component):
  
  def __init__(self, text):
    self.text = text

  def toString(self):
    return self.text

class NumberComponent(Component):
  
  def __init__(self, number):
    self.number = number

  def toString(self):
    return str(self.number)

class DateComponent(Component):
  
  def __init__(self, date):
    self.date = date

  def toString(self):
    return self.date

class CompositeComponent(Component):
  
  def __init__(self):
    self.listComponents = list()
  
  def add(self, component):
    if isinstance(component,Component):
      self.listComponents.append(copy.deepcopy(component))
    else:
      raise NameError("No component type")

  def size(self):
    return len(self.listComponents)

  def modify(self, index, component):
    if isinstance(component,Component):
      self.listComponents[index]=component
    else:
      raise NameError("No component type")

  def toString(self):
    string = ''
    for element in self.listComponents:
      string += element.toString()
    return string


p = CompositeComponent()
p.add(TextComponent("String. Number:"))
p.add(NumberComponent(1))
p.add(TextComponent("\n"))
p.add(TextComponent("Date:"))
p.add(DateComponent("02/02/02"))
p.add(TextComponent("\n"))
d = CompositeComponent()
d.add(TextComponent("Testing composite"))
d.add(TextComponent("\n"))
d.add(p)
del p
d.add(TextComponent("End testing composite"))

print d.toString()

print '----------------------'
d.modify(0,TextComponent("beginning modified"))

print d.toString()
