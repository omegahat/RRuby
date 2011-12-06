
$x = "a string"

$gi = 3
$gd = 3.1415 * 2


class A
  def initialize
    @d = 3.1415
    @i = 3
    @a = Array.new
    @a.push(1)
    @a.push("another string")
    @h = { a: 1, bc: "text", xyz: [1, 3, 9]}
    
  end
  def foo
     print @d, "\n"
     print @i, "\n"
     print @a, "\n"
     return(nil)
  end

  def bar
     return(@i)
  end
  def withArgs(x, y)
     return(x + y)
  end

  def len(x)
     return(x.length)
  end
end


def fun
  puts "you called fun"
end


class B
  def initialize(x, y)
     @x = x
     @y = y * 2
  end
end

print $x, "\n"

