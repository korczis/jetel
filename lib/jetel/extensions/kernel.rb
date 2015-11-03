require 'pathname'

module Kernel
  def qualified_const_get(str)
    str.split('::').inject(Object) do |a, e|
      a.const_get(e)
    end
  end
end
