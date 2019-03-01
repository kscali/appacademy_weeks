require 'byebug'
def range(beginning, ending)
  return [] if ending <= beginning
  range(beginning, ending-1) << ending-1
end

def sum(array)
  return array.first if array.length == 1 
  array.first + sum(array.drop(1))
end

def sum_arr(array)
  sum = 0
  array.each{|el| sum += el}
  sum
end

def exp1(b, n)
  return 1 if n == 0 
  b * exp1(b, n-1)
end

def exp2(b, n)
  return 1 if n == 0
  half = exp2(b, n/2)
  half_odd = exp2(b, (n-1)/2)
  if n.even?
    half * half
  else
    b * half_odd * half_odd
  end
end

#If the n == 256, about how many nested recursive steps will we run in the first case?
#=> 256 steps

#How deep will we need to recurse for the second? 
#=> depth of 256

#How many examples do you need to walk through to be confident that it works?
#=> min 2

class Array 
  def deep_dup
    arr = []
    self.each  do |el| 
      if el.is_a?(Array)
        arr << el.deep_dup
      else 
        arr << el 
      end 
    end 
    arr
  end 
end 

def fibs(n)
  return [0, 1].take(n) if n <= 2
  fib_nums = fibs(n-1)
  fib_nums << fib_nums[-1] + fib_nums[-2]
end

def fibs_i(n)
  return [0,1].take(n) if n <= 1
  fib_nums = [0, 1]
  until fib_nums.length == n
    fib_nums << fib_nums[-1] + fib_nums[-2]
  end
  fib_nums
end

def bsearch(arr, t)
  return nil if arr.length == 1 && t!= arr.first
  pivot = arr.length / 2 
  
  case 
    when t == arr[pivot]
      pivot
    when t < arr[pivot]
      bsearch(arr[0...pivot], t)
    when t > arr[pivot]
      temp = bsearch(arr[pivot..-1], t)
      if temp != nil
        temp + pivot
      else
        nil
      end
  end 
end 

class Array
  def merge_sort
    return self if self.length <= 1
    middle = self.length/2
    left = self.take(middle)
    right = self.drop(middle)
    sorted_left = left.merge_sort
    sorted_right = right.merge_sort
    merge(sorted_left,sorted_right)
  end

  def merge(arr1, arr2)
    arr = []
    until arr1.empty? || arr2.empty?
      if arr1.first < arr2.first
        arr << arr1.shift
      else
        arr << arr2.shift
      end
    end
    arr + arr1 + arr2
  end
end

def subsets(arr)
    return [] if arr.length == 0

end 



def subsets(arr)
  return [] if arr.length == 0
  arr = []
  arr << subsets(arr.drop(1))
end

def subsets(arr)
  return [] if arr.length == 0
  subsets(arr.drop(1)) << arr
end