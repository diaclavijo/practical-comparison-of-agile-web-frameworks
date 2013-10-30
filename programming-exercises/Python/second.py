class NumbersSet:
  the_set = set()

  def __init__(self,vector=None):
    if vector==None:
      self.the_set = set()
    else:
      self.the_set = set (vector)

  def size(self):
    return len(self.the_set)

  def isEmpty(self):
    return len(self.the_set) == 0

  def add(self,element):
    if element in self.the_set:
      raise NameError('element is in the set')
    else:
      self.the_set.add(element)

  def belong(self,element):
    return element in self.the_set

  def equal(self, otherSet):
    return self.the_set == otherSet.the_set

  def subset(self, otherSet):
    return self.the_set < otherSet.the_set

  def vector(self):
    return list(self.the_set)

  def union(self,otherSet):
    newNumberSet = NumbersSet()
    newNumberSet.the_set = self.the_set | otherSet.the_set
    return newNumberSet
  
  

print 'hello world'
emptyNumberSet = NumbersSet()

threeNumberSet = NumbersSet([1,2,3])

assert(emptyNumberSet.size() == 0)

assert(emptyNumberSet.isEmpty())

assert(threeNumberSet.size() == 3)

threeNumberSet.add(4)



#threeNumberSet.add(3) #uncommented must throw an excepction
assert ( threeNumberSet.belong(3) )
assert ( threeNumberSet.belong(2) )
assert ( threeNumberSet.belong(1) )
assert ( not threeNumberSet.belong(5) )

#testing equal
equalNumberSet = NumbersSet([1,2,3,4])
emptyEqualNumberSet = NumbersSet()

assert ( threeNumberSet.equal(equalNumberSet) )
assert ( emptyEqualNumberSet.equal(emptyNumberSet) )

#testing subset
twoNumberSet = NumbersSet([1,2])

assert( not threeNumberSet.subset(twoNumberSet))
assert( twoNumberSet.subset(threeNumberSet))

#testing vector method
print twoNumberSet.vector()
print threeNumberSet.vector()
print emptyNumberSet.vector()

#testing union method
sixNumberSet = NumbersSet([5,6,7])
oneToSixNumberSet = NumbersSet([1,2,3,4,5,6,7])

print sixNumberSet.union(threeNumberSet).the_set
print oneToSixNumberSet.union(threeNumberSet).the_set




print threeNumberSet.the_set
