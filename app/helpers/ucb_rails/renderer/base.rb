# Base class for helper objects inspired by http://railscasts.com/episodes/101-refactoring-out-helper-object
#
# Use of such classes is indicated when you have:
#
# * helper methods calling each other, especially if ...
# * helper methods are passing around variables (which will become instance variables) 
# * the same case/if logic in many methods, indicating a requirement for class hierarchy
#
# Your helper class's methods can just do calculations which are subsituted into
# html in the views, or the methods can generate html as well.  This is helpful
# when the html is conditional on some other object's state.
#
# You have access to all the helper methods available to the view that creates
# the instance.
#
# Implementing helper classes should inherit from Renderer::Base and the template
# instance should be passed as an argument to the constructor.
#
#   # app/helpers/renderer/my_renderer.rb
#   class MyRenderer < Renderer::Base
#   ...
#   end
#
#   # app/views/a_controller/a_view.html.erb
#   <% renderer = MyRenderer.new(self) %>   # must pass in template
#   ...
#   <div>
#     <%= renderer.div_content %>
#   </div>
class UcbRails::Renderer::Base
  
  # Holds reference to view template
  attr_accessor :template
  
  # Options to pass to renderer
  attr_accessor :options
  
  # Returns new instance of renderer.  The _template_ argument is the view template.
  def initialize(template, options = {})
    self.template = template
    self.options = options
  end
  
  private
  
  # Method missing sends all calls to template instance.  This techniuqe
  # provides access to helper methods available to the template.
  def method_missing(*args, &block)
    template.send(*args, &block)
  end

end