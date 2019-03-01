require 'byebug'

class Array

   def my_each(&block)
     self.length.times do |i|
       block.call(self[i])
     end
     self
   end

   def my_select(&block)
     results = []
     self.my_each do |ele|
       results << ele if block.call(ele)
     end
     results
   end

   def my_reject(&block)
     results = []
     self.my_each do |ele|
       results << ele if !block.call(ele)
     end
     results

   end

   def my_any?(&block)

     self.my_each do |ele|
       return true if block.call(ele)
     end
     false
   end



   def my_all?(&block)
     self.my_each do |ele|
       return false if !block.call(ele)
     end
     true
   end

    def my_flatten
        results = []
        self.each do |ele|
            if ele.instance_of?(Array)
                results = results + ele.my_flatten
            else
                results << ele
            end
        end
        results
    end

    def my_zip(*args)
      answer = Array.new(self.length) {Array.new(args.length + 1) {|ele| ele = nil}}
      input = [self, *args]
      input.each.with_index do |subarray, idx1|
        subarray.each.with_index do |el, idx2|
            if idx2 <= self.length - 1
                answer[idx2][idx1] = el
            end
        end 
      end 
      answer
    end 

    def my_rotate(n=1)
        if n > 0
            n.times do 
                shifted = self.shift
                self << shifted
            end
        elsif n < 0
            (-n).times do 
                popped = self.pop
                self.unshift(popped)
            end
        end
    
        self 
    end

    def my_join(separator="")
      answer = ""
      self.each do |ele|
        if answer == ""
          answer += ele
        else
          answer += separator + ele 
        end
      end 

      answer
    end

    def my_reverse
        results = []
        self.each do |ele|
            results = [ele] + results

        end
        results
    end



end

