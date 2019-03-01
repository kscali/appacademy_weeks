class Card 
  
  attr_writer :value

  def initialize(value)
    @value = value 
    @face_up = false
  end

  def reveal 
    @face_up = true 
  end 

  def hide 
    @face_up = false 
  end

  def ==(card_2)
    self.value == card_2.value
  end 

  def value 
    if @face_up == true
      @value 
    end 
  end 

  def face_up?

    @face_up == true

  end

end 