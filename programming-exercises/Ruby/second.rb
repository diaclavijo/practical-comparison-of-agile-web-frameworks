#A hash has been chosen to represent the NumbersSet due to the fact that numbers cannot be repeated inside the set and the hash allow to test easily this feature using the numbers as keys and the values as true or false. 
class NumbersSet
    attr_reader :theNumberSet #define the attributes which are accesible from outside the class.
    
    #Constructor function. It supports 0 arguments and creates an empty NumbersSet or a vector with numbers and creates the numbers set with the numbers inside the vector. It can be created with a Hash too. 
    def initialize(vector = nil)
        @theNumberSet= Hash.new()
        if vector.kind_of?(Array)
            puts 'Initialize: arg Vector'
            vector.each(){|number|
                if @theNumberSet[number]
                    raise '**MY MESSAGE**Vector with repeated component'
                else
                    @theNumberSet[number]=true
                end
            }
        elsif vector.kind_of?(Hash)
            puts 'initialize with a hash'
            @theNumberSet=vector
        else
            puts 'initialize:EmptySet'
        end
    end
    
    def size
        return @theNumberSet.size
    end

    def isEmpty
        return @theNumberSet.empty?
    end

    def add(number)
        if @theNumberSet.include?(number) then
            raise "**MSG** NUMBER REPEATED"
        end
        @theNumberSet[number]=true
    end

    def belong(number)
        return @theNumberSet[number]
    end

    def ==(theOtherSet)
        return @theNumberSet==theOtherSet.theNumberSet
    end

    def <(theSuperSet)
        return !(
                    @theNumberSet.find{|number|
                        !(theSuperSet.belong(number[0]))
                    }
                )
    end

    def to_v()
        @theNumberSet.keys
    end

    def +(theOtherSet)
        theNewNumberSet = @theNumberSet.dup
        theOtherSet.theNumberSet.each_key{|key|
            theNewNumberSet[key]=true
        }
        return NumbersSet.new(theNewNumberSet)
    end
end


aNumberSetEmpty = NumbersSet.new();
#raise "**MSG**NO EMPTY" unless aNumberSetEmpty.isEmpty #EXCEPTION RAISED
aVector = [1,2,3,4]
aRepVector = [1,2,3,4,2]
aNumberSet = NumbersSet.new(aVector)
#aNumberSet = NumbersSet.new(aRepVector) #EXCEPTION RAISED
if aNumberSet.size != 4 then raise "**MSG**SIZE ERROR " end
unless aNumberSetEmpty.isEmpty then raise "**MSG**EMPTY ERROR " end
#aNumberSet.add(2) #EXCEPTION RAISED
aNumberSet.add(9)

unless aNumberSet.belong(9) then raise "**MSG**BELONG ERROR 9 SHOULD BELONG" end
if aNumberSet.belong(11) then raise "**MSG** BELONG ERROR" end

unless aNumberSet==NumbersSet.new([1,2,3,4,9]) then raise "**MSG** WRONG EQUAL, MUST BE TRUE" end

if aNumberSet==NumbersSet.new([1,2,3,4,8]) then raise "**MSG** FAIL IN EQUAL" end
#puts NumbersSet.new([1,2]).belong(2)
if aNumberSet<NumbersSet.new([1,2]) then raise "**MSG** FAIL IN SUBSET" end

unless NumbersSet.new([1,2])<aNumberSet then raise '**MSG** FAIL IN SUBSET' end

puts aNumberSet.to_v().inspect

equalNumberSet = NumbersSet.new([1,2,3,4,9])
almostEqualNumberSet = NumbersSet.new([1,2,3,4,6])
highNumberSet = NumbersSet.new([11,12,13,14])

puts 'UNION BEGINS'
puts (aNumberSet+highNumberSet).to_v().inspect
puts (aNumberSet+almostEqualNumberSet).to_v().inspect
puts (aNumberSet+equalNumberSet).to_v().inspect

puts aNumberSet.inspect();
