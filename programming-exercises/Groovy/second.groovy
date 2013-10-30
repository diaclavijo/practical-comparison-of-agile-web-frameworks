class NumbersSet{
  def numbersMap = [:]
  NumbersSet(vector){
    vector.each{
      if (numbersMap[it]) throw new Exception('Elements repeated in the vector') 
      numbersMap[it]=true
    }
  }

  def size(){
    numbersMap.size()
  }

  def isEmpty(){
    return (numbersMap.size() == 0)
  }

  def add(number){
    if (numbersMap[number]) throw new Exception('The element is already in the vector')
    numbersMap[number] = true
  }

  def belong(number){
    numbersMap[number]
  }

  def equal(other){
    numbersMap == other.numbersMap
  }

  def subset(other){
    if (other.isEmpty()) return true
    !other.numbersMap.any{key,value ->
      !numbersMap[key]
    }
  }

  def toVector(vector){
    numbersMap.each{ key, value ->
      vector << key
    }
    return vector
  }

  def union(other){
    def unionset = numbersMap.clone()
    other.numbersMap.each{ key, value ->
      unionset[key] = true
    }
    return unionset
  }
  String toString(){
      def s_vector = 'NumberSet: ['
      numbersMap.each{key,value ->
        s_vector += key+','
      }
      
      s_vector += ']'
  }
}

println 'hello world'

anumbersetempty = new NumbersSet()

anumberset = new NumbersSet([1,2,3])
//anumberset = new NumbersSet([1,2,3,3]) throws exception
assert anumberset.size() == 3

assert (anumbersetempty.isEmpty())

//anumberset.add(1) throws exception

anumberset.add(4)

assert anumberset.size() == 4

assert anumberset.belong(4)

assert !anumberset.belong(5)

assert anumberset.equal( new NumbersSet([2,4,1,3]))

assert !anumberset.equal( new NumbersSet([2,4]))

assert anumberset.subset( new NumbersSet())

assert anumberset.subset( new NumbersSet([2,4]))

assert !anumberset.subset( new NumbersSet([2,4,6]))

assert [1,2,3,4]==anumberset.toVector([])

println anumberset.union( new NumbersSet([5,6,7]))

println anumberset.union( new NumbersSet([1,2,3]))

println anumberset.union( new NumbersSet([3,4,7]))

println anumberset.union( new NumbersSet())

print anumberset



