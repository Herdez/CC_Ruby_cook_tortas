#programa que modela a un cocinero que produce tortas. 
#Este será un sistema que contendrá dos tipos de objetos: Torta(Torta) y Cocinando la torta(CookingTorta).

$baked_minutes = 0

class CookingTorta
  #tiempo and tortas variables are initialized
  def initialize
    @tiempo = 0
    @tortas = []
  end

  #reader attributes  of 'tiempo' and 'tortas'
  attr_reader :tiempo, :tortas

  #if tiempo greater than 4 o' clock then it produces new tortas
  def tiempo!
    @tiempo +=1
    if @tiempo > 4
      5.times do
        new_torta = Torta.new
        @tortas << new_torta
      end
    end
  end

  # Returns +true+ if the tortero has cooked tortas, +false+ otherwise
  def any_tortas?
    if @tortas.length > 0
      true
    else
      false
    end
  end

  # Returns a torta if there are any
  # Raises a NoTortasError otherwise
  def pick_an_torta!
    raise NoTortasError, "The tortero has not cooked any tortas " unless self.any_tortas?
    # torta-picking logic goes here
    return @tortas.pop
  end
  
  #Returns +true+ if the tortero can't cook tortas anymore, +false+ otherwise.
  # The max time for a tortero to cook tortas is 11
  def time_out?
    if @tiempo >= 11
      true
    else
      false
    end
  end

  #baked hours are increased
  def increase_baked_minutes(minutes)
    $baked_minutes = $baked_minutes + minutes
  end

end

#this class will be used for creating an Array with objects 'tortas' 
class Torta
  # Initializes a new torta 
  def initialize
  end

  #return +true+ if cooked hours is greater than 10, +false+ otherwise
  def burned?
    if $baked_minutes > 10
      "burned"
    elsif $baked_minutes >= 8
      "listo"
    elsif $baked_minutes >= 5
      "casi listo"
    else
      "crudo"
    end
  end
end

#Driver code

#'tortero' instance is created
tortero = CookingTorta.new

#'tortas_box' Array is initialized
tortas_box = []
#'burned_tortas', 'almost_ready' and 'raw' variable is initialized
burned_tortas = 0
almost_ready = 0
raw = 0

#'tiempo' is increased until starting to cook tortas
tortero.tiempo! until tortero.any_tortas?

puts "Is #{tortero.tiempo!} O' Clock, and tortero begin to work"
puts ""

until tortero.time_out?

  # The time we take to pick up the tortas
  minutes = rand(10)
  #'baked_minutes' variable is initialized
  tortero.increase_baked_minutes(minutes)
  
  #if no objects 'tortas' then loop is broken
  while tortero.any_tortas?
    #'torta' variable is initialized with an object 
    torta = tortero.pick_an_torta!
    #it evaluates if object 'torta' is burned or not
    if torta.burned? == "burned"
      burned_tortas += 1
    elsif torta.burned? == "listo"
      tortas_box << torta
    elsif torta.burned? == "casi listo"
      almost_ready += 1
    else
      raw += 1
    end
  end

  puts "baked minutes : * " + $baked_minutes.to_s

  puts "Hours #{tortero.tiempo} Report"
  puts "We took #{minutes} minute(s) to pick the tortas"
  puts "Tortas in the tortas_box: #{tortas_box.size}"
  puts "Burned tortas: #{burned_tortas}"
  puts "Almost ready tortas: #{almost_ready}"
  puts "Raw tortas: #{raw}"
  puts ""

  # tiempo for tortas, another hour
  tortero.tiempo!
end

puts "The tortero is tired, he can't cook more tortas!"
puts "The tortero cook #{tortas_box.size + burned_tortas + almost_ready + raw} tortas"
if burned_tortas == 0
  puts "CONGRATULATIONS NO BURNED TORTAS" 
else
  puts "We pick to late #{burned_tortas} tortas so they become burned"
end

